
import SwiftUI

private enum Constants {
    static let itemWidth: CGFloat = 100
    static let columnSpacing: CGFloat = 8
}

struct VisualOutfitCell: View {
    private var outfit: [Product]
    private let columns: [GridItem] = [
        GridItem(.fixed(Constants.itemWidth), spacing: Constants.columnSpacing),
        GridItem(.fixed(Constants.itemWidth), spacing: Constants.columnSpacing)
    ]

    init(products: [Product]) {
        self.outfit = products
    }

    var body: some View {
        HStack {
            Spacer()
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: Constants.columnSpacing
            ) {
                ForEach(outfit) { product in
                    ProductCell(
                        product: product,
                        showProductInfo: false
                    ).onTapGesture {

                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    VStack {
        TextCell(text: "This outfit I prepared just for you")
        VisualOutfitCell(
            products: Product.mockOf()
        )
    }.frame(maxWidth: .infinity)
        .padding()
        .background(.blue)
}
