/// Publisher constants
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas
public extension Publisher {
    
    /// An empty publisher with the current publisher output and failure.
    static var empty: AnyPublisher<Output, Failure> {
        Empty<Output, Failure>()
            .eraseToAnyPublisher()
    }
}

import Combine
