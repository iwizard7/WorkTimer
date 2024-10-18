import SwiftUI

@main
struct WorkTimerApp: App {
    @StateObject var timerManager = TimerManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerManager)
        }
    }
}
