import Foundation

struct Product: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: ImageResource
    let price: String

    static func mock() -> Product {
        Product(
            name: "Midi Dress Satin 50th Anniversary",
            image: .dressMock,
            price: "$50.49"
        )
    }

    static func mockOf() -> [Product] {
        [
            Product(
                name: "POPLIN SHIRT WITH BATWING SLEEVES",
                image: .of1,
                price: "$35.95"
            ),
            Product(
                name: "CROPPED RIBBED SWEATER",
                image: .of2,
                price: "$25.95"
            ),
            Product(
                name: "CROPPED RIBBED SWEATER",
                image: .of3,
                price: "$25.95"
            ),
            Product(
                name: "CROPPED RIBBED SWEATER",
                image: .of4,
                price: "$25.95"
            )
        ]
    }
}
