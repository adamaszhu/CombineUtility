/// Publisher+Constants.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 12/12/19
/// - copyright: Copyright © 2019 Adamas. All rights reserved.

import CombineRx

public extension CombineRx.Publisher {
    
    /// An empty publisher with the current publisher output and failure.
    static var empty: CombineRx.AnyPublisher<Output, Failure> {
        return CombineRx.Empty<Output, Failure>()
            .eraseToAnyPublisher()
    }
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// An empty publisher with the current publisher output and failure.
    static var empty: Combine.AnyPublisher<Output, Failure> {
        return Combine.Empty<Output, Failure>()
            .eraseToAnyPublisher()
    }
}

#endif
