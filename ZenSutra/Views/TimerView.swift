import SwiftUI

struct TimerView: View {
    @State private var duration: Double = 300 // 5 minutes default
    @State private var timeRemaining: Double = 300
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var completed = false

    let durations: [(String, Double)] = [
        ("5 min", 300), ("10 min", 600), ("15 min", 900),
        ("20 min", 1200), ("30 min", 1800)
    ]

    var progress: Double {
        timeRemaining / duration
    }

    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenTheme.backgroundGradient.ignoresSafeArea()
                VStack(spacing: 40) {
                    // Duration picker
                    HStack(spacing: 8) {
                        ForEach(durations, id: \.0) { label, value in
                            Button {
                                if !isRunning {
                                    duration = value
                                    timeRemaining = value
                                    completed = false
                                }
                            } label: {
                                Text(label)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(duration == value ? ZenTheme.amber : ZenTheme.surface)
                                    .foregroundColor(duration == value ? .white : ZenTheme.ink)
                                    .cornerRadius(16)
                            }
                        }
                    }

                    // Enso timer circle
                    ZStack {
                        Circle()
                            .stroke(ZenTheme.amber.opacity(0.2), lineWidth: 12)
                            .frame(width: 260, height: 260)
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(ZenTheme.amber, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                            .frame(width: 260, height: 260)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 1), value: progress)
                        VStack(spacing: 8) {
                            if completed {
                                Text("🙏")
                                    .font(.system(size: 48))
                                Text("Complete")
                                    .font(.title2)
                                    .foregroundColor(ZenTheme.amberDark)
                            } else {
                                Text(timeString)
                                    .font(.system(size: 52, weight: .thin, design: .rounded))
                                    .foregroundColor(ZenTheme.ink)
                                Text("remaining")
                                    .font(.caption)
                                    .foregroundColor(ZenTheme.amber)
                            }
                        }
                    }

                    // Controls
                    HStack(spacing: 32) {
                        Button {
                            stopTimer()
                            timeRemaining = duration
                            completed = false
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.title2)
                                .foregroundColor(ZenTheme.amberDark)
                                .frame(width: 56, height: 56)
                                .background(ZenTheme.surface)
                                .clipShape(Circle())
                        }
                        Button {
                            isRunning ? stopTimer() : startTimer()
                        } label: {
                            Image(systemName: isRunning ? "pause.fill" : "play.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(ZenTheme.amber)
                                .clipShape(Circle())
                        }
                        .disabled(completed)
                    }

                    Text("Sit comfortably. Breathe naturally.")
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(ZenTheme.amberDark.opacity(0.7))
                }
                .padding()
            }
            .navigationTitle("Meditate")
            .navigationBarTitleDisplayMode(.large)
        }
        .onDisappear { stopTimer() }
    }

    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                completed = true
            }
        }
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}
