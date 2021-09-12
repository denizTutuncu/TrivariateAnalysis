//
//  TrivariateAnalysisTests.swift
//  TrivariateAnalysisTests
//
//  Created by Deniz Tutuncu on 9/11/21.
//

import XCTest

protocol ExpectedDurationCalculation {
    static func calculateExpectedDuration() -> Double
}

final class EstimationEngine: ExpectedDurationCalculation {
    
    private init() {}
    
    static func calculateExpectedDuration() -> Double {
        return 0
    }
}

class TrivariateAnalysisTests: XCTestCase {
    
    func test_calculateExpectedDuration_returnsZero() {
        let result = EstimationEngine.calculateExpectedDuration()
        XCTAssertEqual(result, 0)
    }
}
