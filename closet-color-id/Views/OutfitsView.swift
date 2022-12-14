//
//  OutfitsView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitsView: View {
  var viewModel: ViewModel
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
    @State var professional: [Article] = [Article]()
    @State var casual: [Article] = [Article]()
    @State var night_out: [Article] = [Article]()
    @State var athletic: [Article] = [Article]()
    @State var outfits = [Outfit]()
    func popStyles(){
        self.professional = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "professional")!)!
        self.casual = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "casual")!)!
        self.night_out = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "night")!)!
        self.athletic = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "athletic")!)!
    }
    func addRow() {
        let viewModel: ViewModel
        var outfits : [Outfit]? {
            get {
                return viewModel.fetchOutfits()
            }
        }
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.94, blue: 0.91).ignoresSafeArea()
            NavigationView {
                ScrollView{
                    Spacer()
                    VStack {
                        VStack{
                            Text("OUTFITS")
                                .bold()
                                .font(.title)
                            NavigationLink {
                                GenerateOutfitView(viewModel: viewModel)
                            } label: {
                                Text("Generate Outfit")
                            }
                            .textCase(.uppercase)
                            .padding(5)
                            .background(.white)
                            .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                            .clipShape(Capsule())
                            .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                        }
                        Spacer()
                        if(self.outfits.count > 0){
                            VStack{
                                LazyVGrid(columns: columns){
                                    ForEach(self.outfits, id: \.self) { outfit in
                                        NavigationLink(destination: OutfitView(outfit: outfit, viewModel: viewModel)) {
                                            LazyVGrid(columns: columns){
                                                ForEach(self.viewModel.organizeOutfit(outfit: outfit)!, id: \.self){ article in
                                                    Image(uiImage: UIImage(data: article.image_data!)!)
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 70)
                                                        .cornerRadius(10)
                                                        .padding(10)
                                                }
                                            }
                                            .background(Color(red: 0.30, green: 0.11, blue: 0.00))
                                            .cornerRadius(15)
                                        }
                                    }
                                }
                            }
                        } else {
                            VStack (alignment: .leading) {
                                Text("No outfits.")
                                LazyVGrid(columns: columns, spacing: 10){}
                            }
                        }
                    }
                }
                .padding()
//                .navigationTitle("OUTFITS")
                .frame(alignment: .leading)
                .background(Color(red: 0.96, green: 0.94, blue: 0.91))
                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                .onAppear(perform: {
                    self.popStyles()
                    self.outfits = viewModel.fetchOutfits()!
                    self.viewModel.outfit = nil
                })
                .navigationBarBackButtonHidden(true)
            }
        }
    }
  }
  
