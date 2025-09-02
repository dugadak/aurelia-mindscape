# 🚀 Flutter 설정 가이드

## Flutter SDK 설치

### Windows

#### 옵션 1: Chocolatey로 설치 (권장)
```powershell
# PowerShell 관리자 권한으로 실행

# 1. Chocolatey 설치 (이미 있으면 건너뛰기)
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 2. Flutter 설치
choco install flutter

# 3. 설치 확인
flutter doctor
```

#### 옵션 2: 수동 설치
1. [Flutter SDK 다운로드](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.0-stable.zip)
2. `C:\flutter`에 압축 해제
3. 시스템 환경 변수 PATH에 `C:\flutter\bin` 추가
4. 새 터미널에서 `flutter doctor` 실행

### macOS
```bash
# Homebrew로 설치
brew install --cask flutter

# 또는 수동 다운로드
cd ~/development
unzip ~/Downloads/flutter_macos_3.16.0-stable.zip
export PATH="$PATH:`pwd`/flutter/bin"
```

### Linux
```bash
# Snap으로 설치
sudo snap install flutter --classic

# 또는 수동 설치
cd ~/development
tar xf ~/Downloads/flutter_linux_3.16.0-stable.tar.xz
export PATH="$PATH:`pwd`/flutter/bin"
```

## 프로젝트 실행

### 1. 의존성 설치
```bash
cd app
flutter pub get
```

### 2. 사용 가능한 디바이스 확인
```bash
flutter devices
```

### 3. 앱 실행

#### Android 에뮬레이터
```bash
# Android Studio에서 AVD Manager로 에뮬레이터 생성
flutter run
```

#### iOS 시뮬레이터 (macOS만)
```bash
open -a Simulator
flutter run
```

#### 웹 브라우저
```bash
flutter run -d chrome
```

#### Windows 데스크톱
```bash
flutter config --enable-windows-desktop
flutter run -d windows
```

## Flutter Doctor 문제 해결

### ❌ Android toolchain 문제
```bash
# Android Studio 설치
# https://developer.android.com/studio

# Android SDK 라이센스 동의
flutter doctor --android-licenses
```

### ❌ Visual Studio 문제 (Windows)
```bash
# Visual Studio 2022 Community 설치
# "Desktop development with C++" 워크로드 선택
# https://visualstudio.microsoft.com/downloads/
```

### ❌ Xcode 문제 (macOS)
```bash
# App Store에서 Xcode 설치
# CocoaPods 설치
sudo gem install cocoapods
```

## Flutter 없이 개발하기

### 1. 온라인 IDE 사용
- [DartPad](https://dartpad.dev/) - 간단한 코드 테스트
- [FlutLab](https://flutlab.io/) - 온라인 Flutter IDE
- [Zapp](https://zapp.run/) - 브라우저 기반 Flutter 개발

### 2. Docker로 Flutter 실행
```dockerfile
# Dockerfile
FROM cirrusci/flutter:stable

WORKDIR /app
COPY app/pubspec.yaml .
RUN flutter pub get

COPY app/ .
RUN flutter build web

FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
```

```bash
# Docker 빌드 및 실행
docker build -t aurelia-app .
docker run -p 8080:80 aurelia-app
```

## 빠른 시작 (Flutter 설치 후)

```bash
# 1. 프로젝트 클론
git clone https://github.com/dugadak/aurelia-mindscape.git
cd aurelia-mindscape

# 2. Flutter 앱으로 이동
cd app

# 3. 의존성 설치
flutter pub get

# 4. 웹으로 실행 (가장 간단)
flutter run -d chrome

# 5. 또는 에뮬레이터로 실행
flutter run
```

## Flutter 버전 관리

```bash
# Flutter 채널 확인
flutter channel

# Stable 채널로 변경 (권장)
flutter channel stable
flutter upgrade

# 특정 버전 사용
flutter downgrade 3.16.0
```

## 개발 도구

### VS Code 설정
1. VS Code 설치
2. Flutter 확장 설치:
   - Flutter
   - Dart
   - Awesome Flutter Snippets

### Android Studio 설정
1. Android Studio 설치
2. Flutter 플러그인 설치:
   - File > Settings > Plugins
   - "Flutter" 검색 및 설치

## 문제가 계속되면?

### 임시 해결책: 웹 전용 개발
```yaml
# app/pubspec.yaml 수정
# 모바일 전용 패키지들을 주석 처리

dependencies:
  flutter:
    sdk: flutter
  # camera: ^0.10.5  # 주석 처리
  # local_auth: ^2.1.7  # 주석 처리
```

```bash
# 웹으로만 실행
flutter run -d chrome
```

### 서버만 실행하기
Flutter 없이 백엔드만 테스트:
```bash
cd server
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
uvicorn main:app --reload
```

API 문서 확인: http://localhost:8888/docs

## 도움이 필요하면

- [Flutter 공식 문서](https://docs.flutter.dev/)
- [Flutter 커뮤니티](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- GitHub Issues: https://github.com/dugadak/aurelia-mindscape/issues