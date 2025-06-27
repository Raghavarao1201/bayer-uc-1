import boto3
import json

def get_llm_response(transcript: str) -> str:
    bedrock = boto3.client("bedrock-runtime")
    body = {
        "prompt": f"Customer said: {transcript}. Respond helpfully.",
        "max_tokens": 200
    }

    response = bedrock.invoke_model(
        modelId="anthropic.claude-v3",
        contentType="application/json",
        accept="application/json",
        body=json.dumps(body)
    )

    result = json.loads(response['body'].read())
    return result.get("completion", "Sorry, I didn't get that.")
