import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager: TimerManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Оставшееся время:")
                .font(.largeTitle)

            Text(timerManager.remainingTime)
                .font(.system(size: 30))
                .frame(minWidth: 200)

            HStack {
                Button(action: {
                    timerManager.startTimer()
                }) {
                    Text("Старт")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    timerManager.stopTimer()
                }) {
                    Text("Стоп")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 20)
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}
