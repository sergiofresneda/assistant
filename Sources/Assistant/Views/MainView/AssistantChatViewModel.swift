
import Foundation

final class AssistantChatViewModel: ObservableObject {
    @Published var messages: [AssistantItem] = []
    var assistantMessages: Int = .zero

    func addTextMessage(_ text: String) {
        messages.append(AssistantItem(types: [.text(text, [])], author: .you))
    }

    func addAssistantMessage() {
        if messages.isEmpty {
            messages.append(AssistantItem(types: [.text("Good Afternoon Sergio, How Are You?", [])], author: .assistant))
            assistantMessages += 1
        } else {
            if assistantMessages == 1 {
                messages.append(
                    AssistantItem(
                        types: [
                            .text("Cheking your interest, I thought this dress could fit with you", []),
                            .image(.mock(), [.viewMore, .addToCart])
                            ],
                        author: .assistant
                    )
                )
                assistantMessages += 1
                return
            }
            if assistantMessages == 2 {
                messages.append(
                    AssistantItem(
                        types: [
                            .text("Ok, this outfit could go well with your celebration", []),
                            .outfit(Product.mockOf(), [.viewMore, .moreRecommendations])
                        ],
                        author: .assistant
                    )
                )
                assistantMessages += 1
                return
            }
            if assistantMessages == 3 {
                messages.append(AssistantItem(types: [
                    .text("Ok, so, check these products, and let me know if it fits with you", []),
                    .carousel(Product.mockOf(), [.moreRecommendations])
                ], author: .assistant))
                assistantMessages += 1
                return
            }
        }
    }
}
