import Foundation
import UserNotifications

class TimerManager: ObservableObject {
    @Published var remainingTime: String = "8:30:00"
    @Published var isRunning: Bool = false
    private var timer: Timer?
    private let totalDuration: TimeInterval = 8 * 60 * 60 + 30 * 60 // 8 часов 30 минут
    private var remainingDuration: TimeInterval = 0

    init() {
        self.remainingDuration = totalDuration
        requestNotificationAuthorization()
    }

    func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        remainingDuration = totalDuration
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingDuration > 0 {
                self.remainingDuration -= 1
                self.remainingTime = self.formatTime(self.remainingDuration)
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.isRunning = false
                self.showNotification()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        remainingTime = formatTime(totalDuration) // сброс на начальное время
    }

    private func formatTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            // Обработка ошибки, если необходимо
        }
    }

    private func showNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Таймер завершен!"
        content.body = "Ваши 8 часов 30 минут истекли."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка добавления уведомления: \(error.localizedDescription)")
            }
        }
    }
}
