/// ReplaceEmpty.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 21/11/19
/// - copyright: 

import RxSwift
import RxCocoa

extension Publishers {

    /// A publisher that replaces an empty stream with a provided element.
    public struct ReplaceEmpty<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, output: Publishers.ReplaceEmpty<Upstream>.Output) {
            observable = upstream.observable.ifEmpty(default: output)
        }
    }
}


extension Publisher {

    /// Replaces an empty stream with the provided element.
    ///
    /// If the upstream publisher finishes without producing any elements, this publisher emits the provided element, then finishes normally.
    /// - Parameter output: An element to emit when the upstream publisher finishes without emitting any elements.
    /// - Returns: A publisher that replaces an empty stream with the provided output element.
    public func replaceEmpty(with output: Self.Output) -> Publishers.ReplaceEmpty<Self> {
        return Publishers.ReplaceEmpty(upstream: self, output: output)
    }
}
