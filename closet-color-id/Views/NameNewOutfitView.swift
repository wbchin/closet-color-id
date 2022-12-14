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
            ScrollView {
                TextField("Name your outfit:", text: $name).padding(25).font(.system(size: 20))
                    .onSubmit {
                        viewModel.renameOutfit(outfit: self.outfit, name: name)
                        showOutfitView = true
                    }
                if showOutfitView {
                    NavigationLink(destination: NewOutfitView(outfit: outfit, viewModel: viewModel), label: {
                        Text("View outfit")
                    })
                }
                LazyVGrid(columns: [GridItem(.flexible())]){
                    ForEach(viewModel.organizeOutfit(outfit: outfit)!, id: \.self){ article in
                        Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().cornerRadius(10).padding()
                        .accessibilityLabel("Image of article. See below for article information.")
                        
                    }
                }
                .background(Color(red: 0.30, green: 0.11, blue: 0.00))
                .cornerRadius(15)
                .padding(25)
                
            }
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        }
        .navigationBarBackButtonHidden(true)
    }
}
