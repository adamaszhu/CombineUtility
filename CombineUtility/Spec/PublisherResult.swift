/// PublisherResult.swift
/// CombineRx
///
/// - author: Adamas Zhu
/// - date: 22/11/19

import Foundation
import CombineRx

/// PublisherResult records events emitted by a publisher.
/// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
final public class PublisherResult<Output, Failure, Cancellable> {
    public internal (set) var outputs: [Output] = []
    public internal (set) var failure: Failure? = nil
    public internal (set) var hasFinished: Bool = false
    public internal (set) var cancellable: Cancellable? = nil
}
