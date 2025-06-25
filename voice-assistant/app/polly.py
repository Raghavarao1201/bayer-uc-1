import boto3

def synthesize_speech(text: str) -> bytes:
    polly = boto3.client("polly")
    response = polly.synthesize_speech(
        Text=text,
        OutputFormat="mp3",
        VoiceId="Joanna"
    )
    return response["AudioStream"].read()
