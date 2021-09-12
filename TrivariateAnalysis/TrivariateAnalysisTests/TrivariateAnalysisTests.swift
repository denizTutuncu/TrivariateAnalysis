//
//  TrivariateAnalysisTests.swift
//  TrivariateAnalysisTests
//
//  Created by Deniz Tutuncu on 9/11/21.
//

import XCTest

protocol ExpectedDurationCalculation {
    typealias Result = Swift.Result<Double, Error>
    static func calculateExpectedDuration() -> Result
}

final class EstimationEngine: ExpectedDurationCalculation {
    private init() {}
    
    static func calculateExpectedDuration() -> ExpectedDurationCalculation.Result {
        return Result { 0 }
    }
}

class TrivariateAnalysisTests: XCTestCase {
    
    func test_calculateExpectedDuration_returnsZero() {
        let result = EstimationEngine.calculateExpectedDuration()
        
        switch result {
        case .failure:
            XCTFail("Expected to fail")
        case let .success(value):
            XCTAssertEqual(value, 0)
        }
    }
}
