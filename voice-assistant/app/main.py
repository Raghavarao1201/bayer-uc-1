from fastapi import FastAPI, Request
from fastapi.responses import StreamingResponse
from app.transcribe import transcribe_audio
from app.bedrock import get_llm_response
from app.polly import synthesize_speech
from app.followup import trigger_followup

app = FastAPI()

@app.post("/process-audio/")
async def process_audio(request: Request):
    audio_stream = await request.body()

    transcript = transcribe_audio(audio_stream)
    llm_response = get_llm_response(transcript)
    audio_output = synthesize_speech(llm_response)

    trigger_followup(transcript, llm_response)

    return StreamingResponse(content=audio_output, media_type="audio/mpeg")
