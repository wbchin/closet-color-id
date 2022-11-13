//
//  OutfitsView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitsView: View {
  //    let viewController: ViewController
  var viewModel: ViewModel
  var dataPopulation: DataPopulation
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
    let exampleColor : Color = Color(red: 0.5, green: 0.8, blue: 0.5)

  var sym = [["pusheen", "shirt 2", "pusheen", "shirt 3"]]
  @State private var outfits = ["pink tee", "green tee", "black tee"]
  var body: some View {
    NavigationView{
      Button(action: {
        self.viewModel.generateOutfit(style: self.dataPopulation.fetchStyle(name: "professional")!, name: "Interview")
      }, label: {
          Text("Generate Professional Outfit")
      })
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
      .frame(alignment: .leading)
      .background(Color(red: 0.96, green: 0.94, blue: 0.91))
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
        
        
      }.onAppear(perform: {
//        self.viewModel.deleteUnstyledArticles()
//        self.viewModel.updateArticles()
//        self.viewModel.deleteUntaggedArticles()
//        self.viewModel.updateArticles()
      }).navigationBarItems(trailing: Button(action: {
          // this needs it's own view
        }) {
          Image(systemName: "plus")
        })
    }
  }
  
  //struct OutfitsView_Previews: PreviewProvider {
  //    static var previews: some View {
  //        OutfitsView()
  //    }
  //}
}
