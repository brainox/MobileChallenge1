//
//  maxPercentBPMDifference.swift
//  MobileChallenge1
//
//  Created by Decagon on 08/06/2021.
//

import Foundation

class MaxPercentBPMDifference {
    func maxAverage (exercisesArr: [[Int]]) -> Int {
        var averageArr: [Double] = []
        var avgNums: Double = 0.0
        var maxNum: Double = 0.0
        var percentage: Double = 0.0
        var maxNums: [Double] = []
        var percentBPMAverage: [Int] = []
        
        (0..<exercisesArr.count).forEach { num in
            (0..<exercisesArr[num].count).forEach { _ in
                var sum = 0.0
                let _ = (exercisesArr[num]).forEach { val in
                    sum += Double(val)
                }
                avgNums = sum / Double((exercisesArr[num].count))
            }
            averageArr.append(avgNums)
        }
        
        (1..<exercisesArr.count).forEach { i in
            (1..<exercisesArr[i].count).forEach { _ in
                maxNum = Double(exercisesArr[i].max() ?? 0)
            }
            maxNums.append(maxNum)
        }
        
        (0..<maxNums.count).forEach { i in
            percentage = (maxNums[i] * 100) / averageArr[i]
            percentBPMAverage.append(Int(percentage))
        }
        let total = percentBPMAverage.max() ?? 0
        return total
    }
    
}


