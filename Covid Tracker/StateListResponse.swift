//
//  StateListResponse.swift
//  COVID Tracker
//
//  Created by Ashish Ranjan on 22/04/22.
//

import Foundation

struct StateListResponse: Codable {
    let data: [State]?
}

struct State: Codable {
    let name: String?
    let stateCode: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case stateCode = "state_code"
    }
}
