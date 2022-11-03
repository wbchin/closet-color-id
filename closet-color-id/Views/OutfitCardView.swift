//
//  OutfitCardView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitCardView: View {
    var outfit: Outfit
    var body: some View {
        NavigationLink (
            destination: OutfitView(outfit: outfit),
            label:{
                Text(outfit.name)
            })
    }
}

//struct OutfitCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutfitCardView()
//    }
//}
