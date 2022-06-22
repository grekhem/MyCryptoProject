//
//  CryptoDTO.swift
//  MyCryptoProject
//
//  Created by Grekhem on 21.06.2022.
//

import Foundation

struct CryptoDTO: Codable {
    let data: [[String: String?]]
    let timestamp: Int
}
