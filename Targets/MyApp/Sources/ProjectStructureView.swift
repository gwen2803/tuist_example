import SwiftUI

public struct ProjectStructureView: View {
    @State private var projectStructure: String = """
    MyApp/
    ├── Project.swift        ← Tuist 프로젝트 설정 파일
    ├── Tuist.swift          ← Tuist 실행 파일
    ├── mise.toml            ← mise 설정 파일
    ├── .gitignore           ← Git 무시 파일 목록
    ├── Tuist/               ← Tuist 관련 파일
    │   └── Package.swift    ← Tuist 패키지 설정
    ├── MyApp/               ← 앱 소스 코드
    │   ├── Sources/         ← 앱 소스 파일
    │   │   ├── MyAppApp.swift             ← 앱 진입점
    │   │   ├── RootView.swift             ← 메인 뷰
    │   │   ├── SideMenuView.swift         ← 사이드 메뉴 뷰
    │   │   ├── ProjectStructureView.swift ← 프로젝트 구조 뷰
    │   │   └── TimeView/                  ← 타임 뷰 파일
    │   │       ├── TimeView.swift                   ← 타임 뷰
    │   │       ├── TimeViewModel.swift              ← 타임 뷰모델
    │   │       └── TimeModel.swift                  ← 타임 모델
    │   ├── Resources/       ← 리소스 파일
    │   └── Tests/           ← 테스트 코드
    ├── MyApp.xcodeproj/     ← Xcode 프로젝트 파일
    ├── MyApp.xcworkspace/   ← Xcode 워크스페이스
    └── Derived/             ← 빌드 중간 파일
    """
    @State private var fontSize: CGFloat = 13
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Text(projectStructure)
                        .font(.system(size: fontSize, design: .monospaced))
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(16)
                        .background(
                            GeometryReader { textGeometry in
                                Color.clear.preference(
                                    key: TextWidthPreferenceKey.self,
                                    value: textGeometry.size.width
                                )
                            }
                        )
                }
                .onPreferenceChange(TextWidthPreferenceKey.self) { width in
                    if width > geometry.size.width {
                        fontSize -= 0.5
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

private struct TextWidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
