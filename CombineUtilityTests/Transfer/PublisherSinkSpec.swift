/// PublisherSinkSpec.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 20/2/20
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
final class PublisherSinkSpec: QuickSpec {
    
    override func spec() {
        describe("calls sink(receiveFinished:receiveFailure:receiveValue)") {
            context("with a value") {
                it("gets the value") {
                    var value: Int?
                    let _ = Just<Int>(0)
                        .sink(receiveValue: { value = $0 })
                    expect(value).toEventually(equal(0))
                }
                it("finishes") {
                    var isFinished = false
                    let _ = Just<Int>(0)
                        .sink(receiveFinished: { isFinished = true })
                    expect(isFinished).toEventually(beTrue())
                }
                it("gets no error") {
                    var error: SomeError?
                    let _ = Just<Int>(0)
                        .sink(receiveFailure: { _ in error = SomeError() })
                    expect(error).toEventually(beNil())
                }
            }
            context("with an error") {
                it("gets no value") {
                    var value: Int?
                    let _ = Fail<Int, SomeError>(error: SomeError())
                        .sink(receiveValue: { value = $0 })
                    expect(value).toEventually(beNil())
                }
                it("doesn't finish") {
                    var isFinished = false
                    let _ = Fail<Int, SomeError>(error: SomeError())
                        .sink(receiveFinished: { isFinished = true })
                    expect(isFinished).toEventually(beFalse())
                }
                it("gets the error") {
                    var error: SomeError?
                    let _ = Fail<Int, SomeError>(error: SomeError())
                        .sink(receiveFailure: { error = $0 })
                    expect(error).toEventuallyNot(beNil())
                }
            }
        }
    }
}
