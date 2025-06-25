import boto3

def get_llm_response(transcript: str) -> str:
    bedrock = boto3.client("bedrock-runtime")
    response = bedrock.invoke_model(
        modelId="anthropic.claude-v3",
        body={"prompt": transcript, "max_tokens": 200}
    )
    return response["completion"]
