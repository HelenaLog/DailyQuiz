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
                .frame(
                    maxWidth: Constants.LogoConstants.width,
                    maxHeight: Constants.LogoConstants.height
                )
                .padding(.bottom, Constants.LogoConstants.bottomPadding)
            Image(.loaderIcon)
                .resizable()
                .scaledToFit()
                .frame(
                    maxWidth: Constants.LoaderConstants.width,
                    maxHeight: Constants.LoaderConstants.height
                )
                .rotationEffect(.degrees(isRotating))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.purpleApp)
        .onAppear {
            withAnimation(Animation.linear(duration: Constants.AnimationConstants.duration).repeatForever(autoreverses: false)) {
                isRotating = Constants.AnimationConstants.rotationDegrees
            }
        }
    }
}

#Preview {
    GameLoadView()
}

// MARK: - Constants

private extension GameLoadView {
    enum Constants {
        enum LogoConstants {
            static let width: CGFloat = 300
            static let height: CGFloat = 67.67
            static let bottomPadding: CGFloat = 121.33
        }
        
        enum LoaderConstants {
            static let width: CGFloat = 72
            static let height: CGFloat = 72
        }
        
        enum AnimationConstants {
            static let duration: Double = 1.0
            static let rotationDegrees: Double = 360.0
        }
    }
}
