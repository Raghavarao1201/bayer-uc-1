import json
import boto3
import os
import uuid

s3 = boto3.client("s3")
bucket = os.environ["BUCKET_NAME"]

def lambda_handler(event, context):
    try:
        # Parse the incoming event body
        if isinstance(event, dict):
            body = event
        else:
            body = json.loads(event)

        transcript = body.get("transcript", "")
        response = body.get("response", "")

        key = f"summaries/{uuid.uuid4()}.json"
        s3.put_object(
            Bucket=bucket,
            Key=key,
            Body=json.dumps({
                "transcript": transcript,
                "response": response
            }),
            ContentType="application/json"
        )

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Call summary stored.", "key": key})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
