import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label("Meditate", systemImage: "timer")
                }
            SutraView()
                .tabItem {
                    Label("Sutras", systemImage: "book.fill")
                }
            BreathView()
                .tabItem {
                    Label("Breathe", systemImage: "wind")
                }
        }
        .accentColor(ZenTheme.amber)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
