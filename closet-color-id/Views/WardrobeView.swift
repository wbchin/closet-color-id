import SwiftUI

struct WardrobeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let viewModel: ViewModel
    let appDelegate: AppDelegate = AppDelegate()
    @State var tops: [Article] = [Article]()
    @State var bottoms: [Article] = [Article]()
    @State var footwear: [Article] = [Article]()
    func populateCats() {
        //self.viewModel.updateArticles()
        self.tops = self.viewModel.fetchCatArts(category: "top")
        self.bottoms = self.viewModel.fetchCatArts(category: "bottom")
        self.footwear = self.viewModel.fetchCatArts(category: "footwear")
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let backgroundColor : Color = Color(red: 246/255, green: 239/255, blue: 232/255)
    let dataPopulation: DataPopulation = DataPopulation()
    var body: some View {
        NavigationView{
            ScrollView{
                Text("Tops")
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(self.tops, id: \.self) { top in
                        NavigationLink(destination: ArticleView(article: top, viewModel: viewModel)) {
                            Image(uiImage: UIImage(data: top.image_data!)!)//UNSAFE
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .font(.system(size: 30))
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                .shadow(color: .white, radius: 5, x: 0, y: 0)
                                .rotationEffect(.degrees(90))
                        }
                    }
                }
                VStack{
                    Text("Bottoms")
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.bottoms, id: \.self) { bottom in
                                NavigationLink(destination: ArticleView(article: bottom, viewModel: viewModel)) {
                                    Image(uiImage: UIImage(data: bottom.image_data!)!)//UNSAFE
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 30))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .shadow(color: .white, radius: 5, x: 0, y: 0)
                                        .rotationEffect(.degrees(90))
                                }
                            }
                        }
                    VStack{
                        Text("Footwear")
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.footwear, id: \.self) { foot in
                                NavigationLink(destination: ArticleView(article: foot, viewModel: viewModel)) {
                                    Image(uiImage: UIImage(data: foot.image_data!)!)//UNSAFE
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 30))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .shadow(color: .white, radius: 5, x: 0, y: 0)
                                        .rotationEffect(.degrees(90))
                                }
                            }
                        }
                    }
                }
            }.onAppear(perform: {
              self.viewModel.deleteUntaggedArticles(completion: {out in})
              self.viewModel.deleteUnstyledArticles(completion: {out in})
              self.populateCats()
            })
            .padding(.horizontal)
            .navigationBarTitle("WARDROBE")
            .frame(alignment: .leading)
            .background(Color(red: 0.96, green: 0.94, blue: 0.91))
//            .toolbarBackground(Color(red: 0.74, green: 0.64, blue: 0.55), for: .navigationBar)
        }
        .navigationBarBackButtonHidden(true)
    }
}
