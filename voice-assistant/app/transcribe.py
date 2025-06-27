import boto3
import os
import uuid

def upload_audio_to_s3(audio_stream: bytes) -> str:
    s3 = boto3.client("s3")
    bucket = os.getenv("AUDIO_BUCKET")  # pulled from ECS environment variable
    key = f"calls/{uuid.uuid4()}.wav"

    s3.put_object(
        Bucket=bucket,
        Key=key,
        Body=audio_stream,
        ContentType="audio/wav"
    )

    return f"s3://{bucket}/{key}"

def transcribe_audio(audio_stream: bytes) -> str:
    s3_uri = upload_audio_to_s3(audio_stream)
    transcribe = boto3.client("transcribe")
    job_name = f"job-{uuid.uuid4()}"

    transcribe.start_transcription_job(
        TranscriptionJobName=job_name,
        Media={'MediaFileUri': s3_uri},
        MediaFormat='wav',
        LanguageCode='en-US'
    )

    while True:
        status = transcribe.get_transcription_job(TranscriptionJobName=job_name)
        if status['TranscriptionJob']['TranscriptionJobStatus'] in ['COMPLETED', 'FAILED']:
            break

    if status['TranscriptionJob']['TranscriptionJobStatus'] == 'COMPLETED':
        import requests
        transcript_url = status['TranscriptionJob']['Transcript']['TranscriptFileUri']
        result = requests.get(transcript_url).json()
        return result['results']['transcripts'][0]['transcript']

    return "Transcription failed."
