@echo off
echo ========================================
echo Flutter SDK 설치 가이드
echo ========================================
echo.

echo 방법 1: 자동 설치 (Chocolatey 사용)
echo ----------------------------------------
echo 1. PowerShell을 관리자 권한으로 실행
echo 2. Chocolatey 설치 (이미 있으면 건너뛰기):
echo    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo.
echo 3. Flutter 설치:
echo    choco install flutter
echo.

echo 방법 2: 수동 설치
echo ----------------------------------------
echo 1. Flutter SDK 다운로드:
echo    https://docs.flutter.dev/get-started/install/windows
echo.
echo 2. C:\flutter 폴더에 압축 해제
echo.
echo 3. 환경 변수 설정:
echo    - 시스템 속성 > 고급 > 환경 변수
echo    - Path에 C:\flutter\bin 추가
echo.
echo 4. 새 명령 프롬프트 열고 확인:
echo    flutter doctor
echo.

echo 방법 3: Flutter 없이 개발 (온라인 IDE)
echo ----------------------------------------
echo DartPad에서 온라인으로 테스트:
echo https://dartpad.dev/
echo.

pause

echo.
echo Flutter 설치 후 프로젝트 실행:
echo ----------------------------------------
echo cd app
echo flutter pub get
echo flutter run
echo.

pause