//
//  Tag.swift
//  Custom_chips_Demo
//
//  Created by vignesh kumar c on 28/09/23.
//

import SwiftUI

struct Tag: Identifiable, Hashable {
    
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
    
}
