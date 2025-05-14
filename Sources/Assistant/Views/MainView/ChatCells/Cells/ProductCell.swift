import SwiftUI

private enum Constants {
    static let imageInitialOffsetX: CGFloat = -UIScreen.main.bounds.width
    static let imageInitialOpacity: Double = 0
    static let textInitialOpacity: Double = 0
    static let imageAnimationDuration: Double = 0.5
    static let textAnimationDuration: Double = 0.3
    static let textAnimationDelay: Double = 0.5
    static let maxImageHeight: CGFloat = 200
    static let cornerRadius: CGFloat = 10
    static let bottomPadding: CGFloat = 10
}

struct ProductCell: View {
    private let product: Product
    @State private var imageOffsetX: CGFloat = Constants.imageInitialOffsetX
    @State private var imageOpacity: Double = Constants.imageInitialOpacity
    @State private var textOpacity: Double = Constants.textInitialOpacity
    private var initialDelay: Double
    private let showProductInfo: Bool

    init(
        product: Product,
        initialDelay: Double = 0,
        showProductInfo: Bool = true
    ) {
        self.product = product
        self.initialDelay = initialDelay
        self.showProductInfo = showProductInfo
    }

    var body: some View {
        VStack(alignment: .center) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: Constants.maxImageHeight)
                .background()
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius,
                        style: .continuous
                    )
                ).padding(
                    .bottom,
                    showProductInfo ? Constants.bottomPadding : .zero
                )
                .offset(x: imageOffsetX)
                .opacity(imageOpacity)

            if showProductInfo {
                Group {
                    Text(product.name)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    Text(product.price)
                        .font(.callout)
                        .foregroundStyle(.white)
                }
                .opacity(textOpacity)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) {
                withAnimation(.easeOut(duration: Constants.imageAnimationDuration)) {
                    imageOffsetX = 0
                    imageOpacity = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.textAnimationDelay) {
                    withAnimation(.easeIn(duration: Constants.textAnimationDuration)) {
                        textOpacity = 1
                    }
                }
            }
        }
    }
}

extension ProductCell {
    /// Specify a delay (in seconds) before the cell animations start.
    func animationDelay(_ delay: Double) -> ProductCell {
        ProductCell(product: product, initialDelay: delay)
    }
}

#Preview {
    let product = Product.mock()
    VStack {
        TextCell(
            text: "Check this dress I found for you"
        ).padding()
        ProductCell(product: product).padding()
    }.background(.blue.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
}
