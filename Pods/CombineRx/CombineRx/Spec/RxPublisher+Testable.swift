/// Publisher+Testable.swift
/// CombineRx
///
/// - author: Adamas
/// - date: 2/12/19
/// - copyright: 

public extension Publisher {
    
    /// Sink a publisher and record any result in `PublisherResult`
    ///
    /// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
    /// - Returns: The object that contains any events happening in the result
    func test() -> PublisherResult<Output, Failure, Cancellable> {
        let result = PublisherResult<Output, Failure, Cancellable>()
        result.cancellable = sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    result.hasFinished = true
                case .failure(let failure):
                    result.failure = failure
                }
            },
            receiveValue: { output in
                result.outputs.append(output)
        })
        return result
    }
}
