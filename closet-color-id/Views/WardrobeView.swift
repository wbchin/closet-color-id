import SwiftUI

struct WardrobeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let viewModel: ViewModel
    let appDelegate: AppDelegate = AppDelegate()
    var articles : [Article] {
        get {
         return viewModel.fetchArticles()!
        }
    }
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
//    var shirt = Image("shirt")
        
    var sym = [["pusheen", "shirt"], ["shirt 2", "pusheen", "shirt"], ["shirt 3"], ["shirt", "pusheen", "pusheen", "shirt"]]
    var bols = [["keyboard", "hifispeaker.fill"], ["printer.fill", "tv.fill", "desktopcomputer"], ["headphones"], ]
    let dataPopulation: DataPopulation = DataPopulation()
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
                Text("Bottoms")
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(bols, id: \.self) { array in
                        ForEach(array, id: \.self) {bottom in
                            Image(systemName: bottom)
                                .font(.system(size: 30))
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        }
                    }
                    }
                }
            .padding(.horizontal)
            .navigationBarTitle("WARDROBE")
        }
        
    }
=======
      NavigationView{
        List{
          Text("Articles")
          ForEach(viewModel.arts, id: \.self) { article in
                Text(article.primary_color_name!) //UMSAFE
                
              }

//          ForEach(articles) { article in
//                WardrobeCardView(viewModel: viewModel, article: article)
//              }
        
//          Text("Tops")
//          ForEach(tops) { top in
//            WardrobeCardView(viewModel: viewModel, article: top)
//          }
              
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
              
              }
            }
  
    
}

//struct WardrobeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WardrobeView()
//    }
//}
