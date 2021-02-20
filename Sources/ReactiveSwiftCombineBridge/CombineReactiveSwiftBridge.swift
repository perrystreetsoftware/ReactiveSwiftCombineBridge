//
//  File.swift
//  
//
//  Created by Eric Silverberg on 2/20/21.
//

import Foundation
import ReactiveSwift

#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, macCatalyst 13.0, watchOS 6.0, *)
extension Publisher {
    public func producer() -> SignalProducer<Output, Failure> {
        return SignalProducer { observer, lifetime in
            lifetime += self.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        observer.send(error: error)
                    case .finished:
                        observer.sendCompleted()
                    }
                },
                receiveValue: observer.send(value:)
            )
        }
    }
}
#endif
