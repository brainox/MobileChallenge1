//
//  DateFormater.swift
//  MobileChallenge1
//
//  Created by Decagon on 08/06/2021.
//

import Foundation

public func getDateFormater(date: String) -> String {
    let prevDateFormatter = DateFormatter()
    prevDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    let prevDate = prevDateFormatter.date(from: date)
    let formatedDateFormatter = DateFormatter()
    formatedDateFormatter.dateFormat = "MMM dd yyyy"
    return formatedDateFormatter.string(from: prevDate!)
}
