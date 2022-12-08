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
    var body: some View {
        Button(action: {
            self.isTutorial = true
        }) {
            Text("Tutorial")
        }
        ZStack {
            HStack {
                TabView() {
                    if ($userSettings.isFirstTimeUser.wrappedValue || self.isTutorial) {
                        TutorialStartView(viewModel: viewModel, isTutorial: true)
                            .tabItem{
                                Label("Clothing", systemImage: "tshirt")
                            }
                    } else {
                        WardrobeView(viewModel: viewModel)
                            .tabItem{
                                Label("Clothing", systemImage: "tshirt")
                            }
                    }
                    ImageCaptureView( viewModel: viewModel, image: nil)
                        .tabItem{
                            Label("Camera", systemImage: "camera")
                        }
                    OutfitsView(viewModel: viewModel, dataPopulation: dataPopulation)
                        .tabItem{
                            Label("Outfits", systemImage: "door.french.closed")
                        }.tag(2)
                }.accentColor(Color(red: 0.30, green: 0.11, blue: 0.00))
            }
            if ($userSettings.isFirstTimeUser.wrappedValue || self.isTutorial) {
                VStack {
                    Spacer()
                    if ($userSettings.isFirstTimeUser.wrappedValue || self.isTutorial) {
                        Rectangle()
                            .fill(Color.white.opacity(0.001))
                            .frame(width: .infinity, height: 50.0)
                            
                    }
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
    }
}
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
