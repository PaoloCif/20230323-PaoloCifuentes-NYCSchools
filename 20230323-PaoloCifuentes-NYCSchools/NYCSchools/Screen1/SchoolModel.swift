//
//  SchoolModel.swift
//  NYCSchools
//
//  Created by Paolo Cifuentes on 03/21/23.
//

import Foundation

//Model to hold the school data
struct Highschools: Decodable {
    var schools: [School]
    
    enum CodingKeys: String, CodingKey {
        case schools
    }
}

struct School: Decodable {
    var schoolName: String
    var satCriticalReading: String
    var satMath: String
    var satWriting: String
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case satCriticalReading = "sat_critical_reading_avg_score"
        case satMath = "sat_math_avg_score"
        case satWriting = "sat_writing_avg_score"
    }
}


