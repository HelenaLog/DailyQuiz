import SwiftUI

struct TimeProgress: View {
    @EnvironmentObject var vm: QuizViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Text(
                        String(
                            format: "%2d:%02d", Int(vm.time.rounded()) / 60, Int(vm.time.rounded()) % 60)
                    )
                    Spacer()
                    Text(
                        String(
                            format: "%2d:%02d", Int(vm.gameTime.rounded()) / 60, Int(vm.gameTime.rounded()) % 60)
                    )
                }
                .font(.custom(.interRegular, size: 12))
                .foregroundStyle(.purpleApp)
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.lightGrayApp)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.purpleApp)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.purpleApp.opacity(1 - vm.time / vm.gameTime))
                    }
                    .frame(width: geo.size.width * CGFloat(vm.time) / CGFloat(vm.gameTime))
                }
                .frame(height: 8)
            }
            .animation(.linear(duration: 0.1), value: vm.time)
        }
    }
}

#Preview {
    TimeProgress()
        .environmentObject(QuizViewModel())
        .frame(width: 200, height: 30)
}
