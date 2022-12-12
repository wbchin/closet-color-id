//
//  OutfitErrorView.swift
//  closet-color-id
//


import SwiftUI

struct OutfitErrorView: View {
    
    let viewModel: ViewModel
    let backgroundColor : Color = Color(red: 246/255, green: 239/255, blue: 232/255)
    
    var body: some View {
        ZStack {
            Color(red: 246/255, green: 239/255, blue: 232/255)
            VStack {
                Text(self.viewModel.generateOutfitMsg!)
                    .padding()
                    .frame(width: 250, height: 250)
            }.background(
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.white)
                    .padding(6)
            )
            //.background(backgroundColor)
            .navigationBarBackButtonHidden(true)
            
        }
    }
    
}



