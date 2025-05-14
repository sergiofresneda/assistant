import SwiftUI

struct AssistantChatView: View {
    @StateObject private var viewModel: AssistantChatViewModel
    @State var inputText: String = ""

    init(viewModel: AssistantChatViewModel = .init()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AssistantListView(items: $viewModel.messages) { item in
            debugPrint(item)
        }
        AssistantTextInputView(
            text: $inputText) {
                debugPrint("Holding audio button")
                viewModel.addAssistantMessage()
            } onSend: {
                viewModel.addTextMessage(inputText)
                inputText = ""
            }
    }
}

#Preview {
    AssistantChatView()
}
