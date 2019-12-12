/// PublisherConstantsSpec.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 12/12/19
/// - copyright: Copyright © 2019 Adamas. All rights reserved.

import Nimble
import Quick
@testable import CombineUtility

#if COMBINE
import Combine
#else
import CombineRx
#endif

@available(iOS 13.0, *)
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
