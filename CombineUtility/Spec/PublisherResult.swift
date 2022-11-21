/// PublisherResult records events emitted by a publisher.
///
/// - version: 1.0.0
/// - date: 18/11/22
/// - author: Adamas
final public class PublisherResult<Output, Failure> {

    /// Received outputs
    public internal (set) var outputs: [Output] = []

    /// Detected error
    public internal (set) var failure: Failure? = nil

    /// Whether the publisher has finished or not
    public internal (set) var hasFinished: Bool = false

    /// Cancellable of the subscription
    public internal (set) var cancellable: AnyCancellable? = nil
}

import Combine
