import boto3
import tempfile
import os

def transcribe_audio(audio_stream: bytes) -> str:
    # Save incoming audio to a temporary file
    with tempfile.NamedTemporaryFile(delete=False, suffix=".wav") as tmp:
        tmp.write(audio_stream)
        audio_path = tmp.name

    transcribe = boto3.client("transcribe")
    job_name = f"job-{os.path.basename(audio_path)}"
    job_uri = f"s3://your-bucket/{os.path.basename(audio_path)}"

    # NOTE: You must upload to S3 before using Transcribe
    s3 = boto3.client("s3")
    s3.upload_file(audio_path, "your-bucket", os.path.basename(audio_path))

    transcribe.start_transcription_job(
        TranscriptionJobName=job_name,
        Media={'MediaFileUri': job_uri},
        MediaFormat='wav',
        LanguageCode='en-US'
    )

    # Poll until job is done
    while True:
        status = transcribe.get_transcription_job(TranscriptionJobName=job_name)
        if status['TranscriptionJob']['TranscriptionJobStatus'] in ['COMPLETED', 'FAILED']:
            break

    if status['TranscriptionJob']['TranscriptionJobStatus'] == 'COMPLETED':
        transcript_uri = status['TranscriptionJob']['Transcript']['TranscriptFileUri']
        import requests
        transcript_json = requests.get(transcript_uri).json()
        return transcript_json['results']['transcripts'][0]['transcript']

    return "Unable to transcribe"
