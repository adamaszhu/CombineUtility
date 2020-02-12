/// OperatorCancellableSpec.swift
/// CombineUtility
///
/// - author: Adamas
/// - date: 12/2/20
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
