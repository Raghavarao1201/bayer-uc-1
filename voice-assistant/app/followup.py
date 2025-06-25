import boto3

def trigger_followup(transcript: str, response: str):
    lambda_client = boto3.client("lambda")
    lambda_client.invoke(
        FunctionName="storeCallSummary",
        InvocationType="Event",
        Payload=str.encode(f'{{"transcript": "{transcript}", "response": "{response}"}}')
    )
