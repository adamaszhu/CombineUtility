/// FlatMap.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 18/11/19
/// - copyright: 

import RxCocoa
import RxSwift

extension Publishers {

    public struct FlatMap<NewPublisher, Upstream> : Publisher where NewPublisher : Publisher, Upstream : Publisher, NewPublisher.Failure == Upstream.Failure {
        
        public let observable: Observable<NewPublisher.Output>

        /// The kind of values published by this publisher.
        public typealias Output = NewPublisher.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, maxPublishers: Subscribers.Demand, transform: @escaping (Upstream.Output) -> NewPublisher) {
            observable = upstream.observable.flatMap { output in
                return transform(output).observable
            }
        }
    }
}

extension Publisher {

    /// Transforms all elements from an upstream publisher into a new or existing publisher.
    ///
    /// `flatMap` merges the output from all returned publishers into a single stream of output.
    ///
    /// - Parameters:
    ///   - maxPublishers: The maximum number of publishers produced by this method.
    ///   - transform: A closure that takes an element as a parameter and returns a publisher
    /// that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream publisher into
    /// a publisher of that element’s type.
    public func flatMap<T, P>(maxPublishers: Subscribers.Demand = .unlimited, _ transform: @escaping (Self.Output) -> P) -> Publishers.FlatMap<P, Self> where T == P.Output, P : Publisher, Self.Failure == P.Failure {
        return Publishers.FlatMap(upstream: self, maxPublishers: maxPublishers, transform: transform)
    }
}
