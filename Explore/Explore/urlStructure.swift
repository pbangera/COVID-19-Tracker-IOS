//
//  urlStructure.swift
//  Explore
//
//  Created by Pradyumn Bangera on 6/4/20.
//  Copyright © 2020 Pradyumn Bangera. All rights reserved.
//

import Foundation

let infoList: [Info] = []
let miList: [mi] = []


struct Info: Codable{
    var negative: Int?
    var state: String = ""
    var death: Int
    var positive: Int
    var positiveIncrease: Int
    var deathIncrease: Int
    var total: Int
    var recovered: Int?
    //var covid19SiteOld: String?
    var hospitalizedCurrently: Int?
    var hospitalizedIncrease: Int
}

struct mi: Codable{
    var state: String?
    var covid19SiteOld: String?
}
