//
//  ContentView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 10/8/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = ViewModel()
    //Create tops, bottoms, footwear, and outerwear here>
    var body: some View {
        VStack {
            TabView{
                WardrobeView(tops: [], bottoms: [], footwear: [], outerwear: [])
                    .tabItem{
                        Label("Clothing", systemImage: "tshirt")
                    }
                ImageCaptureView(viewModel: viewModel)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
