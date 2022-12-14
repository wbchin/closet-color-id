import SwiftUI

struct WardrobeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let viewModel: ViewModel
    let appDelegate: AppDelegate = AppDelegate()
    @State var tops: [Article] = [Article]()
    @State var bottoms: [Article] = [Article]()
    @State var footwear: [Article] = [Article]()
    @State var outerwear: [Article] = [Article]()
    @Binding var isTutorial: Bool
    func populateCats() {
        self.tops = self.viewModel.fetchCatArts(category: "top")
        self.bottoms = self.viewModel.fetchCatArts(category: "bottom")
        self.footwear = self.viewModel.fetchCatArts(category: "footwear")
        self.outerwear = self.viewModel.fetchCatArts(category: "outerwear")
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            Spacer()
            Text("WARDROBE")
                .fontWeight(.bold)
                .font(.title)
                .padding()
            HStack{
                Spacer()
                
                Button(action: {
                    self.isTutorial = true
                }) {
                    Image(systemName: "info.circle")
                }
            }
            if (self.isTutorial) {
                NavigationView {
                    TutorialStartView(viewModel: viewModel, isTutorial: self.$isTutorial)
                }
            }
            if (self.tops.count > 0){
                VStack (alignment: .leading) {
                    Text("TOPS").bold()
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(self.tops, id: \.self) { top in
                            NavigationLink(destination: WardrobeArticleView(article: top, viewModel: viewModel)) {
                                Image(uiImage: UIImage(data: top.image_data!)!)//UNSAFE
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .font(.system(size: 30))
                                    .frame(height: 80)
                                    .cornerRadius(10)
                                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                            }
                        }
                    }
                }
                if(self.bottoms.count > 0){
                    VStack (alignment: .leading) {
                        Text("BOTTOMS").bold()
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.bottoms, id: \.self) { bottom in
                                NavigationLink(destination: WardrobeArticleView(article: bottom, viewModel: viewModel)) {
                                    Image(uiImage: UIImage(data: bottom.image_data!)!)//UNSAFE
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 30))
                                        .frame(height: 80)
                                        .cornerRadius(10)
                                        .shadow(color: .white, radius: 5, x: 0, y: 0)
                                }
                            }
                        }
                    }
                }
                if (self.footwear.count > 0){
                    VStack (alignment: .leading) {
                        Text("FOOTWEAR").bold()
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.footwear, id: \.self) { foot in
                                NavigationLink(destination: WardrobeArticleView(article: foot, viewModel: viewModel)) {
                                    Image(uiImage: UIImage(data: foot.image_data!)!)//UNSAFE
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 30))
                                        .frame(height: 80)
                                        .cornerRadius(10)
                                        .shadow(color: .white, radius: 5, x: 0, y: 0)
                                }
                            }
                        }
                    }
                } else{
                    VStack (alignment: .leading) {
                        Text("FOOTWEAR").bold()
                        Text("Not footwear in wardrobe.")
                        LazyVGrid(columns: columns, spacing: 10){}
                    }
                }
                
                if (self.outerwear.count > 0){
                    VStack (alignment: .leading){
                        Text("OUTERWEAR").bold()
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.outerwear, id: \.self) { out in
                                NavigationLink(destination: WardrobeArticleView(article: out, viewModel: viewModel)) {
                                    Image(uiImage: UIImage(data: out.image_data!)!)//UNSAFE
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 30))
                                        .frame(height: 80)
                                        .cornerRadius(10)
                                        .shadow(color: .white, radius: 5, x: 0, y: 0)
                                }
                            }
                        }
                    }
                } else {
                    VStack (alignment: .leading){
                        Text("OUTERWEAR").bold()
                        Text("No outerwear in wardrobe.")
                        LazyVGrid(columns: columns, spacing: 10){}
                    }
                }
            }
        }.onAppear(perform: {
            self.viewModel.deleteUntaggedArticles(completion: {out in})
            self.viewModel.deleteUnstyledArticles(completion: {out in})
            self.populateCats()
          })
          .padding(.horizontal)
          .frame(alignment: .leading)
          .background(Color(red: 0.96, green: 0.94, blue: 0.91))
    }

}



