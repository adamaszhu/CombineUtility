/// Filter.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 18/11/19
/// - copyright: 

import RxCocoa
import RxSwift

extension Publishers {

    /// A publisher that republishes all elements that match a provided closure.
    public struct Filter<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, isIncluded: @escaping (Upstream.Output) -> Bool) {
            observable = upstream.observable.filter(isIncluded)
        }
    }

    /// A publisher that republishes all elements that match a provided error-throwing closure.
    public struct TryFilter<Upstream> : Publisher where Upstream : Publisher {

        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error

        public init(upstream: Upstream, isIncluded: @escaping (Upstream.Output) throws -> Bool) {
            observable = upstream.observable.filter(isIncluded)
        }
    }
}

extension Publisher {

    /// Republishes all elements that match a provided closure.
    ///
    /// - Parameter isIncluded: A closure that takes one element and returns a Boolean value indicating whether to republish the element.
    /// - Returns: A publisher that republishes all elements that satisfy the closure.
    public func filter(_ isIncluded: @escaping (Self.Output) -> Bool) -> Publishers.Filter<Self> {
        return Publishers.Filter(upstream: self, isIncluded: isIncluded)
    }

    /// Republishes all elements that match a provided error-throwing closure.
    ///
    /// If the `isIncluded` closure throws an error, the publisher fails with that error.
    ///
    /// - Parameter isIncluded:  A closure that takes one element and returns a Boolean value indicating whether to republish the element.
    /// - Returns:  A publisher that republishes all elements that satisfy the closure.
    public func tryFilter(_ isIncluded: @escaping (Self.Output) throws -> Bool) -> Publishers.TryFilter<Self> {
        return Publishers.TryFilter(upstream: self, isIncluded: isIncluded)
    }
}
