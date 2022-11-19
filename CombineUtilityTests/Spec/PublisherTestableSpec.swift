final class PublisherTestableSpec: QuickSpec {
    
    override func spec() {
        describe("calls test()") {
            context("with value") {
                it("stores the value") {
                    let subject = CurrentValueSubject<Int?, Never>(nil)
                    let result = subject.test()
                    subject.value = 1
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
            context("with finishing events") {
                it("stores the flag") {
                    let publisher = Just(1)
                    let result = publisher.test()
                    expect(result.hasFinished).toEventually(equal(true))
                }
            }
            context("with errors") {
                it("stores the error") {
                    let publisher = Fail<Int, SomeError>(error: SomeError())
                    let result = publisher.test()
                    expect(result.failure).toEventuallyNot(beNil())
                }
            }
        }
    }
}

import Nimble
import Quick
import Combine
@testable import CombineUtility
