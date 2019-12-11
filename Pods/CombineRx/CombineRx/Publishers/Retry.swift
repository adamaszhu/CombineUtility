/// Retry.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 18/11/19
/// - copyright: 

import RxCocoa
import RxSwift

extension Publishers {

    /// A publisher that attempts to recreate its subscription to a failed upstream publisher.
    public struct Retry<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        /// Creates a publisher that attempts to recreate its subscription to a failed upstream publisher.
        ///
        /// - Parameters:
        ///   - upstream: The publisher from which this publisher receives its elements.
        ///   - retries: The maximum number of retry attempts to perform. If `nil`, this publisher attempts to reconnect with the upstream publisher an unlimited number of times.
        public init(upstream: Upstream, retries: Int?) {
            observable = upstream.observable.retry(retries ?? Int.max)
        }
    }
}

extension Publisher {

    /// Attempts to recreate a failed subscription with the upstream publisher using a specified number of attempts to establish the connection.
    ///
    /// After exceeding the specified number of retries, the publisher passes the failure to the downstream receiver.
    /// - Parameter retries: The number of times to attempt to recreate the subscription.
    /// - Returns: A publisher that attempts to recreate its subscription to a failed upstream publisher.
    public func retry(_ retries: Int) -> Publishers.Retry<Self> {
        return Publishers.Retry(upstream: self, retries: retries)
    }
}
