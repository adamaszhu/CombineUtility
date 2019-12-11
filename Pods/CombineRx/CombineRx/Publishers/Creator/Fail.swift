/// Fail.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 22/11/19
/// - copyright: 

import RxSwift
import RxCocoa

/// A publisher that immediately terminates with the specified error.
public struct Fail<Output, Failure> : Publisher where Failure : Error {
    
    public let observable: Observable<Output>

    /// Creates a publisher that immediately terminates with the specified failure.
    ///
    /// - Parameter error: The failure to send when terminating the publisher.
    public init(error: Failure) {
        observable = Observable<Output>.error(error)
    }

    /// Creates publisher with the given output type, that immediately terminates with the specified failure.
    ///
    /// Use this initializer to create a `Fail` publisher that can work with subscribers or publishers that expect a given output type.
    /// - Parameters:
    ///   - outputType: The output type exposed by this publisher.
    ///   - failure: The failure to send when terminating the publisher.
    public init(outputType: Output.Type, failure: Failure) {
        observable = Observable<Output>.error(failure)
    }
}
