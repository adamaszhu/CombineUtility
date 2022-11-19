final class PublisherNilSpec: QuickSpec {
    
    override func spec() {
        describe("calls removeNil()") {
            context("with nil value") {
                it("returns a publisher with non nil outputs") {
                    let subject = CurrentValueSubject<Int?, Never>(nil)
                    let result = subject
                        .removeNil()
                        .test()
                    subject.value = 1
                    subject.value = nil
                    subject.value = 2
                    subject.value = nil
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
    }
}

import Nimble
import Quick
import Combine
@testable import CombineUtility
