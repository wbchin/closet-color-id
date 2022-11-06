//
//  ContentView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 10/8/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            TabView{
                WardrobeView()
                    .tabItem{
                        Label("Wardrobe", systemImage: "tshirt")
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
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
