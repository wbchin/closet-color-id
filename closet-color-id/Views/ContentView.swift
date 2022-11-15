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
    @State private var selection = 0
    @State private var tappedOnce: Bool = false
    @State private var camera = UUID()

    @State var capturedImage: UIImage? = nil
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
        HStack {
            TabView {
                WardrobeView(viewModel: viewModel)
                    .tabItem{
                        Label("Clothing", systemImage: "tshirt")
                    }.tag(0)
                ImageCaptureView( viewModel: viewModel, image: nil)
                    .tabItem{
                        Label("Camera", systemImage: "camera")
                    }.tag(1)
              OutfitsView(viewModel: viewModel, dataPopulation: dataPopulation)
                    .tabItem{
                        Label("Outfits", systemImage: "door.french.closed")
                    }.tag(2)
            }.accentColor(Color(red: 0.30, green: 0.11, blue: 0.00))
        }
        .onAppear(perform: {
            self.viewModel.deleteAllArticles()
            self.viewModel.deleteAllArticleStyles()
            self.viewModel.deleteAllStyles()
            self.viewModel.updateArticles()
            self.viewModel.updateStyles()
            if self.viewModel.styles.count == 0{
                self.dataPopulation.populateStyles()
                self.viewModel.updateStyles()
            }
            if self.viewModel.arts.count == 0 {
                self.dataPopulation.createArticle()
            }
        })
    }
}
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
