//
//  StyleOutfit.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation

class StyleOutfit:Identifiable{
    var outfit_id: String
    var style_id: String
    var id = UUID()
    
    init(outfit_id: String, style_id: String){
        self.outfit_id = outfit_id
        self.style_id = style_id
    }
}
