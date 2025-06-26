import json

def format_prompt(transcript: str) -> str:
    return f"Customer said: '{transcript}'. How should the assistant respond?"

def lambda_payload(transcript: str, response: str) -> bytes:
    return json.dumps({
        "transcript": transcript,
        "response": response
    }).encode("utf-8")
