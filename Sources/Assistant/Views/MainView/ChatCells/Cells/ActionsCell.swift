import SwiftUI

private enum ActionConstants {
    static let buttonInitialScale: CGFloat = 0.5
    static let buttonPopScale: CGFloat = 1.0
    static let buttonHiddenOpacity: Double = 0.0
    static let buttonVisibleOpacity: Double = 1.0
    static let buttonAnimationDelay: Double = 0.1
    static let buttonHorizontalSpacing: CGFloat = 8
}

struct ActionsCell: View {
    let actions: [ChatAction]
    let onTapAction: (ChatAction) -> Void
    private var initialDelay: Double

    @State private var buttonsVisibleCount: Int = 0
    private let gridItems = [
        GridItem(.flexible(), spacing: ActionConstants.buttonHorizontalSpacing)
    ]

    init(actions: [ChatAction], onTapAction: @escaping (ChatAction) -> Void, initialDelay: Double = 0) {
        self.actions = actions
        self.onTapAction = onTapAction
        self.initialDelay = initialDelay
    }

    var body: some View {
        if actions.isEmpty {
            EmptyView()
        } else {
            LazyVGrid(columns: gridItems, alignment: .leading, spacing: ActionConstants.buttonHorizontalSpacing) {
                ForEach(actions.indices, id: \.self) { index in
                    let action = actions[index]
                    let isVisible = index < buttonsVisibleCount
                    Button(action.rawValue) {
                        onTapAction(action)
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                    .background(.white)
                    .clipShape(Capsule())
                    .fixedSize(horizontal: true, vertical: false)
                    .scaleEffect(isVisible ? ActionConstants.buttonPopScale : ActionConstants.buttonInitialScale)
                    .opacity(isVisible ? ActionConstants.buttonVisibleOpacity : ActionConstants.buttonHiddenOpacity)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) {
                    animateButtons()
                }
            }
        }
    }

    private func animateButtons() {
        buttonsVisibleCount = 0
        for i in actions.indices {
            let delay = ActionConstants.buttonAnimationDelay * Double(i)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.spring()) {
                    buttonsVisibleCount += 1
                }
            }
        }
    }

    /// Specify a delay (in seconds) before the button pop-in animations start.
    func animationDelay(_ delay: Double) -> ActionsCell {
        ActionsCell(actions: actions, onTapAction: onTapAction, initialDelay: delay)
    }
}

#Preview {
    ActionsCell(actions: [.viewMore, .changeColor, .moreRecommendations]) { action in
        print(action)
    }.padding()
        .background(.blue.opacity(0.8))
}
