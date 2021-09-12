//
//  TrivariateAnalysisTests.swift
//  TrivariateAnalysisTests
//
//  Created by Deniz Tutuncu on 9/11/21.
//

import XCTest

protocol ExpectedDurationCalculation {
    typealias Result = Swift.Result<Double, Error>
    static func calculateExpectedDuration(_ estimates: [Double]) -> Result
}

final class EstimationEngine: ExpectedDurationCalculation {
    
    
    private init() {}
    
    enum Error: Swift.Error, LocalizedError {
        case needsThreeEstimates
        
        var errorDescription: String? {
            switch self {
            case .needsThreeEstimates:
                return NSLocalizedString("This func needs three estimates to calculate.", comment: "Error.needsThreeEstimates")
            }
        }
    }
    
    static func calculateExpectedDuration(_ estimates: [Double]) -> ExpectedDurationCalculation.Result {
        if let error = handleEstimatesCount(estimates) {
            return Result { throw error }
        }
        
        return Result { 0 }
    }
    
    static private func handleEstimatesCount(_ estimates: [Double]) -> Error? {
        guard estimates.count == 3 else { return Error.needsThreeEstimates }; return nil
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
