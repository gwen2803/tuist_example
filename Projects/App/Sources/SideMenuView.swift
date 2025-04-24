import SwiftUI

public struct SideMenuView: View {
    let onMenuSelect: (Screen) -> Void
    
    public init(onMenuSelect: @escaping (Screen) -> Void) {
        self.onMenuSelect = onMenuSelect
    }
    
    public var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 20) {
                    // 메뉴 아이템
                    MenuButton(title: "Time API", icon: "clock.fill") {
                        onMenuSelect(.timeapi)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color(.white)
                        .ignoresSafeArea()
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Color.clear
                        .frame(height: 0)
                }
            }
        }
    }
}

public struct MenuButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    public init(title: String, icon: String, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .frame(width: 24, height: 24)
                Text(title)
                Spacer()
            }
            .foregroundColor(.primary)
        }
    }
} 
