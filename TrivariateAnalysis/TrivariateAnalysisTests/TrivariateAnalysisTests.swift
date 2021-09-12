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
    
    func test_calculateExpectedDuration_failsWithError_WhenGivenDataIsEmpty() {
        let emptyData: [Double] = []
        let result = EstimationEngine.calculateExpectedDuration(emptyData)
        
        switch result {
        case let .failure(error):
            XCTAssertNotNil(error)
        case .success:
            XCTFail("Expected to fail")
        }
    }
}
