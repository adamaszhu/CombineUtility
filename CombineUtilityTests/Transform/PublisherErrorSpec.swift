final class PublisherErrorSpec: QuickSpec {
    
    override func spec() {
        describe("calls mapError(into)") {
            context("with an error") {
                it("returns a publisher with correct error type") {
                    let result = Fail<Int, OtherError>(error: OtherError())
                        .mapError(into: SomeError())
                        .test()
                    expect(result.failure).toEventually(equal(SomeError()))
                }
            }
        }
        describe("calls ignoreError()") {
            context("with an error") {
                it("returns a publisher without any error") {
                    let result = Fail<Int, OtherError>(error: OtherError())
                        .ignoreError()
                        .test()
                    expect(result.failure).toEventually(beNil())
                }
            }
        }
    }
}

import Nimble
import Quick
import Combine
@testable import CombineUtility
