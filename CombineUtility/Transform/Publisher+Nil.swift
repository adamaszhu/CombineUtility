/// Publisher+Nil.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 11/2/20
/// - copyright: Copyright © 2020 Adamas. All rights reserved.

import CombineRx

public extension CombineRx.Publisher {
    
    /// Remove all nil values from the stream
    func removeNil<O>() -> CombineRx.AnyPublisher<O, Failure> where O? == Output {
        return filter { $0 != nil }
            .map { $0! }
            .eraseToAnyPublisher()
    }
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// Remove all nil values from the stream
    func removeNil<O>() -> Combine.AnyPublisher<O, Failure> where O? == Output {
        return filter { $0 != nil }
            .map { $0! }
            .eraseToAnyPublisher()
    }
}

#endif
