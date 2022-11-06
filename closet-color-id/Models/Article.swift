//
//  Article.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation

class Article: Identifiable {
    var imageData: String
    var primary_color_name: String
    var primary_color_hex: String
    var primary_color_family: String
    var secondary_color_name: String
    var secondary_color_hex: String
    var secondary_color_family: String
    var complimentary_color_name: String
    var complimentary_color_hex: String
    var complimentary_color_family: String
    var id = UUID()
    
    init(imageData: String, primary_color_name: String, primary_color_hex: String, primary_color_family: String, secondary_color_name: String, secondary_color_hex: String, secondary_color_family: String, complimentary_color_name: String, complimentary_color_hex: String, complimentary_color_family: String){
        self.imageData = imageData
        self.primary_color_name = primary_color_name
        self.primary_color_hex = primary_color_hex
        self.primary_color_family = primary_color_family
        self.secondary_color_name = secondary_color_name
        self.secondary_color_hex = secondary_color_hex
        self.secondary_color_family = secondary_color_family
        self.complimentary_color_name = complimentary_color_name
        self.complimentary_color_hex = complimentary_color_hex
        self.complimentary_color_family = complimentary_color_family
    }
    
//    static func ==(lhs:Article, rhs:Article) -> Bool {
//        return lhs.imageData == rhs.imageData &&
//        lhs.primary_color_name == rhs.primary_color_name &&
//        lhs.primary_color_hex == rhs.primary_color_hex &&
//        lhs.primary_color_family == rhs.primary_color_family &&
//        lhs.secondary_color_name == rhs.secondary_color_name &&
//        lhs.secondary_color_hex == rhs.secondary_color_hex &&
//        lhs.secondary_color_family == rhs.secondary_color_family &&
//        lhs.complimentary_color_name == rhs.complimentary_color_name &&
//        lhs.complimentary_color_hex == rhs.complimentary_color_hex &&
//        lhs.complimentary_color_family == rhs.complimentary_color_family
//    }
//
//    static func <(lhs:Article, rhs:Article) -> Bool {
//        return lhs.id.uuidString < rhs.id.uuidString
//    }
    
}
