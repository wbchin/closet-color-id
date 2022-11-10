//
//  OutfitsView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitsView: View {
  //    let viewController: ViewController
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  var sym = [["pusheen", "shirt 2", "pusheen", "shirt 3"]]
  @State private var outfits = ["pink tee", "green tee", "black tee"]
  var body: some View {
    NavigationView{
      ScrollView{
        Text("Tops")
        LazyVGrid(columns: columns, spacing: 5){
          ForEach(sym, id: \.self) { array in
            ForEach(array, id: \.self) {top in
              Image(uiImage: UIImage(named: top)!)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .font(.system(size: 30))
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            }
            
            
          }
        }
        
      }
      .navigationBarTitle("OUTFITS")
      .navigationBarItems(trailing: Button(action: {
        self.addRow()
      }) {
        Image(systemName: "shirt")
      })
    }
    
    
  }
  func addRow() {
    self.outfits.append("New Outfit")
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
}
