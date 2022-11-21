/// Test a publisher
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas
public extension Publisher {
    
    /// Sink a publisher and record any result in `PublisherResult`
    ///
    /// - Returns: The object that contains any events happening in the result
    func test() -> PublisherResult<Output, Failure> {
        let result = PublisherResult<Output, Failure>()
        result.cancellable = sink(receiveFinished: {
            result.hasFinished = true
        }, receiveFailure: { failure in
            result.failure = failure
        }, receiveValue: { value in
            result.outputs.append(value)
        })
        return result
    }
}

import Combine
