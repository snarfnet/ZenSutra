import SwiftUI

enum ZenTheme {
    static let background = Color(red: 1.00, green: 0.96, blue: 0.86)
    static let surface = Color(red: 0.98, green: 0.93, blue: 0.80)
    static let amber = Color(red: 0.78, green: 0.47, blue: 0.12)
    static let amberDark = Color(red: 0.63, green: 0.33, blue: 0.06)
    static let amberLight = Color(red: 0.90, green: 0.63, blue: 0.24)
    static let ink = Color(red: 0.18, green: 0.11, blue: 0.04)
    static let cream = Color(red: 1.00, green: 0.97, blue: 0.90)

    static let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 1.00, green: 0.96, blue: 0.86),
            Color(red: 0.98, green: 0.88, blue: 0.70)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    static func cardBackground() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(red: 0.98, green: 0.93, blue: 0.80))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color(red: 0.78, green: 0.47, blue: 0.12).opacity(0.4), lineWidth: 1)
            )
    }
}
