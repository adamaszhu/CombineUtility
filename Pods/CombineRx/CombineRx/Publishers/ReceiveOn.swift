/// ReceiveOn.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 13/11/19

import RxCocoa
import RxSwift

extension Publishers {

    /// A publisher that delivers elements to its downstream subscriber on a specific scheduler.
    public struct ReceiveOn<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
        
        public let observable: Observable<Upstream.Output>

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, scheduler: Context, options: Context.CombineSchedulerOptions?) {
            observable = upstream.observable.observeOn(scheduler.schedulerType)
        }
    }
}
