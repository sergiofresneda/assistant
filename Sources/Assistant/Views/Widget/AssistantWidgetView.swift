import SwiftUI
import Combine

public struct AssistantWidgetView: View {
    private enum Constants {
        static let imageScaleNormal: CGFloat = 1.0
        static let imageScaleShrunk: CGFloat = 0.9
        static let textOpacityVisible: Double = 1.0
        static let textOpacityHidden: Double = 0.0
        static let textOffsetVisible: CGFloat = 0.0
        static let textOffsetHidden: CGFloat = -30.0
        static let animationDuration: Double = 0.1
    }

    private var stateManager: AssistantStateManager
    @State private var state: AssistantStateManager.State = AssistantStateManager.State.idle
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var imageScale: CGFloat = Constants.imageScaleNormal
    @State private var textOpacity: Double = Constants.textOpacityVisible
    @State private var textOffset: CGFloat = Constants.textOffsetVisible
    private var onTap: (() -> Void)?

    init(stateManager: AssistantStateManager = .init(),
         onTap: (() -> Void)? = nil) {
        self.stateManager = stateManager
        self.onTap = onTap
    }

    public var body: some View {
        VStack {
            VStack {
                Image(systemName: state.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
            }.frame(width: 50, height: 50)
                .padding()
                .background(.blue)
                .clipShape(.circle)
                .scaleEffect(imageScale)
                .shadow(radius: 10)
                .onTapGesture {
                    onTap?()
                }
                .task {
                    bind()
                }

            Text(state.rawValue)
                .padding(.top, 10)
                .opacity(textOpacity)
                .offset(y: textOffset)
        }
    }
}

private extension AssistantWidgetView {
    private func bind() {
        stateManager
            .$state
            .receive(on: DispatchQueue.main)
            .sink { newState in
                self.animateStateChange(to: newState)
            }.store(in: &cancellables)
    }

    private func animateStateChange(to newState: AssistantStateManager.State) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            textOpacity = Constants.textOpacityHidden
            textOffset = Constants.textOffsetHidden
            imageScale = Constants.imageScaleShrunk
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration) {
            state = newState
            withAnimation(.easeOut(duration: Constants.animationDuration)) {
                imageScale = Constants.imageScaleNormal
                textOpacity = Constants.textOpacityVisible
                textOffset = Constants.textOffsetVisible
            }
        }
    }
}

#Preview {
    let sm: AssistantStateManager = {
        let sm = AssistantStateManager()
        return sm
    }()
    AssistantWidgetView(stateManager: sm) {
        sm.next()
    }
}
