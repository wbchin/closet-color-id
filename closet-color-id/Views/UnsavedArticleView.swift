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
                Image(uiImage: UIImage(data:article.image_data!)!).resizable().scaledToFit().rotationEffect(.degrees(90))
//                Spacer()
                Button("SAVE TO WARDROBE") {
                    isShowingSave = false
                }
                .padding(4)
                .background(.white)
                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                .border(Color(red: 0.30, green: 0.11, blue: 0.00), width: 2)
                .font(.system(size: 30))
                    
                if !isShowingSave {
                    NavigationLink (
                        destination: TagCategoryView(viewModel: viewModel, article: article),
                        label:{
                            Text("Done")
                                .font(.system(size: 30))
                        })
                }
            }
        }.navigationBarBackButtonHidden(true)
//            .padding()
    }
}
