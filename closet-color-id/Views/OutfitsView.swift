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
//    GridItem(.flexible()),
//    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
    @State var professional: [Article] = [Article]()
    @State var casual: [Article] = [Article]()
    @State var night_out: [Article] = [Article]()
    @State var athletic: [Article] = [Article]()
    @State var outfits = [Outfit]()
    func popStyles(){
        self.professional = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "professional")!)!
        self.casual = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "casual")!)!
        self.night_out = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "night")!)!
        self.athletic = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "athletic")!)!
    }
    func addRow() {
        //    self.outfits.append("New Outfit")
        let viewModel: ViewModel
        var outfits : [Outfit]? {
            get {
                return viewModel.fetchOutfits()
            }
        }
    }
    
    var body: some View {
      NavigationView {
          ScrollView{
              if(self.outfits.count > 0){
                  VStack{
                      Text("OUTFITS").bold()
//                      LazyVGrid(columns: columns, spacing: 10){
                      ForEach(self.outfits, id: \.self) { outfit in
                          NavigationLink(destination: OutfitView(outfit: outfit, viewModel: viewModel)) {
                              LazyVGrid(columns: columns){
                                  ForEach(self.viewModel.retrieveArticlesForOutfit(outfit: outfit)!, id: \.self){ article in
                                      Image(uiImage: UIImage(data: article.image_data!)!)//UNSAFE
                                          .renderingMode(.original)
                                          .resizable()
                                          .scaledToFit()
                                          .font(.system(size: 30))
                                          .frame(width: 80, height: 80)
                                          .cornerRadius(10)
                                          .shadow(color: .white, radius: 5, x: 0, y: 0)
                                      
                                  }
                              }.background(Color.red) //TINA CHANGE TO THE COLOR U WANT
                                  .cornerRadius(15)
                              
                          }
                      }
//                      }
                  }
              } else {
                  VStack (alignment: .leading) {
                      Text("OUTFITS").bold()
                      Text("No outfits.")
                      LazyVGrid(columns: columns, spacing: 10){}
                  }
              }
//              if(self.casual.count > 0){
//                  VStack{
//                      Text("CASUAL").bold()
//                  }
//              } else {
//                  VStack (alignment: .leading) {
//                      Text("CASUAL").bold()
//                      Text("No casual in outfits.")
//                      LazyVGrid(columns: columns, spacing: 10){}
//                  }
//              }
//              if(self.night_out.count > 0){
//                  VStack{
//                      Text("NIGHT OUT").bold()
//                  }
//              } else {
//                  VStack (alignment: .leading) {
//                      Text("NIGHT OUT").bold()
//                      Text("No night out in outfits.")
//                      LazyVGrid(columns: columns, spacing: 10){}
//                  }
//              }
//              if(self.athletic.count > 0){
//                  VStack{
//                      Text("ATHLETIC").bold()
//                  }
//              } else {
//                  VStack (alignment: .leading) {
//                      Text("ATHLETIC").bold()
//                      Text("No athletic in wardrobe.")
//                      LazyVGrid(columns: columns, spacing: 10){}
//                  }
//              }
          }
//        List {
//          ForEach(outfits!, id: \.self) { outfit in
//            Text(outfit.name!)
//          }.background(Color(red: 0.96, green: 0.94, blue: 0.91))
//        }
        
        
      }
      .onAppear(perform: {
          self.viewModel.generateOutfit(style: "professional", name: "Interview")
          self.popStyles()
          self.outfits = viewModel.fetchOutfits()!
//        self.viewModel.deleteUnstyledArticles()
//        self.viewModel.updateArticles()
//        self.viewModel.deleteUntaggedArticles()
//        self.viewModel.updateArticles()
      })
      .navigationBarItems(trailing: Button(action: {
          // this needs it's own view
        }) {
          Image(systemName: "plus")
        })
    }
//    let exampleColor : Color = Color(red: 0.5, green: 0.8, blue: 0.5)

//  var sym = [["pusheen", "shirt 2", "pusheen", "shirt 3"]]
//  @State private var outfits = ["pink tee", "green tee", "black tee"]
  // must be internal or public.
  
//  var body: some View {
//    NavigationView{
//      Button(action: {
//        // wait 5 seconds to generate outfit
//
//        //self.viewModel.generateOutfitStyle = self.dataPopulation.fetchStyle(name: "professional")!
//        //self.viewModel.genrateOutfitName = "Professional"
////        _ = Timer.scheduledTimer(timeInterval: 4, target: self.viewModel, selector: #selector(self.viewModel.generateOutfit(sender:)), userInfo: ["professional", "interview"], repeats: true)
//
//        self.viewModel.generateOutfit(style: "professional", name: "Interview")
//      }, label: {
//          Text("Generate Professional Outfit")
//      })
//      Text("").onAppear(perform: {
//        let _ = print("outfits: ")
////        let _ = print((self.viewModel.fetchOutfits()!.first!.articleOutfits!.first as! ArticleOutfit).article?.primary_color_family)
////        let _ = print(self.viewModel.retrieveArticlesForOutfit(outfit: self.viewModel.outfit!))
//      })
//      ScrollView{
//        Text("Tops")
//        LazyVGrid(columns: columns, spacing: 5){
////          ForEach(sym, id: \.self) { array in
////            ForEach(array, id: \.self) {top in
////              Image(uiImage: UIImage(named: top)!)
////                .renderingMode(.original)
////                .resizable()
////                .scaledToFit()
////                .font(.system(size: 30))
////                .frame(width: 80, height: 80)
////                .cornerRadius(10)
////            }
////
////
////          }
//        }
//
//      }
//      .navigationBarTitle("OUTFITS")
//      .frame(alignment: .leading)
//      .background(Color(red: 0.96, green: 0.94, blue: 0.91))
//      .navigationBarItems(trailing: Button(action: {
//        self.addRow()
//      }) {
//        Image(systemName: "shirt")
//      })
//    }
//
//
//  }

    

  }
  
  //struct OutfitsView_Previews: PreviewProvider {
  //    static var previews: some View {
  //        OutfitsView()
  //    }
  //}
