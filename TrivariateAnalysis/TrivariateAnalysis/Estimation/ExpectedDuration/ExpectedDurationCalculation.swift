//
//  ExpectedDurationCalculation.swift
//  TrivariateAnalysis
//
//  Created by Deniz Tutuncu on 9/12/21.
//

import Foundation

public protocol ExpectedDurationCalculation {
    typealias Result = Swift.Result<Double, Error>
    static func calculateExpectedDuration(_ estimates: [Double]) -> Result
}
