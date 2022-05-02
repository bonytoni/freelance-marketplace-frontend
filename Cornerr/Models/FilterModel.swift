//
//  FilterModel.swift
//  Cornerr
//
//  Created by Jennifer Gu on 5/1/22.
//

import Foundation
import UIKit

class Filter: Equatable {
    var name: String
    var isSelected: Bool
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
    
    init (name: String) {
        self.name = name
        self.isSelected = false
    }
}
