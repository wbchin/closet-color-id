//
//  Style.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation

class Style: Identifiable{
    var name: String
    var id = UUID()
    
    init(name: String){
        self.name = name
    }
}
