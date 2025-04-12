//
//  RootView.swift
//  MyApp
//
//  Created by YONDOLMAC on 4/10/25.
//

import SwiftUI

public enum Screen: Hashable {
    case timeapi
}

struct RootView: View {
    @State private var path: [Screen] = []
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                VStack(spacing: 20) {
                    ProjectStructureView()
                }
                .navigationTitle("Tuist_example")
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                        }
                    }
                }
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .timeapi:
                        TimeView(showMenu: $showMenu)
                    }
                }
            }
            
            if showMenu {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }
                    .zIndex(1)
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    SideMenuView(onMenuSelect: { route in
                        path.append(route)
                        withAnimation {
                            showMenu = false
                        }
                    })
                    .frame(width: UIScreen.main.bounds.width * 2/3)
                    .background(Color.white)
                }
                .background(Color.clear)
                .transition(.move(edge: .trailing))
                .zIndex(1)
                .ignoresSafeArea()
            }
        }
    }
}
