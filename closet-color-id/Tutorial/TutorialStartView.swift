import SwiftUI

struct ArrowShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        let delta = rect.height / 2  // height of arrow tip legs
        
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            path.move(to: CGPoint(x: rect.maxX - delta, y: rect.midY - delta))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX - delta, y: rect.midY + delta))
        }
    }
}

struct TutorialStartView: View {
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
    
    private func arrowPath() -> Path {
        // Doing it rightwards
        Path { path in
            path.move(to: .zero)
            path.addLine(to: .init(x: -10.0, y: 5.0))
            path.addLine(to: .init(x: -10.0, y: -5.0))
            path.closeSubpath()
        }
    }
        
    private func arrowTransform(lastPoint: CGPoint, previousPoint: CGPoint) -> CGAffineTransform {
        let translation = CGAffineTransform(translationX: lastPoint.x, y: lastPoint.y)
        let angle = atan2(lastPoint.y-previousPoint.y, lastPoint.x-previousPoint.x)
        let rotation = CGAffineTransform(rotationAngle: angle)
        return rotation.concatenating(translation)
    }
    
    private var tutorialOverlay: some View {
        VStack {
            Text("Welcome to MY CLOSET, your mobile closet. Let’s start out with a tour.")
                .frame(width: 250, alignment: .center)
              .padding()
            
            HStack {
                NavigationLink(destination: WardrobeTutorialView(viewModel: viewModel, isTutorial: $isTutorial)) {
                    Text("START").bold()
                }
                NavigationLink(destination: WardrobeView(viewModel: viewModel, isTutorial: $isTutorial)) {
                    Text("SKIP")
                }.simultaneousGesture(TapGesture().onEnded{
                    //isTutorial = false
                    self.isTutorial.toggle()
                })
            }
//            Button(action: {
//                self.isTutorial.toggle()
//            }, label: {
//                if self.isTutorial {
//                    Text("continue tutorial")
//                }else {
//                    Text("skip tutorial")
//                }
//            })
        }.background(
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.white)
              .padding(6)
          )
    }
    
    var body: some View {
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
            
        }.onAppear(perform: {
            self.populateCats()
        })
        .scrollDisabled(true)
        .brightness(-0.5)
        .padding(.horizontal)
        .frame(alignment: .leading)
        .background(backgroundColor)
        .overlay(tutorialOverlay, alignment: .center)
    }
}


