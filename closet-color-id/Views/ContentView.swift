//
//  ContentView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 10/8/22.
//

import SwiftUI
struct CustomTab: View {
    @Binding var capturedImage: UIImage?
    var body: some View {
        Text("hello picture")
    }
}
struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    @State private var isTutorial: Bool = true
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
    
    var body: some View {
        
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
        return TabView(selection: handler) {
                 NavigationView {
                     WardrobeView(viewModel: viewModel)
                         .id(wardrobe)
                         .onChange(of: tappedTwice, perform: { tappedTwice in
                                                 guard tappedTwice else { return }
                                                 wardrobe = UUID()
                             self.tappedTwice = false
                                         })
             }
             .tabItem {
                     Image(systemName: "tshirt")
                     Text("Wardrobe")
             }
             .tag(1)

              NavigationView {
                  ImageCaptureView(viewModel: viewModel, image: viewModel.image)
                      .id(cam)
                          .onChange(of: tappedTwice, perform: { tappedTwice in
                              viewModel.image = nil
                                                     guard tappedTwice else { return }
                                                     cam = UUID()
                              self.tappedTwice = false
                                             })
              }
              .tabItem {
                      Image(systemName: "camera")
                  Text("Camera")
              }
              .tag(2)
            NavigationView {
                OutfitsView(viewModel: viewModel)
                    .id(outfits)
                        .onChange(of: tappedTwice, perform: { tappedTwice in
                                                   guard tappedTwice else { return }
                                                   outfits = UUID()
                            self.tappedTwice = false
                                           })
            }
            .tabItem {
                    Image(systemName: "door.french.closed")
                Text("Outfits")
            }
            .tag(3)
//                 }
//        HStack{
//            Spacer()
//            Button(action: {
//                self.isTutorial = true
//            }) {
//                Image(systemName: "info.circle")
//            }
//            .padding(5)
//        }
//        .background(Color(red: 0.96, green: 0.94, blue: 0.91))
//        ZStack {
//            HStack {
//                TabView() {
//                    if ($userSettings.isFirstTimeUser.wrappedValue || self.isTutorial) {
//                        TutorialStartView(viewModel: viewModel, isTutorial: true)
//                            .tabItem{
//                                Label("Clothing", systemImage: "tshirt")
//                            }
//                    } else {
//                        WardrobeView(viewModel: viewModel)
//                            .tabItem{
//                                Label("Clothing", systemImage: "tshirt")
//                            }
//                    }
//                    ImageCaptureView( viewModel: viewModel, image: nil)
//                        .tabItem{
//                            Label("Camera", systemImage: "camera")
//                        }
//                    OutfitsView(viewModel: viewModel)
//                        .tabItem{
//                            Label("Outfits", systemImage: "door.french.closed")
//                        }.tag(2)
//                }.accentColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//
//            }
//            .navigationBarItems(trailing: Button(action: {
//                self.isTutorial = true
//              }) {
//                Image(systemName: "info.circle")
//              })
//            if ($userSettings.isFirstTimeUser.wrappedValue || self.isTutorial) {
//                VStack {
//                    Spacer()
//                    if ($userSettings.isFirstTimeUser.wrappedValue || self.isTutorial) {
//                        Rectangle()
//                            .fill(Color.white.opacity(0.001))
//                            .frame(width: .infinity, height: 50.0)
//
//                    }
//                }
//            }

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
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
