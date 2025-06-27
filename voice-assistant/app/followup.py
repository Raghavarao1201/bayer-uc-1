import boto3
import json

def trigger_followup(transcript: str, response: str):
    lambda_client = boto3.client("lambda")
    payload = json.dumps({
        "transcript": transcript,
        "response": response
    }).encode("utf-8")

    lambda_client.invoke(
        FunctionName="storeCallSummary",
        InvocationType="Event",
        Payload=payload
    )
