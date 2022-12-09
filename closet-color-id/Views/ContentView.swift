import SwiftUI
struct CustomTab: View {
    @Binding var capturedImage: UIImage?
    var body: some View {
        Text("hello picture")
    }
}
struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    @State private var isTutorial: Bool = UserDefaults.standard.bool(forKey: "didLaunchBefore")
    @State private var tappedOnce: Bool = false
    @State private var camera = UUID()
//    @State var capturedImage: UIImage? =  UIImage(named: "pusheen.png")
    @ObservedObject var dataPopulation = DataPopulation()
    @ObservedObject var viewModel = ViewModel()
    
    var articles : [Article]? {
        get {
            return viewModel.fetchArticles()
        }
    }
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0.74, green: 0.64, blue: 0.55, alpha: 1.00)
    }
    @State private var tabSelection = 1
    @State private var tappedTwice: Bool = false

    @State private var wardrobe = UUID()
    @State private var cam = UUID()
    @State private var outfits = UUID()
    var handler: Binding<Int> { Binding(
                        get: { self.tabSelection },
                        set: {
                            if $0 == self.tabSelection {
                                // Lands here if user tapped more than once
                                tappedTwice = true
                            }
                            self.tabSelection = $0
                        }
                )}
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                self.isTutorial = true
            }) {
                Image(systemName: "info.circle")
            }
        }
        .background(Color(red: 0.96, green: 0.94, blue: 0.91))
        ZStack{
            TabView(selection: handler) {
                if (self.isTutorial) {
                    NavigationView {
                        TutorialStartView(viewModel: viewModel, isTutorial: self.$isTutorial)
                            .id(wardrobe)
                            .onChange(of: tappedTwice, perform: { tappedTwice in
                                self.viewModel.deleteUntaggedArticles(completion: {out in })
                                self.viewModel.updateArticles()
                                guard tappedTwice else { return }
                                wardrobe = UUID()
                                self.tappedTwice = false
                            })
                            .navigationBarTitle("WARDROBE")
                    }
                    .tabItem {
                        Image(systemName: "tshirt")
                        Text("Wardrobe")
                    }
                    .tag(1)
                } else {
                    NavigationView {
                        WardrobeView(viewModel: viewModel)
                            .id(wardrobe)
                            .onChange(of: tappedTwice, perform: { tappedTwice in
                                self.viewModel.deleteUntaggedArticles(completion: {out in })
                                self.viewModel.updateArticles()
                                guard tappedTwice else { return }
                                wardrobe = UUID()
                                self.tappedTwice = false
                            })
                            .navigationBarTitle("WARDROBE")
                    }.tabItem {
                        Image(systemName: "tshirt")
                        Text("Wardrobe")
                    }
                    .tag(1)
                }
                
                NavigationView {
                    ImageCaptureView(viewModel: viewModel, image: viewModel.image)
                        .id(cam)
                        .onChange(of: tappedTwice, perform: { tappedTwice in
                            
                            guard tappedTwice else { return }
                            cam = UUID()
                            self.tappedTwice = false
                            viewModel.image = nil
                            self.viewModel.deleteUntaggedArticles(completion: {out in })
                            self.viewModel.updateArticles()
                            self.viewModel.article = nil
                        })
                }
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
                .tag(2)
                
                if (self.isTutorial) {
                    NavigationView {
                        TutorialStartView(viewModel: viewModel, isTutorial: self.$isTutorial)
                            .id(wardrobe)
                            .onChange(of: tappedTwice, perform: { tappedTwice in
                                self.viewModel.deleteUntaggedArticles(completion: {out in })
                                self.viewModel.updateArticles()
                                guard tappedTwice else { return }
                                wardrobe = UUID()
                                self.tappedTwice = false
                            })
                            .navigationBarTitle("WARDROBE")
                    }.tabItem {
                        Image(systemName: "tshirt")
                        Text("Wardrobe")
                    }
                    .tag(1)
                } else {
                    NavigationView {
                        OutfitsView(viewModel: viewModel)
                            .id(outfits)
                            .onChange(of: tappedTwice, perform: { tappedTwice in
                                guard tappedTwice else { return }
                                outfits = UUID()
                                self.tappedTwice = false
                            })
                            .navigationBarTitle("OUTFITS")
                    }
                    .tabItem {
                        Image(systemName: "door.french.closed")
                        Text("Outfits")
                    }
                    .tag(3)
                }
            }
            if (self.isTutorial) {
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white.opacity(0.001))
                        .frame(width: .infinity, height: 50)
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.deleteAllArticles()
          self.viewModel.deleteAllArticleStyles()
          self.viewModel.deleteAllStyles()
          self.viewModel.deleteAllArticleStyles()
          self.viewModel.deleteAllOutfits()
          if self.viewModel.styles.count == 0{
              self.dataPopulation.populateStyles()
              self.viewModel.updateStyles()
          }
          self.dataPopulation.createArticle()
            self.viewModel.updateArticles()
            self.viewModel.updateStyles()

        })
        .background(Color(red: 0.96, green: 0.94, blue: 0.91))
    }
}
