import SwiftUI

struct SutraView: View {
    @State private var selectedSutra: Sutra?
    @State private var dailySutra: Sutra = SutraData.sutras.randomElement()!

    var body: some View {
        NavigationStack {
            ZStack {
                ZenTheme.backgroundGradient.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        // Daily sutra card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "sun.horizon.fill")
                                    .foregroundColor(ZenTheme.amber)
                                Text("Today's Teaching")
                                    .font(.headline)
                                    .foregroundColor(ZenTheme.amberDark)
                                Spacer()
                            }
                            Text("\"\(dailySutra.verse)\"")
                                .font(.body.italic())
                                .foregroundColor(ZenTheme.ink)
                                .multilineTextAlignment(.leading)
                            Text("— \(dailySutra.title)")
                                .font(.caption)
                                .foregroundColor(ZenTheme.amber)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(ZenTheme.amber.opacity(0.12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(ZenTheme.amber.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal)

                        // All sutras
                        ForEach(SutraData.sutras) { sutra in
                            Button {
                                selectedSutra = sutra
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(sutra.title)
                                                .font(.headline)
                                                .foregroundColor(ZenTheme.ink)
                                            Text(sutra.tradition)
                                                .font(.caption)
                                                .foregroundColor(ZenTheme.amber)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(ZenTheme.amberDark.opacity(0.5))
                                            .font(.caption)
                                    }
                                    Text("\"\(sutra.verse)\"")
                                        .font(.subheadline.italic())
                                        .foregroundColor(ZenTheme.ink.opacity(0.75))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding()
                                .background(ZenTheme.cardBackground())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Sutras")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedSutra) { sutra in
                SutraDetailSheet(sutra: sutra)
            }
        }
    }
}

struct SutraDetailSheet: View {
    let sutra: Sutra
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ZenTheme.backgroundGradient.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: 6) {
                        Text(sutra.title)
                            .font(.title.bold())
                            .foregroundColor(ZenTheme.ink)
                        Text(sutra.tradition)
                            .font(.subheadline)
                            .foregroundColor(ZenTheme.amber)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)

                    Divider()

                    VStack(alignment: .leading, spacing: 14) {
                        Label("Verse", systemImage: "quote.opening")
                            .font(.headline)
                            .foregroundColor(ZenTheme.amberDark)
                        Text("\"\(sutra.verse)\"")
                            .font(.body.italic())
                            .foregroundColor(ZenTheme.ink)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(ZenTheme.cardBackground())

                    VStack(alignment: .leading, spacing: 14) {
                        Label("Meaning", systemImage: "lightbulb.fill")
                            .font(.headline)
                            .foregroundColor(ZenTheme.amberDark)
                        Text(sutra.meaning)
                            .foregroundColor(ZenTheme.ink.opacity(0.85))
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(ZenTheme.cardBackground())

                    VStack(alignment: .leading, spacing: 14) {
                        Label("Practice", systemImage: "figure.mind.and.body")
                            .font(.headline)
                            .foregroundColor(ZenTheme.amberDark)
                        Text(sutra.practice)
                            .foregroundColor(ZenTheme.ink.opacity(0.85))
                            .multilineTextAlignment(.leading)
                            .italic()
                    }
                    .padding()
                    .background(ZenTheme.cardBackground())

                    Button("Close") { dismiss() }
                        .foregroundColor(ZenTheme.amber)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 32)
                }
                .padding(.horizontal)
            }
        }
    }
}
