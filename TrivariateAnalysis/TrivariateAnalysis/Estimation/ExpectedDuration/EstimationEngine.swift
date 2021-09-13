//
//  EstimationEngine.swift
//  TrivariateAnalysis
//
//  Created by Deniz Tutuncu on 9/12/21.
//

import Foundation

public final class EstimationEngine {}

extension EstimationEngine: ExpectedDurationCalculation {
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
    
    public static func calculateExpectedDuration(_ estimates: [Double]) -> ExpectedDurationCalculation.Result {
        if let error = handleEstimatesCount(estimates) {
            return Result { throw error }
        }
        
        if let err = handleInvalidValues(estimates) {
            return Result { throw err }
        }
        
        return Result { calculate(estimates) }
    }
    
    static private func calculate(_ estimates: [Double]) -> Double {
        let optimisticEstimate = estimates[0]
        let nominalEstimate = estimates[1]
        let pessimisticEstimate = estimates[2]
        
        return (optimisticEstimate + ( 4 * nominalEstimate) + pessimisticEstimate) / 6
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
