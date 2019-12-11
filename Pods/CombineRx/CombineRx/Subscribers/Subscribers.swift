/// Subscribers.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 7/11/19

import RxCocoa
import RxSwift

/// A namespace for types related to the `Subscriber` protocol.
public enum Subscribers {}

extension Subscribers {
    
    /// A signal that a publisher doesn’t produce additional elements, either due to normal completion or an error.
    ///
    /// - finished: The publisher finished normally.
    /// - failure: The publisher stopped publishing due to the indicated error.
    public enum Completion<Failure> where Failure : Error {
        
        case finished
        
        case failure(Failure)
    }
}
