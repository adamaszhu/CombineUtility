/// Publisher+Sink.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 20/2/20
/// - copyright: Copyright © 2020 Adamas. All rights reserved.

import CombineRx

public extension CombineRx.Publisher {
    
    /// Attaches a subscriber with closure-based behavior.
    /// - Parameters:
    ///   - receiveFinished: The closure to execute on finishing
    ///   - receiveFailure: The closure to execute on receipt of a failure
    ///   - receiveValue: The closure to execute on receipt of a value
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func sink(receiveFinished: @escaping (() -> Void) = {},
              receiveFailure: @escaping ((Self.Failure) -> Void) = { _ in },
              receiveValue: @escaping ((Self.Output) -> Void) = { _ in }) -> CombineRx.AnyCancellable {
        return sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            receiveFinished()
                        case .failure(let error):
                            receiveFailure(error)
                        }
                    },
                    receiveValue: receiveValue)
    }
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// Attaches a subscriber with closure-based behavior.
    /// - Parameters:
    ///   - receiveFinished: The closure to execute on finishing
    ///   - receiveFailure: The closure to execute on receipt of a failure
    ///   - receiveValue: The closure to execute on receipt of a value
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func sink(receiveFinished: @escaping (() -> Void) = {},
              receiveFailure: @escaping ((Self.Failure) -> Void) = { _ in },
              receiveValue: @escaping ((Self.Output) -> Void) = { _ in }) -> Combine.AnyCancellable {
        return sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            receiveFinished()
                        case .failure(let error):
                            receiveFailure(error)
                        }
                    },
                    receiveValue: receiveValue)
    }
}

#endif
