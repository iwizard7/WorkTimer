import Foundation
import UserNotifications

class TimerManager: ObservableObject {
    @Published var timeRemaining: TimeInterval = 0
    @Published var timerIsActive: Bool = false
    var timer: Timer?
    
    var timeString: String {
        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    init() {
        requestNotificationPermission()
    }

    func startTimer() {
        timeRemaining = 8 * 3600 + 30 * 60 // 8 часов 30 минут
        timerIsActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerIsActive = false
        timeRemaining = 0
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            stopTimer()
            notifyUser()
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }

    private func notifyUser() {
        let content = UNMutableNotificationContent()
        content.title = "Таймер завершен"
        content.body = "Ваш таймер на 8 часов 30 минут завершен."
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
