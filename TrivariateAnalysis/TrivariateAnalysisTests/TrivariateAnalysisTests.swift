//
//  TrivariateAnalysisTests.swift
//  TrivariateAnalysisTests
//
//  Created by Deniz Tutuncu on 9/11/21.
//

import XCTest
import TrivariateAnalysis

class TrivariateAnalysisTests: XCTestCase {
    
//    func test_calculateExpectedDuration_WhenGivenDataIsInvalid_CaseInvalidItem_ErrorDescription() {
//        let invalidData = [-1.0, 3.0, 12.0]
//        let result = EstimationEngine.calculateExpectedDuration(invalidData)
//
//        switch result {
//        case let .failure(error):
//            XCTAssertEqual(error.localizedDescription, "One or more invalid values in the estimation array.")
//        case .success:
//            XCTFail("Expected to fail")
//        }
//    }
    
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
            XCTAssertEqual(error.localizedDescription, "One or more invalid values in the estimation array.")
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
            XCTAssertEqual(error.localizedDescription, "One or more invalid values in the estimation array.")
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
            XCTAssertEqual(error.localizedDescription, "This func needs three estimates to calculate.")
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
            XCTAssertEqual(error.localizedDescription, "This func needs three estimates to calculate.")
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
            XCTAssertEqual(error.localizedDescription, "This func needs three estimates to calculate.")
        case .success:
            XCTFail("Expected to fail")
        }
    }
}
