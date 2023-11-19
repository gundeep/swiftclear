//
//  iClearCloudPath.swift
//  AleoWorkshop
//
//  Created by Gundeep Singh on 17/11/2023.
//

import Foundation

import SwiftCloud

enum iClearCloudPath: String, CloudServicePath {
    var pathString: String {
        rawValue
    }
    
    case execute
}
