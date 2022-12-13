//
//  GenerateOutfitView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 12/8/22.
//
import SwiftUI



struct GenerateOutfitView: View {
    var viewModel: ViewModel
    @State var professional: [Article] = [Article]()
    @State var casual: [Article] = [Article]()
    @State var night_out: [Article] = [Article]()
    @State var athletic: [Article] = [Article]()
    @State var outfitGenerated = false
    func popStyles(){
        self.professional = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "professional")!)!
        self.casual = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "casual")!)!
        self.night_out = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "night")!)!
        self.athletic = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "athletic")!)!
    }
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.94, blue: 0.91).ignoresSafeArea()
            NavigationView{
                VStack{
                    Button("PROFESSIONAL") {
                        self.outfitGenerated = true
                        self.viewModel.generateOutfit(style: "professional", name: "OUTFIT")
                        
                    }
                    .padding(4)
                    .background(.white)
                    .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                    .font(.system(size: 20))
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                    Button("CASUAL") {
                        self.outfitGenerated = true
                        self.viewModel.generateOutfit(style: "casual", name: "OUTFIT")
                        
                    }
                    .padding(4)
                    .background(.white)
                    .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                    .font(.system(size: 20))
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                    Button("NIGHT OUT") {
                        self.outfitGenerated = true
                        self.viewModel.generateOutfit(style: "night", name: "OUTFIT")
                        
                    }
                    .padding(4)
                    .background(.white)
                    .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                    .font(.system(size: 20))
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                    Button("ATHLETIC") {
                        self.outfitGenerated = true
                        self.viewModel.generateOutfit(style: "athletic", name: "OUTFIT")
                        
                    }
                    .padding(4)
                    .background(.white)
                    .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                    .font(.system(size: 20))
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                    if self.outfitGenerated {
                        if self.viewModel.outfit != nil {
                            NavigationLink (
                                destination: NameNewOutfitView(viewModel: viewModel, outfit: viewModel.outfit!),
                                label:{
                                    Text("Done").frame(maxHeight: 50, alignment: .bottom).font(.system(size: 30))
                                })
                        } else {
                            NavigationLink (
                                destination: OutfitErrorView(viewModel: viewModel),
                                label:{
                                    Text("Done").frame(maxHeight: 50, alignment: .bottom).font(.system(size: 30))
                                })
                        }
                    }
                }
                
            }.navigationBarBackButtonHidden(true)
                .onAppear(perform: {
                    self.popStyles()
                })
        }.background(Color(red: 0.96, green: 0.94, blue: 0.91))
    }
}
//import SwiftUI
//
//
//
//struct GenerateOutfitView: View {
//    var viewModel: ViewModel
//    @State var professional: [Article] = [Article]()
//    @State var casual: [Article] = [Article]()
//    @State var night_out: [Article] = [Article]()
//    @State var athletic: [Article] = [Article]()
//    @State var outfitGenerated = false
//    func popStyles(){
//        self.professional = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "professional")!)!
//        self.casual = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "casual")!)!
//        self.night_out = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "night")!)!
//        self.athletic = self.viewModel.fetchStyleArts(style: self.viewModel.fetchStyle(name: "athletic")!)!
//    }
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//    var body: some View {
//        ZStack{
//            Color(red: 0.96, green: 0.94, blue: 0.91).ignoresSafeArea()
//            VStack{
//                NavigationView{
//                        VStack{
//                                Button("PROFESSIONAL") {
//                                    self.outfitGenerated = true
//                                    self.viewModel.generateOutfit(style: "professional", name: "OUTFIT")
//                                }
//                                .padding(5)
//                                .background(.white)
//                                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//                                .clipShape(Capsule())
//                                .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
//                                Button("CASUAL") {
//                                    self.outfitGenerated = true
//                                    self.viewModel.generateOutfit(style: "casual", name: "OUTFIT")
//                                }
//                                .padding(5)
//                                .background(.white)
//                                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//                                .clipShape(Capsule())
//                                .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
//                                Button("NIGHT OUT") {
//                                    self.outfitGenerated = true
//                                    self.viewModel.generateOutfit(style: "night", name: "OUTFIT")
//                                }
//                                .padding(5)
//                                .background(.white)
//                                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//                                .clipShape(Capsule())
//                                .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
//                                Button("ATHLETIC") {
//                                    self.outfitGenerated = true
//                                    self.viewModel.generateOutfit(style: "athletic", name: "OUTFIT")
//                                }
//                                .padding(5)
//                                .background(.white)
//                                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//                                .clipShape(Capsule())
//                                .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
//                                if self.outfitGenerated {
//                                    if self.viewModel.outfit != nil {
//                                        NavigationLink (
//                                            destination: NameNewOutfitView(viewModel: viewModel, outfit: viewModel.outfit!),
//                                            label:{
//                                                Text("Done").frame(maxHeight: 50, alignment: .bottom).font(.system(size: 30))
//                                            })
//                                        .padding(5)
//                                        .background(.white)
//                                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//                                        .clipShape(Capsule())
//                                        .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
//                                    } else {
//                                        NavigationLink (
//                                            destination: OutfitErrorView(viewModel: viewModel),
//                                            label:{
//                                                Text("Done").frame(maxHeight: 50, alignment: .bottom).font(.system(size: 30))
//                                            })
//                                        .padding(5)
//                                        .background(.white)
//                                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
//                                        .clipShape(Capsule())
//                                        .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
//                                    }
//                                }
//                        }.background(Color(red: 0.96, green: 0.94, blue: 0.91))
//                    }
//                    .navigationBarBackButtonHidden(true)
//                    .onAppear(perform: {
//                        self.popStyles()
//                    })
//                }
//            }
//        }
//    }
//
////struct GenerateOutfitView_Previews: PreviewProvider {
////    static var previews: some View {
////        GenerateOutfitView()
////    }
////}
