import SwiftUI

struct ViewfinderView: View {
    @Binding var image: Image?
    @Binding var snapshot: Image?
    
    var body: some View {
        
        GeometryReader { geometry in
            if let snapshot = snapshot {
                snapshot
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                
            } else if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width, 
                        height: geometry.size.height
                    )
            }
        }
    }
}
