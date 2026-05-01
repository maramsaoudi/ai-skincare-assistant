from fastapi import FastAPI, UploadFile, File
import numpy as np
import cv2

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Glowlytics AI is running"}

@app.post("/analyze")
async def analyze_skin(file: UploadFile = File(...)):
    # Read image
    image_bytes = await file.read()

    # Convert to OpenCV format
    np_arr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    # 🔥 Basic analysis (simple but real)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    brightness = np.mean(gray)

    # Fake but dynamic scores based on brightness
    oiliness = int(min(max((brightness / 255) * 100, 0), 100))
    dryness = 100 - oiliness
    acne = int(oiliness * 0.6)
    redness = int((255 - brightness) * 0.3)

    overall = int((acne + oiliness + dryness + redness) / 4)

    return {
        "overallScore": overall,
        "acne": acne,
        "oiliness": oiliness,
        "dryness": dryness,
        "redness": redness,
        "insight": "Basic AI estimation (brightness-based)"
    }