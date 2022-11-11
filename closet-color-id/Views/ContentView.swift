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
  //@ObservedObject var imaggaCall: ImaggaCalls
  
//  init(viewModel: ViewModel){
//    self.viewModel = viewModel
//    self.imaggaCall = ImaggaCalls(viewModel: viewModel)
//    //self.image = image// << here !!
//  }
  //Create tops, bottoms, footwear, and outerwear here>
  var articles : [Article]? {
      get {
       return viewModel.fetchArticles()
      }
  }
  
  var handler: Binding<Int> { Binding(
      get: { return self.selection },
      set: {
        print("entered handler")
          if ($0 == 0 || $0 == 2) {
              print("Reset here!!")
            ImageCaptureView.article = nil
            ImageCaptureView.imaggaCall.image = nil
            ImageCaptureView.image = nil
          }
          self.selection = $0
      }
  )}
  
  
//  var articles: [Article]? = viewModel.fetchArticles()
  var body: some View {
    VStack {
        
      TabView(selection: handler) {
        WardrobeView(viewModel: viewModel,
                     tops: [], bottoms: [], footwear: [], outerwear: [])
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
    }.onAppear(perform: {
      self.dataPopulation.populateStyles()
    })
  }
//    func customTab() {
//        CustomTabBar(capturedImage: $capturedImage)
//    }
  }
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
  }

