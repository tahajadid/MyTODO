//
//  Item.swift
//  My Todo
//
//  Created by taha_jadid on 11/4/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
