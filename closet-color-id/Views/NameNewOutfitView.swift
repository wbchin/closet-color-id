//
//  nameNewOutfitView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 12/8/22.
//

import SwiftUI

struct NameNewOutfitView: View {
    var viewModel: ViewModel
    var outfit: Outfit
    let columns = [
      GridItem(.flexible()),
      GridItem(.flexible())
    ]
    @State var name = String()
    @State var showOutfitView = false
    var body: some View {
        NavigationView {
            ScrollView{
//                Image(uiImage: collageImage(rect: CGRect(x: 0, y: 0, width: 200, height: 200), images: imageArray()))
                TextField("Name outfit", text: $name)
                    .onSubmit {
                        viewModel.renameOutfit(outfit: self.outfit, name: name)
                        showOutfitView = true
                    }
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(viewModel.retrieveArticlesForOutfit(outfit: outfit)!, id: \.self){ article in
                        Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding()
                            //.accessibilityLabel("Image of article. See below for article information.")

                    }
                }
                .background(Color.red)
                .cornerRadius(15)
                
            }
            if showOutfitView {
                NavigationLink(destination: OutfitView(outfit: outfit, viewModel: viewModel), label: {
                    Text("View outfit")
                })
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//struct nameNewOutfitView_Previews: PreviewProvider {
//    static var previews: some View {
//        nameNewOutfitView()
//    }
//}
