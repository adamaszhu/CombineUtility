/// Error related conversion.
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas
public extension Publisher {
    
    /// Map any error into a specific error.
    /// - Parameter error: Default error case if the detected error has a different error type.
    /// - Returns: The publisher with the new error type.
    func mapError<E>(into error: E) -> AnyPublisher<Output, E> where E : Error {
        mapError { ($0 as? E) ?? error }
            .eraseToAnyPublisher()
    }
    
    /// Ignore errors occur in the publisher.
    /// - Returns: The publisher with no error.
    func ignoreError() -> AnyPublisher<Output, Never> {
        self.catch { _ in AnyPublisher<Output, Never>.empty }
            .eraseToAnyPublisher()
    }
}

import Combine
