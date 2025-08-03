import SwiftUI

@main
struct DailyQuizApp: App {
    @StateObject var vm = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
