//
//  CombineLatest.swift
//  CombineRx
//
//  Created by Leon Nguyen on 26/11/19.
//

import Foundation
import RxSwift

extension Publishers {

    /// A publisher that receives and combines the latest elements from two publishers.
    public struct CombineLatest<A, B> : Publisher where A : Publisher, B : Publisher, A.Failure == B.Failure {

        public let observable: Observable<(A.Output, B.Output)>

        /// The kind of values published by this publisher.
        public typealias Output = (A.Output, B.Output)

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A

        public let b: B

        public init(_ a: A, _ b: B) {
            self.a = a
            self.b = b
            self.observable = Observable.combineLatest(a.observable, b.observable)
        }

        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
        ///
        /// - SeeAlso: `subscribe(_:)`
        /// - Parameters:
        ///     - subscriber: The subscriber to attach to this `Publisher`.
        ///                   once attached it can begin to receive values.
        public func receive<S>(subscriber: S)
            where S : Subscriber, B.Failure == S.Failure, S.Input == (A.Output, B.Output) {
                let disposable = observable.subscribe(subscriber.observer)
                var subscriber = subscriber as? Cancellable
                subscriber?.disposable = disposable
        }
    }

    /// A publisher that receives and combines the latest elements from three publishers.
    public struct CombineLatest3<A, B, C> : Publisher where A : Publisher, B : Publisher, C : Publisher, A.Failure == B.Failure, B.Failure == C.Failure {

        public let observable: Observable<(A.Output, B.Output, C.Output)>

        /// The kind of values published by this publisher.
        public typealias Output = (A.Output, B.Output, C.Output)

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A

        public let b: B

        public let c: C

        public init(_ a: A, _ b: B, _ c: C) {
            self.a = a
            self.b = b
            self.c = c
            self.observable = Observable.combineLatest(a.observable, b.observable, c.observable)
        }

        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
        ///
        /// - SeeAlso: `subscribe(_:)`
        /// - Parameters:
        ///     - subscriber: The subscriber to attach to this `Publisher`.
        ///                   once attached it can begin to receive values.
        public func receive<S>(subscriber: S)
            where S : Subscriber, C.Failure == S.Failure, S.Input == (A.Output, B.Output, C.Output) {
                let disposable = observable.subscribe(subscriber.observer)
                var subscriber = subscriber as? Cancellable
                subscriber?.disposable = disposable
        }
    }

    /// A publisher that receives and combines the latest elements from four publishers.
    public struct CombineLatest4<A, B, C, D> : Publisher where A : Publisher, B : Publisher, C : Publisher, D : Publisher, A.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure {

        public let observable: Observable<(A.Output, B.Output, C.Output, D.Output)>

        /// The kind of values published by this publisher.
        public typealias Output = (A.Output, B.Output, C.Output, D.Output)

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = A.Failure

        public let a: A

        public let b: B

        public let c: C

        public let d: D

        public init(_ a: A, _ b: B, _ c: C, _ d: D) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.observable = Observable.combineLatest(a.observable, b.observable, c.observable, d.observable)
        }

        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
        ///
        /// - SeeAlso: `subscribe(_:)`
        /// - Parameters:
        ///     - subscriber: The subscriber to attach to this `Publisher`.
        ///                   once attached it can begin to receive values.
        public func receive<S>(subscriber: S)
            where S : Subscriber, D.Failure == S.Failure,
            S.Input == (A.Output, B.Output, C.Output, D.Output) {
                let disposable = observable.subscribe(subscriber.observer)
                var subscriber = subscriber as? Cancellable
                subscriber?.disposable = disposable
        }
    }
}


extension Publisher {

    /// Subscribes to an additional publisher and publishes a tuple upon receiving output from either publisher.
    ///
    /// The combined publisher passes through any requests to *all* upstream publishers. However, it still obeys the demand-fulfilling rule of only sending the request amount downstream. If the demand isn’t `.unlimited`, it drops values from upstream publishers. It implements this by using a buffer size of 1 for each upstream, and holds the most recent value in each buffer.
    /// All upstream publishers need to finish for this publisher to finsh. If an upstream publisher never publishes a value, this publisher never finishes.
    /// If any of the combined publishers terminates with a failure, this publisher also fails.
    /// - Parameters:
    ///   - other: Another publisher to combine with this one.
    /// - Returns: A publisher that receives and combines elements from this and another publisher.
    public func combineLatest<P>(_ other: P) -> Publishers.CombineLatest<Self, P>
        where P : Publisher, Self.Failure == P.Failure {
            return Publishers.CombineLatest(self, other)
    }

//    /// Subscribes to an additional publisher and invokes a closure upon receiving output from either publisher.
//    ///
//    /// The combined publisher passes through any requests to *all* upstream publishers. However, it still obeys the demand-fulfilling rule of only sending the request amount downstream. If the demand isn’t `.unlimited`, it drops values from upstream publishers. It implements this by using a buffer size of 1 for each upstream, and holds the most recent value in each buffer.
//    /// All upstream publishers need to finish for this publisher to finsh. If an upstream publisher never publishes a value, this publisher never finishes.
//    /// If any of the combined publishers terminates with a failure, this publisher also fails.
//    /// - Parameters:
//    ///   - other: Another publisher to combine with this one.
//    ///   - transform: A closure that receives the most recent value from each publisher and returns a new value to publish.
//    /// - Returns: A publisher that receives and combines elements from this and another publisher.
//    public func combineLatest<P, T>(_ other: P, _ transform: @escaping (Self.Output, P.Output) -> T) -> Publishers.Map<Publishers.CombineLatest<Self, P>, T> where P : Publisher, Self.Failure == P.Failure

