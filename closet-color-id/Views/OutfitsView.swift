//
//  OutfitsView.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import SwiftUI

struct OutfitsView: View {
//    let viewController: ViewController
    @State private var clothes = ["pink tee", "green tee", "black tee"]
    var body: some View {
            NavigationView {
                List {
                    ForEach(clothes, id: \.self) { item in
                        Text(item)
                    }
                }
                .navigationBarTitle("CLOTHES")
                .navigationBarItems(trailing: Button(action: {
                    self.addRow()
                }) {
                    Image(systemName: "plus")
                })
            }
        }
    private func addRow() {
        self.clothes.append("New Clothes")
    }
}

//struct OutfitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutfitsView()
//    }
//}
