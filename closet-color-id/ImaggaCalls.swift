////
////  ViewController.swift
////  PhotoTagger
////
//import UIKit
import Alamofire
import Foundation
import UIKit
import SwiftUI
class ImaggaCalls: ObservableObject {
//    @Published var colors = [PhotoColor]()
//    @Published var image: UIImage
//    init(image: UIImage){
//        uploadImage(image: image)
//    }
    @State var colors: [PhotoColor]?
    let viewModel: ViewModel
    var image: UIImage? = nil
    @State var article: Article = Article()
  
  init(viewModel: ViewModel) {
      self.viewModel = viewModel
      //self.image = image
    }
    
  func uploadImage(completion: @escaping((Article) -> ())) {
        let myGroup = DispatchGroup()
        guard let imageData = self.image!.jpegData(compressionQuality: 0.5) else {
                print("Could not get JPEG representation of UIImage")
                return
            }
        myGroup.enter()
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData,
                                         withName: "image",
                                         fileName: "image.jpg",
                                         mimeType: "image/png")
            },
            with: ImaggaRouter.content)
        .responseData {response in
            switch response.result {
            case .success(let data):
                do{
                    guard let asJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let uploadedFiles = asJSON["result"] as? [String: Any],
                          let firstFileID = uploadedFiles["upload_id"] as? String else {
                        print("Invalid information received from service")
                        return
                    }
                    
                    print("Content uploaded with ID: \(firstFileID)")
                    
                    print("downloading")
                    
                  //self.downloadColors(uploadId: firstFileID, completion: completion)
                  //myGroup.leave()
                  myGroup.enter()
                      AF.request(ImaggaRouter.colors(firstFileID))
                          .responseData { response in
                              // 2.
                              switch response.result{
                              case .failure:
                                  print("Error while fetching colors: \(String(describing: response.result))")
                                  return
                              case .success(let data):
                                  do{
                                      guard let asJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                            let result = asJSON["result"] as? [String: Any],
                                            let info = result["colors"] as? [String: Any],
                                            let imageColors = info["image_colors"] as? [[String: Any]] else {
                                          print("Invalid color information received from service")
                                          return
                                      }
                                      let photoColors = imageColors.compactMap({ (dict) -> PhotoColor? in
                                          guard
                                              let hex = dict["closest_palette_color_html_code"] as? String,
                                              let name = dict["closest_palette_color"] as? String,
                                              let family = dict["closest_palette_color_parent"] as? String,
                                              let r = dict["r"] as? Int,
                                              let g = dict["g"] as? Int,
                                              let b = dict["b"] as? Int
                                          else {
                                              return nil
                                          }

                                          return PhotoColor(
                                              //'primaryHex', 'primaryName', 'primaryFamily', 'secondaryHex', 'secondaryName', 'secondaryFamily' in call
                                              primaryHex: hex,
                                              primaryName: name,
                                              primaryFamily: family,
                                              r: r,
                                              g: g,
                                              b: b)
                                      })
                                      self.colors = photoColors
                                    if photoColors.count == 1 {
                                      self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: photoColors.first!.primaryName, primary_color_family: photoColors.first!.primaryFamily, primary_r: photoColors.first!.r, primary_g: photoColors.first!.g, primary_b: photoColors.first!.b, secondary_color_name: nil, secondary_color_family: nil, secondary_r: nil, secondary_g: nil, secondary_b: nil)!
                                    } else {
                                      self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: photoColors.first!.primaryName, primary_color_family: photoColors.first!.primaryFamily, primary_r: photoColors.first!.r, primary_g: photoColors.first!.g, primary_b: photoColors.first!.b, secondary_color_name: photoColors[1].primaryName, secondary_color_family: photoColors[1].primaryFamily, secondary_r: photoColors[1].r, secondary_g: photoColors[1].g, secondary_b: photoColors[1].b)!
                                    }
                                    NSLog("done")
                                  } catch{
                                      print("Error while uploading file: \(String(describing: response.result))")
                                  }
                                  
                              }
                          }
                  myGroup.leave()
                  
                } catch{
                    print("Error while uploading file: \(String(describing: response.result))")
                }
            
            case .failure(let error):
                print("Error while uploading file: \(String(describing: error))")
                return
            }
          myGroup.leave()
          myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
            completion(self.article)
               }
        }
    }
    
  func downloadColors(uploadId: String, completion: @escaping((Article) -> ())){
      let myGroup = DispatchGroup()
    myGroup.enter()
        AF.request(ImaggaRouter.colors(uploadId))
            .responseData { response in
                // 2.
                switch response.result{
                case .failure:
                    print("Error while fetching colors: \(String(describing: response.result))")
                    return
                case .success(let data):
//                case .success(let data):
                    do{
                      print(try ImaggaRouter.colors(uploadId).asURLRequest())
                        guard let asJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                              let result = asJSON["result"] as? [String: Any],
                              let info = result["colors"] as? [String: Any],
                              let imageColors = info["image_colors"] as? [[String: Any]] else {
                            print("Invalid color information received from service")
                            return
                        }
                        let photoColors = imageColors.compactMap({ (dict) -> PhotoColor? in
                            guard
                                let hex = dict["closest_palette_color_html_code"] as? String,
                                let name = dict["closest_palette_color"] as? String,
                                let family = dict["closest_palette_color_parent"] as? String,
                                let r = dict["r"] as? Int,
                                let g = dict["g"] as? Int,
                                let b = dict["b"] as? Int
                            else {
                                return nil
                            }

                            return PhotoColor(
                                //'primaryHex', 'primaryName', 'primaryFamily', 'secondaryHex', 'secondaryName', 'secondaryFamily' in call
                                primaryHex: hex,
                                primaryName: name,
                                primaryFamily: family,
                                r: r,
                                g: g,
                                b: b)
                        })
                        self.colors = photoColors
                     
                    } catch{
                        print("Error while uploading file: \(String(describing: response.result))")
                    }
                  if self.colors!.count == 1 {
                    self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: self.colors!.first!.primaryName, primary_color_family: self.colors!.first!.primaryFamily, primary_r: self.colors!.first!.r, primary_g: self.colors!.first!.g, primary_b: self.colors!.first!.b, secondary_color_name: nil, secondary_color_family: nil, secondary_r: nil, secondary_g: nil, secondary_b: nil)!
                  } else {
                    self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: self.colors!.first!.primaryName, primary_color_family: self.colors!.first!.primaryFamily, primary_r: self.colors!.first!.r, primary_g: self.colors!.first!.g, primary_b: self.colors!.first!.b, secondary_color_name: self.colors![1].primaryName, secondary_color_family: self.colors![1].primaryFamily, secondary_r: self.colors!.first!.r, secondary_g: self.colors!.first!.g, secondary_b: self.colors!.first!.b)!
                  }
                }
            }
    myGroup.leave()
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
      completion(self.article)
         }
    }
}
