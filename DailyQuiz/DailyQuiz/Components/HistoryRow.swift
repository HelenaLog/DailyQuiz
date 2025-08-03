import SwiftUI

struct HistoryRow: View {
    var number: Int
    var score: Int
    var date: String
    var time: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .foregroundStyle(Color.white)
            VStack(spacing: 12) {
                HStack{
                    Text("Quiz \(number)")
                        .font(.custom(.interRegularBold, size: 24))
                        .foregroundStyle(Color.purpleApp)
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<5, id: \.self) { sc in
                            Image(sc < score ? "starActive" : "starInactive")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 16)
                        }
                    }
                }
                HStack {
                    Text(date)
                    Spacer()
                    Text(time)
                }
                .font(.custom(.interRegular, size: 12))
            }
            .padding(24)
        }
        .frame(maxHeight: 104)
    }
}

#Preview {
    HistoryRow(number: 1, score: 4, date: "14 июля", time: "12:00")
}
