////
////  CustomTabBar.swift
////  closet-color-id
////
////  Created by Tina Lin on 11/8/22.
////
//
//import SwiftUI
//
//enum Tabs: Int {
//    case wardrobe = 0
//    case outfits = 1
//}
//
//struct CustomTabBar: View {
//    
////    @Binding var selectedTabs: Tabs
//    @ObservedObject var viewModel = ViewModel()
//    @Binding var capturedImage: UIImage?
//
//    var body: some View {
//        HStack {
//            NavigationLink(destination: WardrobeView(viewModel: viewModel, tops: [], bottoms: [], footwear: [], outerwear: [])) {
//                VStack {
//                    Image(systemName: "tshirt")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                    Text("WARDROBE")
//                }
//            }.foregroundColor(.brown)
//            
//            Spacer()
//            
//            NavigationLink(destination: CustomCameraView(capturedImage: $capturedImage)) {
//                VStack {
//                    Image(systemName: "camera")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//                        .padding(20)
//                        .foregroundColor(.white)
//                        .background(Color.brown)
//                        .clipShape(Circle())
//                        .offset(y:-30)
//                        .padding(.bottom, -20)
//                }
//            }.foregroundColor(.brown)
//            
//            Spacer()
//            
//            NavigationLink(destination: OutfitsView()) {
//                VStack {
//                    Image(systemName: "door.french.closed")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                    Text("OUTFITS")
//                }
//            }.foregroundColor(.brown)
//        }
//        .padding()
////        .background(Color.gray)
//    }
//}
//
////struct CustomTabBar_Previews: PreviewProvider {
////    static var previews: some View {
////        CustomTabBar()
////    }
////}
