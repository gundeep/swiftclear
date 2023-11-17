//
//  iClearCloudService.swift
//  AleoWorkshop
//
//  Created by Gundeep Singh on 17/11/2023.
//

import Foundation

import Observation

import SwiftCloud

import Aleo

@Observable
class iClearCloudService: CloudService<iClearCloudHost, iClearCloudPath> {
    func execute(time: Date, address: Address) async throws {
        let timeInterval = time.timeIntervalSince1970
        let addressString = address.toString()
        
        let params =  ExecuteParams(program: "hello_world", aleoFunction: "hello", inputs: ["\(timeInterval)u32", addressString])
        
        let bodyData =  try JSONEncoder().encode(params)
        
        let (data, _) = try await sendRequest(at: .execute, using: .post, body: bodyData)
        
        let isVerified = try JSONDecoder().decode(Bool.self, from: data)
    }
}


struct ExecuteParams: Codable {
    var program: String
    var aleoFunction: String
    var inputs: [String]
}
