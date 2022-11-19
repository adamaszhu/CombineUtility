/// Convenient function for sink a publisher.
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas
public extension Publisher {
    
    /// Attaches a subscriber with closure-based behavior.
    /// - Parameters:
    ///   - receiveFinished: The closure to execute on finishing
    ///   - receiveFailure: The closure to execute on receipt of a failure
    ///   - receiveValue: The closure to execute on receipt of a value
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func sink(receiveFinished: @escaping () -> Void = {},
              receiveFailure: @escaping (Failure) -> Void = { _ in },
              receiveValue: @escaping (Output) -> Void = { _ in }) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                    receiveFinished()
                case .failure(let error):
                    receiveFailure(error)
            }
        }, receiveValue: receiveValue)
    }
}

import Combine