    /// Subscribes to two additional publishers and publishes a tuple upon receiving output from any of the publishers.
    ///
    /// The combined publisher passes through any requests to *all* upstream publishers. However, it still obeys the demand-fulfilling rule of only sending the request amount downstream. If the demand isn’t `.unlimited`, it drops values from upstream publishers. It implements this by using a buffer size of 1 for each upstream, and holds the most recent value in each buffer.
    /// All upstream publishers need to finish for this publisher to finish. If an upstream publisher never publishes a value, this publisher never finishes.
    /// If any of the combined publishers terminates with a failure, this publisher also fails.
    /// - Parameters:
    ///   - publisher1: A second publisher to combine with this one.
    ///   - publisher2: A third publisher to combine with this one.
    /// - Returns: A publisher that receives and combines elements from this publisher and two other publishers.
    public func combineLatest<P, Q>(_ publisher1: P, _ publisher2: Q) -> Publishers.CombineLatest3<Self, P, Q>
        where P : Publisher, Q : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure {
            return Publishers.CombineLatest3(self, publisher1, publisher2)
    }

//    /// Subscribes to two additional publishers and invokes a closure upon receiving output from any of the publishers.
//    ///
//    /// The combined publisher passes through any requests to *all* upstream publishers. However, it still obeys the demand-fulfilling rule of only sending the request amount downstream. If the demand isn’t `.unlimited`, it drops values from upstream publishers. It implements this by using a buffer size of 1 for each upstream, and holds the most recent value in each buffer.
//    /// All upstream publishers need to finish for this publisher to finish. If an upstream publisher never publishes a value, this publisher never finishes.
//    /// If any of the combined publishers terminates with a failure, this publisher also fails.
//    /// - Parameters:
//    ///   - publisher1: A second publisher to combine with this one.
//    ///   - publisher2: A third publisher to combine with this one.
//    ///   - transform: A closure that receives the most recent value from each publisher and returns a new value to publish.
//    /// - Returns: A publisher that receives and combines elements from this publisher and two other publishers.
//    public func combineLatest<P, Q, T>(_ publisher1: P, _ publisher2: Q, _ transform: @escaping (Self.Output, P.Output, Q.Output) -> T) -> Publishers.Map<Publishers.CombineLatest3<Self, P, Q>, T> where P : Publisher, Q : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure

    /// Subscribes to three additional publishers and publishes a tuple upon receiving output from any of the publishers.
    ///
    /// The combined publisher passes through any requests to *all* upstream publishers. However, it still obeys the demand-fulfilling rule of only sending the request amount downstream. If the demand isn’t `.unlimited`, it drops values from upstream publishers. It implements this by using a buffer size of 1 for each upstream, and holds the most recent value in each buffer.
    /// All upstream publishers need to finish for this publisher to finish. If an upstream publisher never publishes a value, this publisher never finishes.
    /// If any of the combined publishers terminates with a failure, this publisher also fails.
    /// - Parameters:
    ///   - publisher1: A second publisher to combine with this one.
    ///   - publisher2: A third publisher to combine with this one.
    ///   - publisher3: A fourth publisher to combine with this one.
    /// - Returns: A publisher that receives and combines elements from this publisher and three other publishers.
    public func combineLatest<P, Q, R>(_ publisher1: P, _ publisher2: Q, _ publisher3: R) -> Publishers.CombineLatest4<Self, P, Q, R>
        where P : Publisher, Q : Publisher, R : Publisher,
        Self.Failure == P.Failure, P.Failure == Q.Failure, Q.Failure == R.Failure {
            return Publishers.CombineLatest4(self, publisher1, publisher2, publisher3)
    }

//    /// Subscribes to three additional publishers and invokes a closure upon receiving output from any of the publishers.
//    ///
//    /// The combined publisher passes through any requests to *all* upstream publishers. However, it still obeys the demand-fulfilling rule of only sending the request amount downstream. If the demand isn’t `.unlimited`, it drops values from upstream publishers. It implements this by using a buffer size of 1 for each upstream, and holds the most recent value in each buffer.
//    /// All upstream publishers need to finish for this publisher to finish. If an upstream publisher never publishes a value, this publisher never finishes.
//    /// If any of the combined publishers terminates with a failure, this publisher also fails.
//    /// - Parameters:
//    ///   - publisher1: A second publisher to combine with this one.
//    ///   - publisher2: A third publisher to combine with this one.
//    ///   - publisher3: A fourth publisher to combine with this one.
//    ///   - transform: A closure that receives the most recent value from each publisher and returns a new value to publish.
//    /// - Returns: A publisher that receives and combines elements from this publisher and three other publishers.
//    public func combineLatest<P, Q, R, T>(_ publisher1: P, _ publisher2: Q, _ publisher3: R, _ transform: @escaping (Self.Output, P.Output, Q.Output, R.Output) -> T) -> Publishers.Map<Publishers.CombineLatest4<Self, P, Q, R>, T> where P : Publisher, Q : Publisher, R : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure, Q.Failure == R.Failure
}
