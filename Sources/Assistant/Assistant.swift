// The Swift Programming Language
// https://docs.swift.org/swift-book

public protocol AssistantDataSource {
}

public final actor Assistant {
    private let datasource: AssistantDataSource

    public init(datasource: AssistantDataSource) {
        self.datasource = datasource
    }

}
