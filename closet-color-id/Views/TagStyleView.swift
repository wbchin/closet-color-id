import Foundation
import SwiftUI

struct TagStyleView: View {
  let viewModel: ViewModel
  var article: Article
  @State var comp_hue: Int = 0
  @State var comp_r: Int = 0
  @State var comp_g: Int = 0
  @State var comp_b: Int = 0
  @State var comp_name: String?
  @State var isShowingStyle = true
  @State var runColor = false
  var article_rgb: String {
    get {
      return String(article.primary_r) + "," + String(article.primary_g) + "," + String(article.primary_b)
    }
  }
  @ObservedObject var colorApiCall: TheColorApiCalls = TheColorApiCalls()
  
  
  func runColorApi() {
    self.colorApiCall.fetchAlamo(rgb: self.article_rgb, completion: { name in
        if name {
            self.comp_name = colorApiCall.name
            self.comp_hue = colorApiCall.hue!
            self.comp_r = colorApiCall.r!
            self.comp_g = colorApiCall.g!
            self.comp_b = colorApiCall.b!
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
                      let family = self.viewModel.setColorFamily(color: self.viewModel.rgbToHue(r: (CGFloat)(Float(self.comp_r)/255.0), g: (CGFloat)(Float(self.comp_g)/255.0), b: (CGFloat)(Float(self.comp_b)/255.0)))
                      viewModel.setComplimentaryColor(article: article, complimentary_color_family: family, complimentary_color_name: self.colorApiCall.name!, complimentary_r: self.comp_r, complimentary_g: self.comp_g, complimentary_b: self.comp_b)
                    }
                    ForEach(self.viewModel.styles) { style in
                        Button(action: {
                            
                            viewModel.tagArticleStyle(article_id: article.objectID, style_id: style.objectID)
                            isShowingStyle = false
                        }) {
                            Text(style.name!).frame(maxHeight: 50, alignment: .bottom).font(.system(size: 36))
                        }
                    }
                    if !isShowingStyle {
                        NavigationLink (
                            destination: ArticleView(article: article, viewModel: viewModel),
                            label:{
                                Text("Done").font(.system(size: 36))
                            })//UNSAFE
                    }
                }
            }.navigationBarBackButtonHidden(true)
        }
    }
}
