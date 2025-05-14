import SwiftUI

private enum Constants {
    static let typingSpeed: Double = 0.02
}

enum ChatAction: String, Identifiable {
    var id: String { self.rawValue }
    case viewMore = "View more"
    case changeColor = "Change color"
    case moreRecommendations = "More recommendations"
    case cancel = "Cancel"
    case addToCart = "Add to cart"
}

struct TextCell: View {
    private var text: String
    /// Called when typing animation completes
    private var onTypingCompleted: () -> Void

    @State private var displayedText: String = ""

    private var typingDelay: Double {
        Constants.typingSpeed * Double(text.count)
    }

    init(
        text: String,
        onTypingCompleted: @escaping () -> Void = {}
    ) {
        self.text = text
        self.onTypingCompleted = onTypingCompleted
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(displayedText)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .multilineTextAlignment(.leading)
                .font(.title2)
                .foregroundStyle(.white)
        }.onAppear {
            animateText()
        }
    }
}

private extension TextCell {
    private func animateText() {
        displayedText = ""
        for (i, char) in text.enumerated() {
            let delay = Constants.typingSpeed * Double(i)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                displayedText.append(char)
                if i == text.count - 1 {
                    onTypingCompleted()
                }
            }
        }
    }
}

#Preview {
    List {
        VStack {
            TextCell(
                text: "What can I help you with?"
            ).padding()
            ActionsCell(
                actions: []
            ) {
                print($0)
            }.padding()
        }.background(.blue.opacity(0.8))
            .clipShape(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
            )

        VStack {
            TextCell(
                text: "This summer is going to be hot! I recommend you to find cloths with light colors and breathable fabrics, check this dress"
            ).padding()
            ProductCell(product: .mock())
            ActionsCell(
                actions: [
                    .viewMore,
                    .changeColor,
                    .addToCart
                ]
            ) {
                print($0)
            }.padding()
        }.background(.blue.opacity(0.8))
            .clipShape(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
            )

        VStack {
            TextCell(
                text: "For this event, I recommend you to wear a suit"
            ).padding()
            ActionsCell(
                actions: [.moreRecommendations]
            ) {
                print($0)
            }.padding()
        }
        .background(.blue.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }.padding(.zero).listStyle(.plain)
}
