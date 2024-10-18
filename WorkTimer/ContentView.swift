import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        VStack {
            Text(timerManager.timeString)
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: {
                    timerManager.startTimer()
                }) {
                    Text("Start")
                        .font(.title)
                        .padding()
                }
                .disabled(timerManager.timerIsActive)

                Button(action: {
                    timerManager.stopTimer()
                }) {
                    Text("Stop")
                        .font(.title)
                        .padding()
                }
                .disabled(!timerManager.timerIsActive)
            }
        }
        .frame(width: 300, height: 200)
    }
}
