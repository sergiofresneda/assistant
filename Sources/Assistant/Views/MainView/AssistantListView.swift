import SwiftUI

enum MessageAuthor: Equatable {
    case you
    case assistant
}

enum MessageType: Equatable, Identifiable {
    var id: String {
        switch self {
        case .text:
            return "text"
        case .image:
            return "image"
        case .carousel:
            return "carousel"
        case .outfit:
            return "outfit"
        }
    }

    case text(String, [ChatAction])
    case image(Product, [ChatAction])
    case carousel([Product], [ChatAction])
    case outfit([Product], [ChatAction])
}

struct AssistantItem: Identifiable, Equatable {
    let id: UUID = UUID()
    let types: [MessageType]
    let author: MessageAuthor
}

struct AssistantListView: View {
    @Binding var items: [AssistantItem]
    var onTapped: (AssistantItem) -> Void

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(items) { item in
                    cellBuilder(item.types)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(item.author == .you ? .green.opacity(0.8) : .blue.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.leading, item.author == .you ? 50 : 0)
                        .padding(.trailing, item.author == .assistant ? 50 : 0)
                        .id(item.id)
                }
                // Bottom inset spacer
                Color.clear
                    .frame(height: 50)
                    .id("BottomInset")
            }.listStyle(.plain)
            .onChange(of: items.count) { _ in
                withAnimation {
                    proxy.scrollTo("BottomInset", anchor: .bottom)
                }
            }
        }
    }
}

private extension AssistantListView {
    @ViewBuilder
    func cellBuilder(_ types: [MessageType]) -> some View {
        VStack {
            ForEach(types) { type in
                typeToCell(type)
            }
        }
    }

    @ViewBuilder
    func typeToCell(_ type: MessageType) -> some View {
        switch type {
        case .text(let text, let actions):
            TextCell(text: text)
            if !actions.isEmpty {
                ActionsCell(actions: actions) { action in
                    print(action)
                }
            }
        case .image(let product, let actions):
            ProductCell(product: product)
            if !actions.isEmpty {
                ActionsCell(actions: actions) { action in
                    print(action)
                }
            }

        case .carousel(let products, let actions):
            ProductsCarouselCell(products: products)
                .frame(height: 200)
            if !actions.isEmpty {
                ActionsCell(actions: actions) { action in
                    print(action)
                }
            }

        case .outfit(let products, let actions):
            VisualOutfitCell(products: products)
            if !actions.isEmpty {
                ActionsCell(actions: actions) { action in
                    print(action)
                }
            }
        }
    }
}
