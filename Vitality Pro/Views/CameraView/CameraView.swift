import Mixpanel
import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @State private var model = CameraModel()
    
    @State private var showInfo: Bool = false
    
    var action: (Food?) -> Void
    
    init(action: @escaping (Food?) -> Void) {
        self.action = action
        self.model = CameraModel()
        self.showInfo = false
        
        model.camera.initialize()
    }
    
    var body: some View {
        GeometryReader { _ in
            ViewfinderView(
                image: $model.viewfinderImage,
                snapshot: $model.image
            )
            .overlay(alignment: .bottom) {
                Group {
                    if model.image == nil {
                        ViewfinderButtons()
                    } else {
                        ResultButtons()
                    }
                }
                .frame(height: 120)
                .background(.orange)
            }
            .background(.black)
        }
        .task {
            await model.camera.start()
        }
        .onDisappear {
            Task {
                model.camera.stop()
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showInfo, content: {
            HelpView()
        })
        .onAppear {
            Mixpanel.mainInstance()
                .track(event: "Camera Opened", properties: [:])
        }
    }
    
    @ViewBuilder func ViewfinderButtons() -> some View {
        HStack {
            Button("Cancel", systemImage: "xmark.circle.fill", action: {
                Mixpanel.mainInstance()
                    .track(event: "Camera Cancelled", properties: [:])
                
                dismiss()
            })
            .labelStyle(.iconOnly)
            .foregroundStyle(.background)
            .font(.title)
            .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: { model.camera.takePhoto() }) {
                ZStack {
                    Circle()
                        .strokeBorder(.background, lineWidth: 3)
                        .frame(width: 62, height: 62)
                    Circle()
                        .fill(.background)
                        .frame(width: 50, height: 50)
                }
                .accessibilityLabel(Text("Shutter"))
            }
            
            Spacer()
            
            Button("Help", systemImage: "questionmark.circle.fill", action: {
                showInfo.toggle()
            })
            .labelStyle(.iconOnly)
            .foregroundStyle(.background)
            .font(.title)
            .fontWeight(.semibold)
        }
        .padding(.horizontal, 50)
    }
    
    @ViewBuilder func ResultButtons() -> some View {
        HStack {
            Button("Cancel", systemImage: "xmark.circle.fill", action: {
                Mixpanel.mainInstance()
                    .track(event: "Camera Cancelled", properties: [:])
                
                dismiss()
            })
            .labelStyle(.iconOnly)
            .foregroundStyle(.background)
            .font(.title)
            .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                action(model.food)
                dismiss()
            }) {
                ZStack {
                    Circle()
                        .fill(.background)
                        .frame(width: 62, height: 62)
                    
                    if let food = model.food {
                        Text(food.emoji)
                            .font(.title)
                    } else {
                        ProgressView()
                            .controlSize(.regular)
                    }
                }
                .accessibilityLabel(Text("Shutter"))
            }
            
            Spacer()
            
            Menu("Options", systemImage: "ellipsis.circle.fill") {
                ForEach(foods) { food in
                    Button(action: { model.food = food }) {
                        Label(title: { Text(food.title) }) {
                            Text(food.emoji)
                        }
                    }
                }
            }
            .labelStyle(.iconOnly)
            .foregroundStyle(.background)
            .font(.title)
            .fontWeight(.semibold)
        }
        .padding(.horizontal, 50)
    }
}
