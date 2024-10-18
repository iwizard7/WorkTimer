import SwiftUI

@main
struct WorkTimerApp: App {
    @StateObject private var timerManager = TimerManager()

    var body: some Scene {
        WindowGroup {
            ContentView(timerManager: timerManager)
        }
    }
}
