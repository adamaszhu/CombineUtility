/// Convenient operator for storing the cancellable object
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas

/// Append a cancellable object to a collection
/// - Parameters:
///   - cancellables: The collection
///   - cancellable: The new cancellable object
public func += (cancellables: inout [Cancellable], cancellable: Cancellable) {
    cancellables.append(cancellable)
}

import Combine
