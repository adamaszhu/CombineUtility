/// AnyCancellable.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 13/11/19

import RxCocoa
import RxSwift

/// A type-erasing cancellable object that executes a provided closure when canceled.
///
/// Subscriber implementations can use this type to provide a “cancellation token” that makes it possible for a caller to cancel a publisher, but not to use the `Subscription` object to request items.
/// An AnyCancellable instance automatically calls `cancel()` when deinitialized.
final public class AnyCancellable : Cancellable, Hashable {
    
    public var disposable: Disposable?

    /// Initializes the cancellable object with the given cancel-time closure.
    ///
    /// - Parameter cancel: A closure that the `cancel()` method executes.
    // public init(_ cancel: @escaping () -> Void)

    public init<C>(_ canceller: C) where C : Cancellable {
        self.disposable = canceller.disposable
    }

    /// Cancel the activity.
    final public func cancel() {
        disposable?.dispose()
    }

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    final public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: AnyCancellable, rhs: AnyCancellable) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
}
