/// Sequence.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 7/11/19

import RxCocoa
import RxSwift

extension Publishers {
    
    /// A publisher that publishes a given sequence of elements.
    ///
    /// When the publisher exhausts the elements in the sequence, the next request causes the publisher to finish.
    public struct Sequence<Elements, Failure> : Publisher where Elements : Swift.Sequence, Failure : Error {
        
        public let observable: Observable<Elements.Element>
        
        /// The kind of values published by this publisher.
        public typealias Output = Elements.Element
        
        /// Creates a publisher for a sequence of elements.
        ///
        /// - Parameter sequence: The sequence of elements to publish.
        public init(sequence: Elements) {
            observable = Observable.from(sequence)
        }

        fileprivate init(observable: Observable<Elements.Element>) {
            self.observable = observable
        }
    }
}

extension Publishers.Sequence {
    
    // public func allSatisfy(_ predicate: (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Result<Bool, Failure>.Publisher
    
    // public func tryAllSatisfy(_ predicate: (Publishers.Sequence<Elements, Failure>.Output) throws -> Bool) -> Result<Bool, Error>.Publisher
    
    // public func collect() -> Result<[Publishers.Sequence<Elements, Failure>.Output], Failure>.Publisher
    
    // public func compactMap<T>(_ transform: (Publishers.Sequence<Elements, Failure>.Output) -> T?) -> Publishers.Sequence<[T], Failure>
    
    // public func contains(where predicate: (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Result<Bool, Failure>.Publisher
    
    // public func tryContains(where predicate: (Publishers.Sequence<Elements, Failure>.Output) throws -> Bool) -> Result<Bool, Error>.Publisher
    
    // public func drop(while predicate: (Elements.Element) -> Bool) -> Publishers.Sequence<DropWhileSequence<Elements>, Failure>
    
    // public func dropFirst(_ count: Int = 1) -> Publishers.Sequence<DropFirstSequence<Elements>, Failure>
    
    public func filter(_ isIncluded: @escaping (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure> {
        let observable = self.observable.filter(isIncluded)
        return Publishers.Sequence(observable: observable)
    }
    
    // public func ignoreOutput() -> Empty<Publishers.Sequence<Elements, Failure>.Output, Failure>
    
    public func map<T>(_ transform: @escaping (Elements.Element) -> T) -> Publishers.Sequence<[T], Failure> {
        let observable = self.observable.map(transform)
        return Publishers.Sequence(observable: observable)
    }
    
    // public func prefix(_ maxLength: Int) -> Publishers.Sequence<PrefixSequence<Elements>, Failure>
    
    // public func prefix(while predicate: (Elements.Element) -> Bool) -> Publishers.Sequence<[Elements.Element], Failure>
    
    // public func reduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Publishers.Sequence<Elements, Failure>.Output) -> T) -> Result<T, Failure>.Publisher
    
    // public func tryReduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Publishers.Sequence<Elements, Failure>.Output) throws -> T) -> Result<T, Error>.Publisher
    
    // public func replaceNil<T>(with output: T) -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure> where Elements.Element == T?
    
    // public func scan<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Publishers.Sequence<Elements, Failure>.Output) -> T) -> Publishers.Sequence<[T], Failure>
    
    // public func setFailureType<E>(to error: E.Type) -> Publishers.Sequence<Elements, E> where E : Error
}

extension Publishers.Sequence where Elements : RangeReplaceableCollection {

    public func prepend(_ elements: Publishers.Sequence<Elements, Failure>.Output...) -> Publishers.Sequence<Elements, Failure> {

        if let sequence = elements as? Elements {
            let publisher = Publishers.Sequence<Elements, Failure>(sequence: sequence)
            return Publishers.Sequence<Elements, Failure>(observable: Observable.concat(publisher.observable, observable))
        } else {
            return self
        }
    }

    public func prepend<S>(_ elements: S) -> Publishers.Sequence<Elements, Failure> where S : Sequence, Elements.Element == S.Element {

        let publisher = Publishers.Sequence<S, Failure>(sequence: elements)
        return Publishers.Sequence<Elements, Failure>(observable: Observable.concat(publisher.observable, observable))
    }

    public func prepend(_ publisher: Publishers.Sequence<Elements, Failure>) -> Publishers.Sequence<Elements, Failure> {

        return Publishers.Sequence<Elements, Failure>(observable: Observable.concat(publisher.observable, observable))
    }

    public func append(_ elements: Publishers.Sequence<Elements, Failure>.Output...) -> Publishers.Sequence<Elements, Failure> {

        if let sequence = elements as? Elements {
            let publisher = Publishers.Sequence<Elements, Failure>(sequence: sequence)
            return Publishers.Sequence<Elements, Failure>(observable: Observable.concat(observable, publisher.observable))
        } else {
            return self
        }
    }

    public func append<S>(_ elements: S) -> Publishers.Sequence<Elements, Failure> where S : Sequence, Elements.Element == S.Element {

        let publisher = Publishers.Sequence<S, Failure>(sequence: elements)
        return Publishers.Sequence<Elements, Failure>(observable: Observable.concat(observable, publisher.observable))
    }

    public func append(_ publisher: Publishers.Sequence<Elements, Failure>) -> Publishers.Sequence<Elements, Failure> {

        return Publishers.Sequence<Elements, Failure>(observable: Observable.concat(observable, publisher.observable))
    }
}

extension Publishers.Sequence where Elements.Element : Equatable {

    // public func removeDuplicates() -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure>

    // public func contains(_ output: Elements.Element) -> Result<Bool, Failure>.Publisher
}

extension Sequence {
    
    public var publisher: Publishers.Sequence<Self, Never> {
        return Publishers.Sequence(sequence: self)
    }
}

