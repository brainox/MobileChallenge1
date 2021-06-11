//
//  Session.swift
//  MobileChallenge1
//
//  Created by Decagon on 07/06/2021.
//

import Foundation


// MARK: - SessionResponseElement
struct SessionResponseElement: Codable {
    var name, practicedOnDate: String
    let exercises: [Exercise]
}

// MARK: - Exercise
struct Exercise: Codable {
    let exerciseID, name: String
    let practicedAtBPM: Int

    enum CodingKeys: String, CodingKey {
        case exerciseID = "exerciseId"
        case name
        case practicedAtBPM = "practicedAtBpm"
    }
}

typealias SessionResponse = [SessionResponseElement]

