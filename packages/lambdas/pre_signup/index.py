import boto3
from typing import List
from enum import Enum
from aws_lambda_powertools import Logger
from aws_lambda_powertools.utilities.typing import LambdaContext
from mypy_boto3_cognito_idp.client import CognitoIdentityProviderClient
from mypy_boto3_cognito_idp.type_defs import UserTypeTypeDef

from aws_lambda_powertools.utilities.data_classes.cognito_user_pool_event import PreSignUpTriggerEvent

logger = Logger()

def get_user_by_email(email: str, userPoolId: str, cognitoClient: CognitoIdentityProviderClient) -> List[UserTypeTypeDef]:
    return cognitoClient.list_users(
        UserPoolId=userPoolId,
        Filter=[
            f'email = "{email}"'
        ],
        Limit=2
    ).get("Users",[])

def link_provider_to_user(username: str, userPoolId: str, providerName: str, providerUserId: str, cognitoClient: CognitoIdentityProviderClient):
    return cognitoClient.admin_link_provider_for_user(
        UserPoolId=userPoolId,
        DestinationUser={
            'ProviderName': 'Cognito',
            'ProviderAttributeValue': username
        },
        SourceUser={
            'ProviderName': providerName,
            'ProviderAttributeName': 'Cognito_Subject',
            'ProviderAttributeValue': providerUserId
        }
    )
class PreSignUpTriggerSource(Enum):
    COGNITO_SIGNUP = "PreSignUp_SignUp"
    EXTERNAL_PROVIDER = "PreSignUp_ExternalProvider"
    UNKNOWN = "UNKNOWN"

    @classmethod
    def _missing_(cls, _value):
        return cls.UNKNOWN
    
@logger.inject_lambda_context
def handler(event: dict, context: LambdaContext):
    logger.info("TEST")
    print("EVENT",event)
    print("CONTEXT",context)
    cognitoClient: CognitoIdentityProviderClient = boto3.client('cognito-idp')
    translatedEvent = PreSignUpTriggerEvent(event)
    triggerSource = PreSignUpTriggerSource(translatedEvent.trigger_source)
    logger.info(f"TRIGGERSOURCE {triggerSource}")
    if triggerSource == PreSignUpTriggerSource.EXTERNAL_PROVIDER:
        usersResult = get_user_by_email(translatedEvent.request.user_attributes["email"], translatedEvent.user_pool_id, cognitoClient)
        logger.info(f"USERRESULT {usersResult}")
        if len(usersResult) > 0:
            [providerName,providerUserId] = translatedEvent.user_name.split("_")
            res = link_provider_to_user(usersResult[0]["Username"], translatedEvent.user_pool_id, providerName, providerUserId, cognitoClient)
            logger.info(f"RESULT {res}")
    return event