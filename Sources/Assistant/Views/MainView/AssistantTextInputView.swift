
import SwiftUI

struct AssistantTextInputView: View {
    @State private var isReadyToSend: Bool = false

    @Binding var text: String
    var onHoldAudioButton: () -> Void
    var onSend: () -> Void

    init(
        text: Binding<String>,
        onHoldAudioButton: @escaping () -> Void,
        onSend: @escaping () -> Void
    ) {
        self._text = text
        self.onHoldAudioButton = onHoldAudioButton
        self.onSend = onSend
    }

    var body: some View {
        HStack {
            TextField("Your Message", text: $text)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
            
            if isReadyToSend {
                Button {
                    onSend()
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                }.frame(width: 20, height: 20)
                    .padding()
                    .background(.blue)
                    .clipShape(.circle)
            } else {
                Image(systemName: "mic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        onHoldAudioButton()
                    }
                    .padding()
                    .background(.pink)
                    .clipShape(.circle)
            }
        }
        .padding()
        .background(.gray.opacity(0.3))
        .onChange(of: text, perform: { _ in
            withAnimation {
                self.isReadyToSend = !text.isEmpty
            }
        })
    }
}

#Preview {
    var text: String = ""
    VStack {
        AssistantTextInputView(
            text: .constant(text),
            onHoldAudioButton: {},
            onSend: {}
        )
    }
}
