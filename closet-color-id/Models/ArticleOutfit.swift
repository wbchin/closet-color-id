//
//  ArticleOutfit.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation

class ArticleOutfit:Identifiable{
    var article_id: String
    var outfit_id: String
    var id = UUID()
    
    init(article_id: String, outfit_id: String){
        self.article_id = article_id
        self.outfit_id = outfit_id
    }
}
