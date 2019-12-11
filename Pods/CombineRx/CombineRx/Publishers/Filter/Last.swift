/// Last.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 26/11/19
/// - copyright: 

import RxCocoa
import RxSwift

extension Publishers {

    /// A publisher that only publishes the last element of a stream that satisfies a predicate closure, once the stream finishes.
    public struct LastWhere<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, predicate: @escaping (Publishers.LastWhere<Upstream>.Output) -> Bool) {
            observable = upstream.observable.filter(predicate).takeLast(1)
        }
    }

    /// A publisher that only publishes the last element of a stream that satisfies a error-throwing predicate closure, once the stream finishes.
    public struct TryLastWhere<Upstream> : Publisher where Upstream : Publisher {

        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error

        public init(upstream: Upstream, predicate: @escaping (Publishers.TryLastWhere<Upstream>.Output) throws -> Bool) {
            observable = upstream.observable.filter(predicate).takeLast(1)
        }
    }

    /// A publisher that only publishes the last element of a stream, after the stream finishes.
    public struct Last<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream) {
            observable = upstream.observable.takeLast(1)
        }
    }
}

extension Publisher {

    /// Only publishes the last element of a stream that satisfies a predicate closure, after the stream finishes.
    /// - Parameter predicate: A closure that takes an element as its parameter and returns a Boolean value indicating whether to publish the element.
    /// - Returns: A publisher that only publishes the last element satisfying the given predicate.
    public func last(where predicate: @escaping (Self.Output) -> Bool) -> Publishers.LastWhere<Self> {
        return Publishers.LastWhere(upstream: self, predicate: predicate)
    }

    /// Only publishes the last element of a stream that satisfies a error-throwing predicate closure, after the stream finishes.
    ///
    /// If the predicate closure throws, the publisher fails with the thrown error.
    /// - Parameter predicate: A closure that takes an element as its parameter and returns a Boolean value indicating whether to publish the element.
    /// - Returns: A publisher that only publishes the last element satisfying the given predicate.
    public func tryLast(where predicate: @escaping (Self.Output) throws -> Bool) -> Publishers.TryLastWhere<Self> {
        return Publishers.TryLastWhere(upstream: self, predicate: predicate)
    }
    
    /// Only publishes the last element of a stream, after the stream finishes.
    /// - Returns: A publisher that only publishes the last element of a stream.
    public func last() -> Publishers.Last<Self> {
        return Publishers.Last(upstream: self)
    }
}
