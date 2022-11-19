final class PublisherConstantsSpec: QuickSpec {
    
    override func spec() {
        describe("has empty") {
            context("with a publisher type") {
                it("returns an empty publisher") {
                    let publisher = AnyPublisher<Int, Never>.empty
                    let result = publisher.test()
                    expect(result.outputs.isEmpty).toEventually(equal(true))
                }
            }
        }
    }
}

import Nimble
import Quick
import Combine
@testable import CombineUtility
