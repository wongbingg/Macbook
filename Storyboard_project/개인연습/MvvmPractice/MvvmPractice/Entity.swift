//
//  Entity.swift
//  MvvmPractice
//
//  Created by 이원빈 on 2022/03/23.
//

import Foundation

struct UtcTimeModel: Codable {
    
    let id: String
    let currentDateTime: String
    let utcOffset: String
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: String
    let timeZoneName: String
    let currentFileTime: Int
    let ordinalDate: String
    let serviceResponse: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case currentDateTime
        case utcOffset
        case isDayLightSavingsTime
        case dayOfTheWeek
        case timeZoneName
        case currentFileTime
        case ordinalDate
        case serviceResponse
        
    }
}
