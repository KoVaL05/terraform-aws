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
            'email = "{email}"'
        ],
        Limit=2
    ).get("Users",[])

def link_provider_to_user(username: str, userPoolId: str, providerName: str, providerUserId: str, cognitoClient: CognitoIdentityProviderClient):
    cognitoClient.admin_link_provider_for_user()
    return
class PreSignUpTriggerSource(Enum):
    COGNITO_SIGNUP = "PreSignUp_SignUp"
    EXTERNAL_PROVIDER = "PreSignUp_ExternalProvider"
    UNKNOWN = "UNKNOWN"

    @classmethod
    def _missing_(cls, _value):
        return cls.UNKNOWN
    
@logger.inject_lambda_context
def handler(event: dict, context: LambdaContext):
    print("EVENT",event)
    print("CONTEXT",context)
    cognitoClient: CognitoIdentityProviderClient = boto3.client('cognito-idp')
    translatedEvent = PreSignUpTriggerEvent(event)
    triggerSource = PreSignUpTriggerEvent(translatedEvent.trigger_source)

    if triggerSource == PreSignUpTriggerSource.EXTERNAL_PROVIDER:
        usersResult = get_user_by_email(translatedEvent.request.user_attributes["email"], translatedEvent.user_pool_id, cognitoClient)
        if len(usersResult) > 0:
            [providerName,providerUserId] = translatedEvent.user_name.split("_")
        return
    return event