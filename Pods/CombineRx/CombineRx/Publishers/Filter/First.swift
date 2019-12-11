/// First.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 18/11/19
/// - copyright: 

import RxCocoa
import RxSwift

extension Publishers {

    /// A publisher that publishes the first element of a stream, then finishes.
    public struct First<Upstream> : Publisher where Upstream : Publisher {

        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream) {
            observable = upstream.observable.take(1)
        }
    }

    /// A publisher that only publishes the first element of a stream to satisfy a predicate closure.
    public struct FirstWhere<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, predicate: @escaping (Publishers.FirstWhere<Upstream>.Output) -> Bool) {
            observable = upstream.observable.filter(predicate).take(1)
        }
    }

    /// A publisher that only publishes the first element of a stream to satisfy a throwing predicate closure.
    public struct TryFirstWhere<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error

        public init(upstream: Upstream, predicate: @escaping (Publishers.TryFirstWhere<Upstream>.Output) throws -> Bool) {
            observable = upstream.observable.filter(predicate).take(1)
        }
    }
}

extension Publisher {

    /// Publishes the first element of a stream, then finishes.
    ///
    /// If this publisher doesn’t receive any elements, it finishes without publishing.
    /// - Returns: A publisher that only publishes the first element of a stream.
    public func first() -> Publishers.First<Self> {
        return Publishers.First(upstream: self)
    }

    /// Publishes the first element of a stream to satisfy a predicate closure, then finishes.
    ///
    /// The publisher ignores all elements after the first. If this publisher doesn’t receive any elements, it finishes without publishing.
    /// - Parameter predicate: A closure that takes an element as a parameter and returns a Boolean value that indicates whether to publish the element.
    /// - Returns: A publisher that only publishes the first element of a stream that satifies the predicate.
    public func first(where predicate: @escaping (Self.Output) -> Bool) -> Publishers.FirstWhere<Self> {
        return Publishers.FirstWhere(upstream: self, predicate: predicate)
    }

    /// Publishes the first element of a stream to satisfy a throwing predicate closure, then finishes.
    ///
    /// The publisher ignores all elements after the first. If this publisher doesn’t receive any elements, it finishes without publishing. If the predicate closure throws, the publisher fails with an error.
    /// - Parameter predicate: A closure that takes an element as a parameter and returns a Boolean value that indicates whether to publish the element.
    /// - Returns: A publisher that only publishes the first element of a stream that satifies the predicate.
    public func tryFirst(where predicate: @escaping (Self.Output) throws -> Bool) -> Publishers.TryFirstWhere<Self> {
        return Publishers.TryFirstWhere(upstream: self, predicate: predicate)
    }
}
