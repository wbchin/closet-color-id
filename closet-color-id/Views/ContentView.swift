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
//@ObservedObject var imaggaCall: ImaggaCalls
//  init(viewModel: ViewModel){
//    self.viewModel = viewModel
//    self.imaggaCall = ImaggaCalls(viewModel: viewModel)
//    //self.image = image// << here !!
//  }
//Create tops, bottoms, footwear, and outerwear here>
struct ContentView: View {
    @State private var selection = 0
    @State private var tappedOnce: Bool = false
    @State private var camera = UUID()

    @State var capturedImage: UIImage? = nil
    @ObservedObject var dataPopulation = DataPopulation()
    @ObservedObject var viewModel = ViewModel()
//    let backgroundColor : Color = Color(red: 246/255, green: 239/255, blue: 232/255)
    var articles : [Article]? {
        get {
            return viewModel.fetchArticles()
        }
    }
//    init() {
//
//    }
//  var handler: Binding<Int> { Binding(
//      get: { return self.selection },
//      set: {
//        print("entered handler")
//          if ($0 == 0 || $0 == 2) {
//              print("Reset here!!")
////            ImageCaptureView.article = nil
////            ImageCaptureView.imaggaCall.image = nil
////            ImageCaptureView.image = nil
//          }
//          self.selection = $0
//      }
//  )}
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
                OutfitsView()
                    .tabItem{
                        Label("Outfits", systemImage: "door.french.closed")
                    }.tag(2)
            }
        }
        .onAppear(perform: {
//            self.viewModel.deleteAllArticles()
//            self.viewModel.deleteAllStyles()
            self.viewModel.updateArticles()
            self.viewModel.updateStyles()
            if self.viewModel.styles.count == 0{
                self.dataPopulation.populateStyles()
                self.viewModel.updateStyles()
            }
            self.dataPopulation.createArticle()
        })
    }
}
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
