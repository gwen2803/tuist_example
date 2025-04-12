# MyApp

iOS 애플리케이션 프로젝트입니다.

## 요구사항

- Xcode 14.0+
- iOS 15.0+
- Tuist 4.8.1
- mise

## 설치 방법

1. mise를 통해 Tuist를 설치합니다:
```bash
mise install tuist@4.8.1
```

2. 프로젝트를 생성합니다:
```bash
tuist generate
```

## 프로젝트 구조

```
MyApp/
├── Project.swift       # Tuist 프로젝트 설정 파일
├── Tuist.swift         # Tuist 실행 파일
├── mise.toml           # mise 설정 파일
├── Targets
│   └── MyApp
│       ├── Sources     # 앱 소스 파일
│       ├── Resources   # 리소스 파일
│       └── Tests       # 테스트 코드
└── Tuist
    └── Package.swift   # Tuist 프로젝트 의존성 관리 파일
```

## 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다. 