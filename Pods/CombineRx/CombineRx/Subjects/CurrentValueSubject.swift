/// CurrentValueSubject.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 7/11/19

import RxCocoa
import RxSwift

/// A subject that wraps a single value and publishes a new element whenever the value changes.
final public class CurrentValueSubject<Output, Failure> : Subject where Failure : Error {
    
    public let observable: Observable<Output>
    
    public var observer: AnyObserver<Output> {
        return behaviourSubject.asObserver()
    }
    
    private let behaviourSubject: BehaviorSubject<Output>
    private let initialValue: Output
    
    /// The value wrapped by this subject, published as a new element whenever it changes.
    final public var value: Output {
        get {
            let currentValue = try? behaviourSubject.value()
            return currentValue ?? initialValue
        }
        set {
            behaviourSubject.onNext(newValue)
        }
    }
    
    /// Creates a current value subject with the given initial value.
    ///
    /// - Parameter value: The initial value to publish.
    public init(_ value: Output) {
        behaviourSubject = BehaviorSubject(value: value)
        observable = behaviourSubject.asObserver()
        initialValue = value
    }
    
    /// Provides this Subject an opportunity to establish demand for any new upstream subscriptions (say via, ```Publisher.subscribe<S: Subject>(_: Subject)`
    // final public func send(subscription: Subscription)
    
    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    final public func send(_ input: Output) {
        behaviourSubject.onNext(input)
    }
    
    /// Sends a completion signal to the subscriber.
    ///
    /// - Parameter completion: A `Completion` instance which indicates whether publishing has finished normally or failed with an error.
    final public func send(completion: Subscribers.Completion<Failure>) {
        switch completion {
        case .failure(let error):
            behaviourSubject.onError(error)
        case .finished:
            behaviourSubject.onCompleted()
        }
    }
}
