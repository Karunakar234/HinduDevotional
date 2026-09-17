import SwiftUI

struct LanguageSettingsView: View {
    @Binding var secondaryLanguage: DevotionalLanguage
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                DevotionalTheme.ivory.ignoresSafeArea()

                List {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Default Reading Mode")
                                .font(.headline)
                            Text("English stays visible as the reference language. Telugu is the default companion language, and you can choose another reviewed language as content becomes available.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }

                    Section("Companion Language") {
                        ForEach(DevotionalLanguage.allCases) { language in
                            Button {
                                secondaryLanguage = language
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(language.rawValue)
                                            .foregroundStyle(DevotionalTheme.ink)
                                        Text(language.nativeName)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    if secondaryLanguage == language {
                                        Image(systemName: "checkmark")
                                            .font(.headline)
                                            .foregroundStyle(DevotionalTheme.saffron)
                                    }
                                }
                            }
                            .accessibilityValue(secondaryLanguage == language ? "Selected" : "Not selected")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Languages")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct LanguagePairBadge: View {
    let secondaryLanguage: DevotionalLanguage

    var body: some View {
        Label(secondaryLanguage.displayPairName, systemImage: "globe")
            .font(.footnote.weight(.semibold))
            .foregroundStyle(DevotionalTheme.maroon)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(DevotionalTheme.gold.opacity(0.16), in: Capsule())
    }
}

#Preview {
    @Previewable @State var language: DevotionalLanguage = .telugu
    LanguageSettingsView(secondaryLanguage: $language)
}
