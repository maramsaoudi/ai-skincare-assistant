@echo off

echo ================================
echo Starting Glowlytics full stack
echo ================================

echo.
echo Starting FastAPI...
start cmd /k "cd /d C:\Flutter_projects\face_detection_app\ai_service && uvicorn main:app --host 0.0.0.0 --port 8000"

echo.
echo Starting Spring Boot...
start cmd /k "cd /d C:\Flutter_projects\face_detection_app\backend-skincare-api && mvnw.cmd spring-boot:run"

echo.
echo Waiting for servers to start...
timeout /t 10

echo.
echo Connecting phone (ADB)...
adb devices
adb reverse tcp:8080 tcp:8080
adb reverse tcp:8000 tcp:8000

echo.
echo Starting Flutter app...
start cmd /k "cd /d C:\Flutter_projects\face_detection_app\face_detection_app && flutter run"

pause