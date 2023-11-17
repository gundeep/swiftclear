//
//  iClearCloudHost.swift
//  AleoWorkshop
//
//  Created by Gundeep Singh on 17/11/2023.
//

import Foundation
import SwiftCloud

enum iClearCloudHost: String, CloudServerURL {
    var urlString: String { self.rawValue }
    
    case development = "<AWS URL>"
}
