/// Publisher+Errors.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 9/1/20
/// - copyright: Copyright © 2020 Adamas. All rights reserved.

import CombineRx

public extension CombineRx.Publisher {
    
    /// Map any error into a specific error.
    /// - Parameter error: The error to be mapped into.
    func mapError<E>(into error: E) -> CombineRx.AnyPublisher<Output, E> where E : Error {
        return mapError { _ in error }
            .eraseToAnyPublisher()
    }
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// Map any error into a specific error.
    /// - Parameter error: The error to be mapped into.
    func mapError<E>(into error: E) -> Combine.AnyPublisher<Output, E> where E : Error {
        return mapError { _ in error }
            .eraseToAnyPublisher()
    }
}

#endif
