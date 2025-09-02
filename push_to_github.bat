@echo off
echo GitHub에 푸시하기 위한 스크립트
echo.
echo 먼저 GitHub.com에서 'aurelia-mindscape' 레포지토리를 만드세요.
echo https://github.com/new
echo.
echo 레포지토리 생성 후 아래 명령어를 실행하세요:
echo.

echo 1. 원격 저장소 추가:
echo git remote add origin https://github.com/dugadak/aurelia-mindscape.git
echo.

echo 2. 브랜치 이름 변경 (필요시):
echo git branch -M main
echo.

echo 3. 코드 푸시:
echo git push -u origin main
echo.

echo GitHub 인증이 필요한 경우:
echo - Username: dugadak
echo - Password: Personal Access Token을 입력하세요
echo   (https://github.com/settings/tokens에서 생성)
echo.

pause