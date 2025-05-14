
import SwiftUI

struct ProductsCarouselCell: View {
    @State var products: [Product]
    let rows: [GridItem] = [
        GridItem(.flexible(), alignment: .center)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(products) { product in
                    ProductCell(product: product)
                        .frame(maxWidth: 180, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    ProductsCarouselCell(
        products: [.mock(), .mock(), .mock(), .mock(), .mock()]
    ).background(.blue.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
}
