//
//  File.swift
//  
//
//  Created by Eric Silverberg on 11/17/20.
//

import Foundation
import ReactiveSwift
import Combine
import XCTest
import CombineExpectations
@testable import ReactiveSwiftCombineBridge

final class ReactiveSwiftTests: XCTestCase {
    func testSubscribeExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let producer = SignalProducer<Int, Never> { (observer, _) in
            observer.send(value: 1)
            observer.sendCompleted()
        }

        let recorder = producer.publisher().record()
        let nextInt = try? recorder.next().get()

        XCTAssertEqual(nextInt, 1)
    }

    func testCombineToReactiveSwift() {
        let producer = Future<Int, Never> { promise in
            promise(.success(1))
        }.eraseToAnyPublisher()
         .producer()

        let exp = expectation(description: "Stream complete")

        producer.startWithCompleted {
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)
    }
}
