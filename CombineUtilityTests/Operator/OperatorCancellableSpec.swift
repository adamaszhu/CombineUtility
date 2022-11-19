final class OperatorCancellableSpec: QuickSpec {
    
    override func spec() {
        describe("calls +=(cancellables:cancellable)") {
            context("with a cancellable object") {
                it("adds the object into the collection") {
                    var cancellables = [Cancellable]()
                    cancellables += Just<Int>(0)
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { _ in })
                    expect(cancellables.count) == 1
                }
            }
        }
    }
}

import Nimble
import Quick
import Combine
@testable import CombineUtility
