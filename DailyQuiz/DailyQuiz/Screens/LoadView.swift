import SwiftUI

struct GameLoadView: View {
    
    // MARK: Properties
    
    @State private var isRotating = 0.0
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300, maxHeight: 67.67)
                .padding(.bottom, 121.33)
            Image(.loaderIcon)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 72, maxHeight: 72)
                .rotationEffect(.degrees(isRotating))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.purpleApp)
        .onAppear {
            withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                isRotating = 360.0
            }
        }
    }
}

#Preview {
    GameLoadView()
}
