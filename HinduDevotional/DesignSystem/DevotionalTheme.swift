import SwiftUI

enum DevotionalTheme {
    static let ivory = Color(red: 0.99, green: 0.96, blue: 0.88)
    static let saffron = Color(red: 0.89, green: 0.39, blue: 0.12)
    static let gold = Color(red: 0.78, green: 0.57, blue: 0.22)
    static let maroon = Color(red: 0.39, green: 0.06, blue: 0.10)
    static let ink = Color(red: 0.18, green: 0.13, blue: 0.10)
    static let softPanel = Color.white.opacity(0.72)

    static let contentSpacing: CGFloat = 18
    static let cardRadius: CGFloat = 8
}

struct DevotionalCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous)
                    .stroke(DevotionalTheme.gold.opacity(0.18), lineWidth: 1)
            }
    }
}

struct PrimaryDevotionalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(DevotionalTheme.saffron, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
            .opacity(configuration.isPressed ? 0.82 : 1)
    }
}

struct SecondaryDevotionalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(DevotionalTheme.maroon)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(DevotionalTheme.gold.opacity(0.16), in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
}
