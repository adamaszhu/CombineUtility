/// Operator+Cancellable.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 12/2/20
/// - copyright: Copyright © 2020 Adamas. All rights reserved.

import CombineRx

/// Append a cancellable object to a collection
/// - Parameters:
///   - cancellables: The collection
///   - cancellable: The new cancellable object
public func += (cancellables: inout [CombineRx.Cancellable], cancellable: CombineRx.Cancellable) {
    cancellables.append(cancellable)
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
/// Append a cancellable object to a collection
/// - Parameters:
///   - cancellables: The collection
///   - cancellable: The new cancellable object
public func += (cancellables: inout [Combine.Cancellable], cancellable: Combine.Cancellable) {
    cancellables.append(cancellable)
}

#endif
