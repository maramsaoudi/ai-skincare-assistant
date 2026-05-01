from fastapi import FastAPI, UploadFile, File
import cv2
import numpy as np

app = FastAPI()


def clamp(value):
    return max(0, min(100, int(value)))


def empty_response(message):
    return {
        "overallScore": 0,
        "acne": 0,
        "oiliness": 0,
        "dryness": 0,
        "redness": 0,
        "insight": message
    }


def analyze_zone(zone):
    hsv = cv2.cvtColor(zone, cv2.COLOR_BGR2HSV)

    brightness = np.mean(hsv[:, :, 2])
    saturation = np.mean(hsv[:, :, 1])

    red_channel = np.mean(zone[:, :, 2])
    green_channel = np.mean(zone[:, :, 1])
    blue_channel = np.mean(zone[:, :, 0])

    redness = (red_channel - ((green_channel + blue_channel) / 2)) * 1.5
    oiliness = brightness * 0.35 + saturation * 0.25
    dryness = 100 - brightness * 0.4

    gray = cv2.cvtColor(zone, cv2.COLOR_BGR2GRAY)
    acne_score = np.std(gray) * 1.2

    return {
        "redness": clamp(redness),
        "oiliness": clamp(oiliness),
        "dryness": clamp(dryness),
        "acne": clamp(acne_score)
    }


def generate_insight(acne, oiliness, dryness, redness):
    insights = []

    if oiliness > 65:
        insights.append("High oiliness detected, especially in the T-zone.")
    elif oiliness > 40:
        insights.append("Moderate oiliness detected.")

    if dryness > 60:
        insights.append("Skin hydration seems low.")

    if redness > 50:
        insights.append("Mild redness detected on the cheeks.")

    if acne > 50:
        insights.append("Visible texture irregularities may indicate acne-prone areas.")

    if not insights:
        insights.append("Your skin looks balanced overall.")

    return " ".join(insights)


@app.post("/analyze")
async def analyze_image(image: UploadFile = File(...)):
    image_bytes = await image.read()
    np_array = np.frombuffer(image_bytes, np.uint8)
    frame = cv2.imdecode(np_array, cv2.IMREAD_COLOR)

    if frame is None:
        return empty_response("Invalid image.")

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    face_detector = cv2.CascadeClassifier(
        cv2.data.haarcascades + "haarcascade_frontalface_default.xml"
    )

    faces = face_detector.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(120, 120)
    )

    if len(faces) == 0:
        return empty_response("No face detected. Please use a clear front-facing selfie.")

    x, y, w, h = max(faces, key=lambda face: face[2] * face[3])
    face = frame[y:y + h, x:x + w]

    height, width, _ = face.shape

    forehead = face[0:int(height * 0.30), int(width * 0.25):int(width * 0.75)]
    left_cheek = face[int(height * 0.40):int(height * 0.75), 0:int(width * 0.45)]
    right_cheek = face[int(height * 0.40):int(height * 0.75), int(width * 0.55):width]
    nose = face[int(height * 0.30):int(height * 0.70), int(width * 0.35):int(width * 0.65)]

    forehead_result = analyze_zone(forehead)
    left_cheek_result = analyze_zone(left_cheek)
    right_cheek_result = analyze_zone(right_cheek)
    nose_result = analyze_zone(nose)

    oiliness = clamp((forehead_result["oiliness"] + nose_result["oiliness"]) / 2)

    redness = clamp(
        (left_cheek_result["redness"] + right_cheek_result["redness"]) / 2
    )

    dryness = clamp(
        (
            forehead_result["dryness"]
            + left_cheek_result["dryness"]
            + right_cheek_result["dryness"]
        ) / 3
    )

    acne = clamp(
        (
            forehead_result["acne"]
            + left_cheek_result["acne"]
            + right_cheek_result["acne"]
            + nose_result["acne"]
        ) / 4
    )

    overall_score = clamp(
        100 - ((acne * 0.30) + (oiliness * 0.25) + (dryness * 0.25) + (redness * 0.20))
    )

    insight = generate_insight(acne, oiliness, dryness, redness)

    return {
        "overallScore": overall_score,
        "acne": acne,
        "oiliness": oiliness,
        "dryness": dryness,
        "redness": redness,
        "insight": insight
    }