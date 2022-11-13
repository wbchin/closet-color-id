import Foundation
import SwiftUI

struct TagStyleView: View {
  let viewModel: ViewModel
  //  @State private var capturedImage: UIImage? = UIImage(named:"shirt.png")
  var article: Article
  @State var comp_hue: Int = 0
  @State var comp_name: String?
  //  var imaggaCall: ImaggaCalls
  @State var isShowingStyle = true
  @State var runColor = false
  var article_rgb: String {
    get {
      return String(article.primary_r) + "," + String(article.primary_g) + "," + String(article.primary_b)
    }
  }
  @ObservedObject var colorApiCall: TheColorApiCalls = TheColorApiCalls()
  
  
  func runColorApi() {
    //    try await self.colorApiCall.load(rgb: self.article_rgb, completion: { (success) -> Void in
    //      self.comp_hue = self.colorApiCall.hue!
    //      self.comp_name = self.colorApiCall.name!
    self.colorApiCall.fetchAlamo(rgb: self.article_rgb, completion: { name in
        if name {
            
            self.comp_name = colorApiCall.name
            self.comp_hue = colorApiCall.hue!
        }
    })
   
    
  }
  
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().padding().rotationEffect(.degrees(90))
                Text("Styles").font(.system(size: 36))
                if !runColor{
                    Text("").onAppear{
                        self.runColorApi()
                        runColor = true
                    }
                }
                if (self.comp_name != nil){
                    Text("").onAppear{
                        let family = self.viewModel.setColorFamily(hue: self.comp_hue)
                        viewModel.setComplimentaryColor(article: article, complimentary_color_family: family, complimentary_color_name: self.colorApiCall.name!)
                    }
                    ForEach(self.viewModel.styles) { style in
                        Button(action: {
                            
                            viewModel.tagArticleStyle(article_id: article.objectID, style_id: style.objectID)
                            isShowingStyle = false
                            //        self.imaggaCall.image = nil
                            //        self.imaggaCall.article = Article()
                        }) {
                            Text(style.name!).frame(maxHeight: 50, alignment: .bottom).font(.system(size: 36))
                        }
                    }
                    if !isShowingStyle {
                        //        let article = self.viewModel.saveArticle()
                        NavigationLink (
                            destination: ArticleView(article: article, viewModel: viewModel),
                            label:{
                                Text("Done").font(.system(size: 36))
                            })//UNSAFE
                    }
                }}.navigationBarBackButtonHidden(true)
        }
    }
}
