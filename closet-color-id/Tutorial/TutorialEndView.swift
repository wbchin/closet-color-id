import SwiftUI


struct TutorialEndView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let viewModel: ViewModel
    let appDelegate: AppDelegate = AppDelegate()
    @State var tops: [UIImage] = [UIImage]()
    @State var bottoms: [UIImage] = [UIImage]()
    @State var footwear: [UIImage] = [UIImage]()
    @State var outerwear: [UIImage] = [UIImage]()
    @Binding var isTutorial: Bool
    func populateCats() {
        self.tops.append(UIImage(named: "shirt 3")!)
        self.tops.append(UIImage(named: "shirt")!)
        self.bottoms.append(UIImage(named: "jeans")!)
        self.footwear.append(UIImage(named: "converse")!)
        self.outerwear.append(UIImage(named: "swag_jacket")!)
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let backgroundColor : Color = Color(red: 162/255, green: 159/255, blue: 149/255)
    
    private var tutorialOverlay: some View {
        VStack {
            Text("That’s all! Go and make some amazing outfit pairings.")
                .frame(width: 250, alignment: .center)
              .padding()
            HStack {
                NavigationLink(destination: WardrobeView(viewModel: viewModel, isTutorial: $isTutorial)) {
                    Text("BEGIN")
                        .bold()
                }.simultaneousGesture(TapGesture().onEnded{
                    //isTutorial = false
                    self.isTutorial.toggle()
                })
                NavigationLink(destination: TutorialStartView(viewModel: viewModel, isTutorial: $isTutorial)) {
                    Text("REPLAY")
                }
            }
              
        }.background(
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.white)
              .padding(6)
          )
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                Spacer()
                Text("WARDROBE")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                if (self.tops.count > 0){
                    VStack (alignment: .leading) {
                        Text("TOPS").bold()
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.tops, id: \.self) { top in
                                Image(uiImage: top)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .font(.system(size: 30))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                            }
                        }
                    }
                } else{
                    VStack (alignment: .leading) {
                        Text("TOPS").bold()
                        Text("No tops in wardrobe.")
                        LazyVGrid(columns: columns, spacing: 10){}
                    }
                }
                if(self.bottoms.count > 0){
                    VStack (alignment: .leading) {
                        Text("BOTTOMS").bold()
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.bottoms, id: \.self) { bottom in
                                Image(uiImage: bottom)//UNSAFE
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .font(.system(size: 30))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                            }
                        }
                    }
                }else {
                    VStack (alignment: .leading) {
                        Text("BOTTOMS").bold()
                        Text("Not bottoms in wardrobe.")
                        LazyVGrid(columns: columns, spacing: 10){}
                    }
                }
                if (self.footwear.count > 0){
                    VStack (alignment: .leading) {
                        Text("FOOTWEAR").bold()
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(self.footwear, id: \.self) { foot in
                                Image(uiImage: foot)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .font(.system(size: 30))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .shadow(color: .white, radius: 5, x: 0, y: 0)
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
                                Image(uiImage: out)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .font(.system(size: 30))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .shadow(color: .white, radius: 5, x: 0, y: 0)
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
            .onAppear(perform: {
                self.populateCats()
            })
            .scrollDisabled(true)
            .brightness(-0.5)
            .padding(.horizontal)
            .frame(alignment: .leading)
            .background(backgroundColor)
            .overlay(tutorialOverlay, alignment: .center)
        }.navigationBarBackButtonHidden(true)
    }
}




