import SwiftUI

@main
struct DailyQuizApp: App {
    @StateObject var vm = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
           MainView()
                .environmentObject(vm)
        }
    }
}
