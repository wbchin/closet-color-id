//
//  OutfitsView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitsView: View {
  let viewModel: ViewModel
  var outfits : [Outfit]? {
      get {
       return viewModel.fetchOutfits()
      }
  }
  
  //@State private var clothes = ["pink tee", "green tee", "black tee"]
  var body: some View {
      NavigationView {
          List {
              ForEach(outfits!, id: \.self) { outfit in
                Text(outfit.name!)
              }
          }
          .navigationBarTitle("OUTFITS")
          .navigationBarItems(trailing: Button(action: {
            // this needs it's own view
          }) {
              Image(systemName: "plus")
          })
      }
    }
}

//struct OutfitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutfitsView()
//    }
//}
