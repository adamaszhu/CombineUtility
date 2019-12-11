/// Empty.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 21/11/19
/// - copyright: 

import RxCocoa
import RxSwift

/// A publisher that never publishes any values, and optionally finishes immediately.
///
/// You can create a ”Never” publisher — one which never sends values and never finishes or fails — with the initializer `Empty(completeImmediately: false)`.
public struct Empty<Output, Failure> : Publisher where Failure : Error {
    
    public let observable: Observable<Output>
    
    /// Creates an empty publisher.
    ///
    /// - Parameter completeImmediately: A Boolean value that indicates whether the publisher should immediately finish.
    public init(completeImmediately: Bool = true) {
        observable = completeImmediately
            ? Observable<Output>.empty()
            : Observable<Output>.never()
    }

    /// Creates an empty publisher with the given completion behavior and output and failure types.
    ///
    /// Use this initializer to connect the empty publisher to subscribers or other publishers that have specific output and failure types.
    /// - Parameters:
    ///   - completeImmediately: A Boolean value that indicates whether the publisher should immediately finish.
    ///   - outputType: The output type exposed by this publisher.
    ///   - failureType: The failure type exposed by this publisher.
    public init(completeImmediately: Bool = true, outputType: Output.Type, failureType: Failure.Type) {
        observable = completeImmediately
            ? Observable<Output>.empty()
            : Observable<Output>.never()
    }
}
