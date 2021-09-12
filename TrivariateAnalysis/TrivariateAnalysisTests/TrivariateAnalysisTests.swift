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
        case invalidValue
        
        var errorDescription: String? {
            switch self {
            case .needsThreeEstimates:
                return NSLocalizedString("This func needs three estimates to calculate.", comment: "Error.needsThreeEstimates")
            case .invalidValue:
                return NSLocalizedString("One or more invalid values in the estimation array.", comment: "Error.invalidValue")
            }
        }
    }
    
    static func calculateExpectedDuration(_ estimates: [Double]) -> ExpectedDurationCalculation.Result {
        if let error = handleEstimatesCount(estimates) {
            return Result { throw error }
        }
        
        if let err = handleInvalidValues(estimates) {
            return Result { throw err }
        }
        
        return Result { 0 }
    }
    
    static private func handleEstimatesCount(_ estimates: [Double]) -> Error? {
        guard estimates.count == 3 else { return Error.needsThreeEstimates }; return nil
    }
    
    static private func handleInvalidValues(_ estimates: [Double]) -> Error? {
        for estimate in estimates {
            if estimate <= 0 {
                return Error.invalidValue
            }
        }
        return nil
    }
}

class TrivariateAnalysisTests: XCTestCase {
    
    func test_calculateExpectedDuration_successfullyReturnsData_WhenGivenDataIsValid() {
        let validData = [1.0, 3.0, 12.0]
        let result = EstimationEngine.calculateExpectedDuration(validData)
        
        let expectedValue = 4.166666666666667
        
        switch result {
        case .failure:
            XCTFail("Expected Succesfull")
        case let .success(value):
            XCTAssertEqual(value, expectedValue)
        }
    }
    
    func test_calculateExpectedDuration_success_WhenGivenDataIsValid() {
        let validData = [1.0, 3.0, 12.0]
        let result = EstimationEngine.calculateExpectedDuration(validData)
        
        switch result {
        case .failure:
            XCTFail("Expected Success")
        case .success:
            break
        }
    }
    
    func test_calculateExpectedDuration_failsWithError_WhenGivenDataIsInvalid_CaseInvalidItem_2() {
        let invalidData = [-1.0, 3.0, 12.0]
        let result = EstimationEngine.calculateExpectedDuration(invalidData)
        
        switch result {
        case let .failure(error):
            XCTAssertNotNil(error)
        case .success:
            XCTFail("Expected to fail")
        }
    }
    
    func test_calculateExpectedDuration_failsWithError_WhenGivenDataIsInvalid_CaseInvalidItem() {
        let invalidData: [Double] = [0.0, 0.0, 0.0]
        let result = EstimationEngine.calculateExpectedDuration(invalidData)
        
        switch result {
        case let .failure(error):
            XCTAssertNotNil(error)
        case .success:
            XCTFail("Expected to fail")
        }
    }
    
    func test_calculateExpectedDuration_failsWithError_WhenGivenDataIsInvalid_CaseMoreItems() {
        let invalidData = [1.0, 3.0, 12.0, 14.0]
        let result = EstimationEngine.calculateExpectedDuration(invalidData)
        
        switch result {
        case let .failure(error):
            XCTAssertNotNil(error)
        case .success:
            XCTFail("Expected to fail")
        }
    }
    
    func test_calculateExpectedDuration_failsWithError_WhenGivenDataIsInvalid_CaseLessItems() {
        let missingData: [Double] = [1.0, 3.0]
        let result = EstimationEngine.calculateExpectedDuration(missingData)
        
        switch result {
        case let .failure(error):
            XCTAssertNotNil(error)
        case .success:
            XCTFail("Expected to fail")
        }
    }
    
    func test_calculateExpectedDuration_failsWithError_WhenGivenDataIsInValid_CaseEmpty() {
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
