//
//  WardrobeView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct WardrobeView: View {
//    var articles: [Article]
//    let viewController: ViewController
    var tops: [[Article]]
    var bottoms: [[Article]]
    var footwear: [[Article]]
    var outerwear: [[Article]]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Tops")
                ForEach(tops, id: \.self){ array in
//                    Somehow iterate thru the names
//                    Text(SubcategoryName.subcategoryNamesShirts[0])
                    ForEach(array, id: \.self){ top in
                        LazyVGrid(columns: columns, spacing: 10){
                                WardrobeCardView(article: top)//Might need change WardrobeCardView to return a view
                        }
                        .padding(.horizontal)
                    }
                }
                Text("Bottoms")
                ForEach(bottoms, id: \.self){ array in
//                    Text(SubcategoryName.subcategoryNamesShirts[1])
                    ForEach(array, id: \.self){ bottom in
                        LazyVGrid(columns: columns, spacing: 10){
                                WardrobeCardView(article: bottom)
                        }
                        .padding(.horizontal)
                    }
                }
                
                Text("Footwear")
                ForEach(footwear, id: \.self){ array in
//                    Text(SubcategoryName.subcategoryNamesShirts[1])
                    ForEach(array, id: \.self){ shoe in
                        LazyVGrid(columns: columns, spacing: 10){
                                WardrobeCardView(article: shoe)
                        }
                        .padding(.horizontal)
                    }
                }
                Text("Outerwear")
                ForEach(outerwear, id: \.self){ array in
//                    Text(SubcategoryName.subcategoryNamesShirts[1])
                    ForEach(array, id: \.self){ jacket in
                        LazyVGrid(columns: columns, spacing: 10){
                                WardrobeCardView(article: jacket)
                        }
                        .padding(.horizontal)
                    }
                }
        }
        .navigationBarTitle("WARDROBE")
        
//            List{
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
//            } .navigationBarTitle("WARDROBE")
        }
        
    }
}

//struct WardrobeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WardrobeView()
//    }
//}
