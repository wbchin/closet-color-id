//
//  UnsavedArticleView.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/8/22.
//

import Foundation
import SwiftUI

struct UnsavedArticleView: View {
    let viewModel: ViewModel
    let article: Article
    @State private var isShowingSave = true
    @State private var isShowingSubcats = false
    @State private var isShowingCats = false
    @State private var isShowingStyles = false
    var body: some View {
        NavigationView{
            VStack {
                // insert image here
                Image(uiImage: UIImage(data:article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                
                
                Button(action: {
                    isShowingSave = false
                }) {
                    Text("Save to wardrobe")
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .font(.system(size: 36))
                }
                if !isShowingSave {
                    NavigationLink (
                        destination: TagCategoryView(viewModel: viewModel, article: article),
                        label:{
                            Text("Done")
                                .font(.system(size: 36))
                        })
                }
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}
