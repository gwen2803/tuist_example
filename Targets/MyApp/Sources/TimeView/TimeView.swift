import SwiftUI

public struct TimeView: View {
    @ObservedObject var viewModel = TimeViewModel()
    @Binding var showMenu: Bool
    
    public var body: some View {
        VStack(spacing: 20) {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.0)
                } else if let error = viewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text(viewModel.currentTime)
                        .font(.system(size: 32, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .frame(height: 32)
            
            timezonePicker
            
            Button("Refresh Time") {
                viewModel.fetchCurrentTime()
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Time API")
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
        .onAppear {
            viewModel.fetchCurrentTime()
        }
        .onDisappear {
            viewModel.fetchCancel()
        }
    }
    
    private var timezonePicker: some View {
        Picker("Select Timezone", selection: $viewModel.selectedTimeZone) {
            ForEach(viewModel.availableTimeZones, id: \.self) { zone in
                Text(zone).tag(zone)
            }
        }
        .pickerStyle(.menu)
        .onChange(of: viewModel.selectedTimeZone) {
            viewModel.fetchCurrentTime()
        }
    }
}
