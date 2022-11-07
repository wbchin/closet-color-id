//
//  WardrobeView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct WardrobeView: View {  
  @Environment(\.managedObjectContext) private var viewContext
    let viewModel: ViewModel
    let appDelegate: AppDelegate = AppDelegate()
//  private var articles: FetchedResults<Article> = viewModel.fetchArticles()
    @FetchRequest(entity: Article.entity(), sortDescriptors: [])
    var articles: FetchedResults<Article>
    var tops: [Article]
    var bottoms: [Article]
    var footwear: [Article]
    var outerwear: [Article]
  
    var body: some View {
        NavigationView{
            List{
                Text("Articles")
              ForEach(articles) { article in
                  WardrobeCardView(viewModel: viewModel, article: article)
                }
//                Text("Tops")
//                ForEach(tops) { top in
//                    WardrobeCardView(article: top)
//                }
//                Text("Bottoms")
//                ForEach(bottoms) { bottom in
//                    WardrobeCardView(article: bottom)
//                }
//                Text("Footwear")
//                ForEach(footwear) { shoe in
//                    WardrobeCardView(article: shoe)
//                }
//                Text("Outerwear")
//                ForEach(outerwear) { jacket in
//                    WardrobeCardView(article: jacket)
//                }
            } .navigationBarTitle("WARDROBE")
              .onAppear()
              }
            }
  
    
}

//struct WardrobeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WardrobeView()
//    }
//}
