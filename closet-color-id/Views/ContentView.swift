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
    @State var capturedImage: UIImage? = nil
  @ObservedObject var dataPopulation = DataPopulation()
  @ObservedObject var viewModel = ViewModel()
  //Create tops, bottoms, footwear, and outerwear here>
  var articles : [Article]? {
      get {
       return viewModel.fetchArticles()
      }
  }
//  var articles: [Article]? = viewModel.fetchArticles()
  var body: some View {
    VStack {
        
        
      TabView{
        WardrobeView(viewModel: viewModel,
                     tops: [], bottoms: [], footwear: [], outerwear: [])
        .tabItem{
          Label("Clothing", systemImage: "tshirt")
        }
          
        ImageCaptureView(imaggaCall: ImaggaCalls(),  viewModel: viewModel)
            .tabItem{
              Label("Camera", systemImage: "camera")
            }
        OutfitsView()
            .tabItem{
              Label("Outfits", systemImage: "door.french.closed")
            }
        }
    }
    }
    func customTab() {
        CustomTabBar(capturedImage: $capturedImage)
    }
  }
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
  }

