import Foundation
import SwiftUI

struct TagStyleView: View {
  let viewModel: ViewModel
  var article: Article
  @State var comp_hue: Int = 0
  @State var comp_r: Int = 0
  @State var comp_col: (Int, CGFloat, CGFloat) = (0, CGFloat(0.0), CGFloat(0.0))
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
          self.comp_col = self.viewModel.rgbToHue(r: (CGFloat)(Float(self.comp_r)/255.0), g: (CGFloat)(Float(self.comp_g)/255.0), b: (CGFloat)(Float(self.comp_b)/255.0))
        }
    })
   
    
  }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack (spacing: 10) {
                    Image(uiImage: UIImage(data: article.image_data!)!).resizable().scaledToFit().cornerRadius(10)
                    Spacer()
                    Text("What style is this article?")
                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                        .font(.system(size: 20))
                        .bold()
                        .textCase(.uppercase)
                    if !runColor{
                        Text("").onAppear{
                            self.runColorApi()
                            runColor = true
                        }
                    }
                    if (self.comp_name != nil){
                        Text("").onAppear{
                            let family = self.viewModel.setColorFamily(hue: self.comp_col.0, saturation: self.comp_col.1, brightness: self.comp_col.2)
                            viewModel.setComplimentaryColor(article: article, complimentary_color_family: family, complimentary_color_name: self.colorApiCall.name!, complimentary_r: self.comp_r, complimentary_g: self.comp_g, complimentary_b: self.comp_b)
                        }
                    }
                    LazyVGrid(columns: columns, spacing: 20) {
                        if (self.comp_name != nil){
                            ForEach(self.viewModel.styles) { style in
                                Button(style.name!.uppercased()) {
                                    viewModel.tagArticleStyle(article_id: article.objectID, style_id: style.objectID)
                                    isShowingStyle = false
                                }
                                .frame(width: geometry.size.width * 0.35)
                                .padding(5)
                                .background(.white)
                                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                                .clipShape(Capsule())
                                .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                            }
                        }
                    }
                    if !isShowingStyle {
                        Spacer(minLength: 5)
                        NavigationLink (
                          destination: ArticleView(article: article, viewModel: viewModel),
                          label:{
                              Text("Done").bold()
                          })
                        .frame(width: geometry.size.width * 0.35)
                        .padding(5)
                        .background(.white)
                        .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                        .clipShape(Capsule())
                        .shadow(color: Color(red: 0.30, green: 0.11, blue: 0.00), radius: 5, x: 0, y: 0)
                    }
                }
                .padding()
                .frame(width: geometry.size.width)
                .foregroundColor(Color(red: 0.30, green: 0.11, blue: 0.00))
                .font(.system(size: 20))
                .textCase(.uppercase)
                .background(Color(red: 0.96, green: 0.94, blue: 0.91))
            }
        }.navigationBarBackButtonHidden(true)
    }
}
