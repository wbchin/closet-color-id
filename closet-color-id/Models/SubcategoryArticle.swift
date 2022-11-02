//
//  SubcategoryArticle.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation


class SubcategoryArticle: Identifiable{
    var article_id: String
    var subcategory_id: String
    var id = UUID()
    
    init(article_id: String, subcategory_id:String){
        self.article_id = article_id
        self.subcategory_id = subcategory_id
    }
}
