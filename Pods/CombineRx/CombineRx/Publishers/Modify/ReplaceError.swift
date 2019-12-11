/// ReplaceError.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 22/11/19
/// - copyright:

import RxSwift
import RxCocoa

extension Publishers {
    
    /// A publisher that replaces any errors in the stream with a provided element.
    public struct ReplaceError<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Observable<Upstream.Output>
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output
        
        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Never
        
        public init(upstream: Upstream, output: Publishers.ReplaceError<Upstream>.Output) {
            observable = upstream.observable.catchErrorJustReturn(output)
        }
    }
}


extension Publisher {

    /// Replaces any errors in the stream with the provided element.
    ///
    /// If the upstream publisher fails with an error, this publisher emits the provided element, then finishes normally.
    /// - Parameter output: An element to emit when the upstream publisher fails.
    /// - Returns: A publisher that replaces an error from the upstream publisher with the provided output element.
    public func replaceError(with output: Self.Output) -> Publishers.ReplaceError<Self> {
        return Publishers.ReplaceError(upstream: self, output: output)
    }
}
