//
//  Publisher+Testable.swift
//  CombineRx
//
//  Created by Leon Nguyen on 28/11/19.
//

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// Sink a publisher and record any result in `PublisherResult`
    ///
    /// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
    /// - Returns: The object that contains any events happening in the result
    func test() -> PublisherResult<Output, Failure, Combine.Cancellable> {
        let result = PublisherResult<Output, Failure, Combine.Cancellable>()
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

#endif

import CombineRx

public extension CombineRx.Publisher {
    
    /// Sink a publisher and record any result in `PublisherResult`
    ///
    /// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
    /// - Returns: The object that contains any events happening in the result
    func test() -> PublisherResult<Output, Failure, CombineRx.Cancellable> {
        let result = PublisherResult<Output, Failure, CombineRx.Cancellable>()
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
