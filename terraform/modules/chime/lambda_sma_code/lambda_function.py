import json
import boto3
import os
import base64
import logging
import requests

logger = logging.getLogger()
logger.setLevel(logging.INFO)

polly = boto3.client("polly")

ECS_ENDPOINT = os.getenv("ECS_ENDPOINT")

def lambda_handler(event, context):
    logger.info("Received SIP Media App event: %s", json.dumps(event))

    # For now we handle only actions based on invocation
    invocation_event_type = event.get("InvocationEventType")

    if invocation_event_type == "NEW_INBOUND_CALL":
        logger.info("Incoming call, answering...")
        return {
            "SchemaVersion": "1.0",
            "Actions": [
                {"Type": "Pause", "Parameters": {"DurationInMilliseconds": 1000}},
                {"Type": "Speak", "Parameters": {
                    "CallId": event["CallDetails"]["Participants"][0]["CallId"],
                    "Text": "Hello, this is your AI sales agent. Please speak after the tone.",
                    "VoiceId": "Joanna",
                    "LanguageCode": "en-US"
                }}
            ]
        }

    elif invocation_event_type == "CALL_UPDATE_REQUESTED":
        logger.info("Call update requested, no action.")
        return {"SchemaVersion": "1.0", "Actions": []}

    elif invocation_event_type == "HANGUP":
        logger.info("Call ended.")
        return {"SchemaVersion": "1.0", "Actions": []}

    # Optional future: handle real-time audio here
    return {"SchemaVersion": "1.0", "Actions": []}