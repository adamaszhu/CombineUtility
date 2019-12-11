/// Catch.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 18/11/19
/// - copyright: 

import RxCocoa
import RxSwift

extension Publishers {

    /// A publisher that handles errors from an upstream publisher by replacing the failed publisher with another publisher.
    public struct Catch<Upstream, NewPublisher> : Publisher where Upstream : Publisher, NewPublisher : Publisher, Upstream.Output == NewPublisher.Output {

        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = NewPublisher.Failure

        /// Creates a publisher that handles errors from an upstream publisher by replacing the failed publisher with another publisher.
        ///
        /// - Parameters:
        ///   - upstream: The publisher that this publisher receives elements from.
        ///   - handler: A closure that accepts the upstream failure as input and returns a publisher to replace the upstream publisher.
        public init(upstream: Upstream, handler: @escaping (Upstream.Failure) -> NewPublisher) {
            observable = upstream.observable.catchError { error -> Observable<Upstream.Output> in
                if let error = error as? Upstream.Failure {
                    return handler(error).observable
                } else {
                    return upstream.observable
                }
            }
        }
    }

    /// A publisher that handles errors from an upstream publisher by replacing the failed publisher with another publisher or optionally producing a new error.
    public struct TryCatch<Upstream, NewPublisher> : Publisher where Upstream : Publisher, NewPublisher : Publisher, Upstream.Output == NewPublisher.Output {

        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error

        public init(upstream: Upstream, handler: @escaping (Upstream.Failure) throws -> NewPublisher) {
            observable = upstream.observable.catchError { error -> Observable<Upstream.Output> in
                if let error = error as? Upstream.Failure {
                    return try handler(error).observable
                } else {
                    return upstream.observable
                }
            }
        }
    }
}

extension Publisher {
    
    /// Handles errors from an upstream publisher by replacing it with another publisher.
    ///
    /// The following example replaces any error from the upstream publisher and replaces the upstream with a `Just` publisher. This continues the stream by publishing a single value and completing normally.
    /// ```
    /// enum SimpleError: Error { case error }
    /// let errorPublisher = (0..<10).publisher.tryMap { v -> Int in
    ///     if v < 5 {
    ///         return v
    ///     } else {
    ///         throw SimpleError.error
    ///     }
    /// }
    ///
    /// let noErrorPublisher = errorPublisher.catch { _ in
    ///     return Just(100)
    /// }
    /// ```
    /// Backpressure note: This publisher passes through `request` and `cancel` to the upstream. After receiving an error, the publisher sends sends any unfulfilled demand to the new `Publisher`.
    /// - Parameter handler: A closure that accepts the upstream failure as input and returns a publisher to replace the upstream publisher.
    /// - Returns: A publisher that handles errors from an upstream publisher by replacing the failed publisher with another publisher.
    public func `catch`<P>(_ handler: @escaping (Self.Failure) -> P) -> Publishers.Catch<Self, P> where P : Publisher, Self.Output == P.Output {
        return Publishers.Catch(upstream: self, handler: handler)
    }

    /// Handles errors from an upstream publisher by either replacing it with another publisher or `throw`ing  a new error.
    ///
    /// - Parameter handler: A `throw`ing closure that accepts the upstream failure as input and returns a publisher to replace the upstream publisher or if an error is thrown will send the error downstream.
    /// - Returns: A publisher that handles errors from an upstream publisher by replacing the failed publisher with another publisher.
    public func tryCatch<P>(_ handler: @escaping (Self.Failure) throws -> P) -> Publishers.TryCatch<Self, P> where P : Publisher, Self.Output == P.Output {
        return Publishers.TryCatch(upstream: self, handler: handler)
    }
}
