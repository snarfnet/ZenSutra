import SwiftUI

struct BreathView: View {
    @State private var selectedPattern: BreathPattern = SutraData.breathPatterns[1] // Box breathing default
    @State private var isRunning = false
    @State private var phase: BreathPhase = .inhale
    @State private var phaseProgress: Double = 0
    @State private var cycleCount = 0
    @State private var timer: Timer?
    @State private var tickInterval = 0.05

    enum BreathPhase: String {
        case inhale = "Inhale"
        case hold = "Hold"
        case exhale = "Exhale"
        case holdOut = "Hold Out"
    }

    var circleScale: Double {
        switch phase {
        case .inhale: return 0.5 + 0.5 * phaseProgress
        case .hold: return 1.0
        case .exhale: return 1.0 - 0.5 * phaseProgress
        case .holdOut: return 0.5
        }
    }

    var phaseColor: Color {
        switch phase {
        case .inhale: return ZenTheme.amberLight
        case .hold: return ZenTheme.amber
        case .exhale: return ZenTheme.amberDark
        case .holdOut: return ZenTheme.ink.opacity(0.4)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenTheme.backgroundGradient.ignoresSafeArea()
                VStack(spacing: 32) {
                    // Pattern selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(SutraData.breathPatterns) { pattern in
                                Button {
                                    if !isRunning {
                                        selectedPattern = pattern
                                        resetBreath()
                                    }
                                } label: {
                                    Text(pattern.name)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 7)
                                        .background(selectedPattern.id == pattern.id ? ZenTheme.amber : ZenTheme.surface)
                                        .foregroundColor(selectedPattern.id == pattern.id ? .white : ZenTheme.ink)
                                        .cornerRadius(16)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Pattern info
                    HStack(spacing: 20) {
                        PatternBadge(label: "In", value: selectedPattern.inhale)
                        if selectedPattern.hold > 0 {
                            PatternBadge(label: "Hold", value: selectedPattern.hold)
                        }
                        PatternBadge(label: "Out", value: selectedPattern.exhale)
                        if selectedPattern.holdOut > 0 {
                            PatternBadge(label: "Hold", value: selectedPattern.holdOut)
                        }
                    }

                    // Breathing circle
                    ZStack {
                        Circle()
                            .fill(ZenTheme.amber.opacity(0.08))
                            .frame(width: 240, height: 240)
                        Circle()
                            .fill(phaseColor.opacity(0.25))
                            .frame(width: 220 * circleScale, height: 220 * circleScale)
                            .animation(.easeInOut(duration: 0.3), value: circleScale)
                        Circle()
                            .stroke(phaseColor.opacity(0.6), lineWidth: 2)
                            .frame(width: 220, height: 220)

                        VStack(spacing: 6) {
                            Text(phase.rawValue)
                                .font(.title2.bold())
                                .foregroundColor(ZenTheme.ink)
                            Text("Cycle \(cycleCount + 1)")
                                .font(.caption)
                                .foregroundColor(ZenTheme.amber)
                        }
                    }

                    // Description
                    Text(selectedPattern.benefit)
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(ZenTheme.amberDark.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Start / Stop
                    Button {
                        isRunning ? stopBreath() : startBreath()
                    } label: {
                        Text(isRunning ? "Stop" : "Begin")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 50)
                            .background(ZenTheme.amber)
                            .cornerRadius(25)
                    }
                }
                .padding()
            }
            .navigationTitle("Breathe")
            .navigationBarTitleDisplayMode(.large)
        }
        .onDisappear { stopBreath() }
    }

    private func startBreath() {
        isRunning = true
        phase = .inhale
        phaseProgress = 0
        runPhase()
    }

    private func runPhase() {
        guard isRunning else { return }
        let phases: [(BreathPhase, Int)] = [
            (.inhale, selectedPattern.inhale),
            (.hold, selectedPattern.hold),
            (.exhale, selectedPattern.exhale),
            (.holdOut, selectedPattern.holdOut)
        ].filter { $0.1 > 0 }

        func executePhases(_ index: Int) {
            guard isRunning, index < phases.count else {
                if isRunning {
                    cycleCount += 1
                    executePhases(0)
                }
                return
            }
            let (p, seconds) = phases[index]
            phase = p
            phaseProgress = 0
            let steps = Int(Double(seconds) / tickInterval)
            var step = 0
            timer = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true) { t in
                step += 1
                phaseProgress = Double(step) / Double(steps)
                if step >= steps {
                    t.invalidate()
                    executePhases(index + 1)
                }
            }
        }
        executePhases(0)
    }

    private func stopBreath() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func resetBreath() {
        phase = .inhale
        phaseProgress = 0
        cycleCount = 0
    }
}

struct PatternBadge: View {
    let label: String
    let value: Int

    var body: some View {
        VStack(spacing: 2) {
            Text("\(value)")
                .font(.title2.bold())
                .foregroundColor(ZenTheme.ink)
            Text(label)
                .font(.caption2)
                .foregroundColor(ZenTheme.amber)
        }
        .frame(minWidth: 44)
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(ZenTheme.surface)
        .cornerRadius(10)
    }
}
