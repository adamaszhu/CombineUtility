/// PublisherNilSpec.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 11/2/20
/// - copyright: Copyright © 2020 Adamas. All rights reserved.

import Nimble
import Quick
@testable import CombineUtility

#if COMBINE
import Combine
#else
import CombineRx
#endif

@available(iOS 13.0, *)
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
