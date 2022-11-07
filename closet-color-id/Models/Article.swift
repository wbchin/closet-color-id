//
//  Article.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation
import CoreData

//@objc(Article)
class Article: Identifiable {
    @NSManaged var image_data: Data
    @NSManaged var primary_color_name: String
    @NSManaged var primary_color_hex: String
    @NSManaged var primary_color_family: String
    @NSManaged var secondary_color_name: String
    @NSManaged var secondary_color_hex: String
    @NSManaged var secondary_color_family: String
    @NSManaged var complimentary_color_name: String
    @NSManaged var complimentary_color_hex: String
    @NSManaged var complimentary_color_family: String
    @NSManaged public var id: UUID

    init(image_data: Data, primary_color_name: String, primary_color_hex: String, primary_color_family: String, secondary_color_name: String, secondary_color_hex: String, secondary_color_family: String, complimentary_color_name: String, complimentary_color_hex: String, complimentary_color_family: String){
        self.image_data = image_data
        self.primary_color_name = primary_color_name
        self.primary_color_hex = primary_color_hex
        self.primary_color_family = primary_color_family
        self.secondary_color_name = secondary_color_name
        self.secondary_color_hex = secondary_color_hex
        self.secondary_color_family = secondary_color_family
        self.complimentary_color_name = complimentary_color_name
        self.complimentary_color_hex = complimentary_color_hex
        self.complimentary_color_family = complimentary_color_family
        self.id = UUID()
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
