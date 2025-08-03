import SwiftUI

struct PrimaryButton: View {
    var text: String
    var textColor: Color = .white
    var backgroundColor: Color = .purpleApp
    
    var body: some View {
        Text(text)
            .font(.custom(.interRegularBlack, size: 16))
            .foregroundStyle(textColor)
            .padding(.vertical, 15.5)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(backgroundColor)
            .cornerRadius(16)
    }
}

#Preview {
    PrimaryButton(text: "Next")
}
