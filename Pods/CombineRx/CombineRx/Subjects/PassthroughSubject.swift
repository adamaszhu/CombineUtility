/// PassthroughSubject.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 19/11/19
/// - copyright: 

import RxCocoa
import RxSwift

final public class PassthroughSubject<Output, Failure> : Subject where Failure : Error {
    
    public let observable: Observable<Output>
    
    public var observer: AnyObserver<Output> {
        return publishSubject.asObserver()
    }
    
    private let publishSubject: PublishSubject<Output>

    public init() {
        publishSubject = PublishSubject<Output>()
        observable = publishSubject.asObservable()
    }

    /// Provides this Subject an opportunity to establish demand for any new upstream subscriptions (say via, ```Publisher.subscribe<S: Subject>(_: Subject)`
    // final public func send(subscription: Subscription)

    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    final public func send(_ input: Output) {
        publishSubject.onNext(input)
    }

    /// Sends a completion signal to the subscriber.
    ///
    /// - Parameter completion: A `Completion` instance which indicates whether publishing has finished normally or failed with an error.
    final public func send(completion: Subscribers.Completion<Failure>) {
        switch completion {
        case .finished:
            publishSubject.onCompleted()
        case .failure(let error):
            publishSubject.onError(error)
        }
    }
}
