import boto3
from typing import List, ReadOnly
from enum import Enum
from aws_lambda_powertools import Logger
from aws_lambda_powertools.utilities.typing import LambdaContext
from mypy_boto3_cognito_idp.client import CognitoIdentityProviderClient
from mypy_boto3_cognito_idp.type_defs import UserTypeTypeDef
from typing import TypedDict
from aws_lambda_powertools.utilities.data_classes.cognito_user_pool_event import (
    PreSignUpTriggerEvent,
)
import secrets

logger = Logger()

cognitoClient: CognitoIdentityProviderClient = boto3.client("cognito-idp")


class UserAttributes(TypedDict):
    GivenName: ReadOnly[str]
    FamilyName: ReadOnly[str]
    Email: ReadOnly[str]
    EmailVerified: ReadOnly[bool]


def set_user_password(user: UserTypeTypeDef, userPoolId: str):
    cognitoClient.admin_set_user_password(
        UserPoolId=userPoolId,
        Username=user["Username"],
        Password=secrets.token_urlsafe(13),
        Permanent=True,
    )


def create_user(userAttributes: UserAttributes, userPoolId: str) -> UserTypeTypeDef:
    return cognitoClient.admin_create_user(
        UserPoolId=userPoolId,
        Username=userAttributes["Email"],
        MessageAction="SUPPRESS",
        UserAttributes=[
            {"Name": "given_name", "Value": userAttributes["GivenName"]},
            {"Name": "family_name", "Value": userAttributes["FamilyName"]},
            {"Name": "email_verified", "Value": userAttributes["EmailVerified"]},
        ],
    ).get("User", [])


def get_user_by_email(email: str, userPoolId: str) -> List[UserTypeTypeDef]:
    return cognitoClient.list_users(
        UserPoolId=userPoolId, Filter=f'email = "{email}"', Limit=2
    ).get("Users", [])


def link_provider_to_user(
    user: UserTypeTypeDef, userPoolId: str, providerName: str, providerUserId: str
):
    return cognitoClient.admin_link_provider_for_user(
        UserPoolId=userPoolId,
        DestinationUser={
            "ProviderName": "Cognito",
            "ProviderAttributeValue": user["Username"],
        },
        SourceUser={
            "ProviderName": providerName,
            "ProviderAttributeName": "Cognito_Subject",
            "ProviderAttributeValue": providerUserId,
        },
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
    translatedEvent = PreSignUpTriggerEvent(event)
    triggerSource = PreSignUpTriggerSource(translatedEvent.trigger_source)
    logger.info(f"TRIGGERSOURCE {triggerSource}")
    if triggerSource == PreSignUpTriggerSource.EXTERNAL_PROVIDER:
        usersResult = get_user_by_email(
            translatedEvent.request.user_attributes["email"],
            translatedEvent.user_pool_id,
        )
        [providerName, providerUserId] = translatedEvent.user_name.split("_")
        logger.info(f"USERRESULT {usersResult}")
        if len(usersResult) > 0:
            user = usersResult[0]
            res = link_provider_to_user(
                user,
                translatedEvent.user_pool_id,
                providerName,
                providerUserId,
            )
            logger.info(f"RESULT {res}")
        else:
            user = create_user(
                UserAttributes(
                    {
                        "Email": translatedEvent.request.user_attributes["email"],
                        "FamilyName": translatedEvent.request.user_attributes[
                            "family_name"
                        ],
                        "GivenName": translatedEvent.request.user_attributes[
                            "given_name"
                        ],
                        "EmailVerified": translatedEvent.request.user_attributes[
                            "email_verified"
                        ],
                    }
                ),
                translatedEvent.user_pool_id,
            )
            set_user_password(user, translatedEvent.user_pool_id)
            res = link_provider_to_user(
                user,
                translatedEvent.user_pool_id,
                providerName,
                providerUserId,
            )
            logger.info(f"RESULT {res}")
    return event
