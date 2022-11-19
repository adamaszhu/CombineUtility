/// Nil related supports.
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas
public extension Publisher {
    
    /// Remove all nil values from the stream
    /// - Returns: The publisher with no nil value. 
    func removeNil<O>() -> AnyPublisher<O, Failure> where O? == Output {
        compactMap { $0 }
            .eraseToAnyPublisher()
    }
}

import Combine
