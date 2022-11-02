//
//  ArticleStyle.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation


class ArticleStyle: Identifiable{
    var article_id: String
    var style_id: String
    var id = UUID()
    
    init(article_id: String, style_id: String){
        self.article_id = article_id
        self.style_id = style_id
    }
}
