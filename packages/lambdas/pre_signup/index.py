def lambda_handler(event, context):
    print("EVENT",event)
    print("CONTEXT",context)
    # Return to Amazon Cognito
    return event