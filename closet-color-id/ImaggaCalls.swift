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
    print("Image Imagga")
    print(self.image?.size)
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
                print("succ")
              
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
                            print("RESPONSE")
                            print(response)
                              switch response.result{
                              case .failure:
                                print("fisl)")
                                  print("Error while fetching colors: \(String(describing: response.result))")
                                  return
                              case .success(let data):
                                print("succ 2")
              //                case .success(let data):
                                  do{
                                    print(try ImaggaRouter.colors(firstFileID).asURLRequest())
                                      guard let asJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                            let result = asJSON["result"] as? [String: Any],
                                            let info = result["colors"] as? [String: Any],
                                            let imageColors = info["image_colors"] as? [[String: Any]] else {
                                          print("Invalid color information received from service")
                                          return
                                      }
                                    print("photocololors starting now")
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
                                      print(self.image)
                                      self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: photoColors.first!.primaryName, primary_color_family: photoColors.first!.primaryFamily, primary_r: photoColors.first!.r, primary_g: photoColors.first!.g, primary_b: photoColors.first!.b, secondary_color_name: photoColors[1].primaryName, secondary_color_family: photoColors[1].primaryFamily, secondary_r: photoColors.first!.r, secondary_g: photoColors.first!.g, secondary_b: photoColors.first!.b)!
                                    }
              //                      print(self.article.debugDescription)
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
                print("fial")
                print("Error while uploading file: \(String(describing: error))")
                return
            }
          myGroup.leave()
          myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                   print("AFTER GETTING RANDOM BEERS")
            //print(self.article!.primary_color_name!)
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
                          print(data)
                            return
                        }
                        print("Starting photoColors")
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
                      print("set self.colors")
                        self.colors = photoColors
                     
                    } catch{
                        print("Error while uploading file: \(String(describing: response.result))")
                    }
                  
                  print("COLOR COUNT")
                  print(String(self.colors!.count))
                  if self.colors!.count == 1 {
                    self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: self.colors!.first!.primaryName, primary_color_family: self.colors!.first!.primaryFamily, primary_r: self.colors!.first!.r, primary_g: self.colors!.first!.g, primary_b: self.colors!.first!.b, secondary_color_name: nil, secondary_color_family: nil, secondary_r: nil, secondary_g: nil, secondary_b: nil)!
                  } else {
                    print(self.image)
                    self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: self.colors!.first!.primaryName, primary_color_family: self.colors!.first!.primaryFamily, primary_r: self.colors!.first!.r, primary_g: self.colors!.first!.g, primary_b: self.colors!.first!.b, secondary_color_name: self.colors![1].primaryName, secondary_color_family: self.colors![1].primaryFamily, secondary_r: self.colors!.first!.r, secondary_g: self.colors!.first!.g, secondary_b: self.colors!.first!.b)!
                  }
//                      print(self.article.debugDescription)
                  print("done")
                    
                }
            }
    myGroup.leave()
    myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
             print("download completed")
      //print(self.colors!.first!.primaryName)
      completion(self.article)
         }
    }
}
//
//class ImaggaCalls: UIViewController{
//
//  // MARK: - Properties
//  fileprivate var tags: [String]?
//  fileprivate var colors: [PhotoColor]?
//
//  // MARK: - Navigation
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    if segue.identifier == "ShowResults" {
//      let controller = segue.destination as! UnsavedArticleView
//      controller.tags = tags
//      controller.colors = colors
//    }
//  }
//
//  // MARK: - IBActions
//  @IBAction func takePicture(_ sender: UIButton) {
//    let picker = UIImagePickerController()
//    picker.delegate = self
//    picker.allowsEditing = false
//
//    if UIImagePickerController.isSourceTypeAvailable(.camera) {
//      picker.sourceType = .camera
//    } else {
//      picker.sourceType = .photoLibrary
//      picker.modalPresentationStyle = .fullScreen
//    }
//
//    present(picker, animated: true)
//  }
//}
//
//// MARK: - UIImagePickerControllerDelegate
//extension ImaggaCalls: UIImagePickerControllerDelegate {
//
////  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
////    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
////      print("Info did not have the required UIImage for the Original Image")
////      dismiss(animated: true)
////      return
////    }
//    upload(
//      image: image,
//      completion: { [unowned self] tags, colors in
//        // 3
//
//        self.tags = tags
//        self.colors = colors
//
//        // 4
//        self.performSegue(withIdentifier: "ShowResults", sender: self)
//    })
//    dismiss(animated: true)
//  }
//}
//
//// MARK: - UINavigationControllerDelegate
//extension ImaggaCalls: UINavigationControllerDelegate {
//}
//
//// Networking calls
//extension ImaggaCalls {
//  func upload(image: UIImage,
//              completion: @escaping (_ tags: [String], _ colors: [PhotoColor]) -> Void) {
//      guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//      print("Could not get JPEG representation of UIImage")
//      return
//    }
//    Alamofire.upload(
//      multipartFormData: { multipartFormData in
//        multipartFormData.append(imageData,
//                                 withName: "image",
//                                 fileName: "image.jpg",
//                                 mimeType: "image/jpeg")
//    },
//      with: ImaggaRouter.content,
//      encodingCompletion: { encodingResult in
//        switch encodingResult {
//        case .success(let upload, _, _):
//          upload.validate()
//          upload.responseJSON { response in
//            // 1.
//            guard response.result.isSuccess else {
//              print("Error while uploading file: \(String(describing: response.result.error))")
//              completion([String](), [PhotoColor]())
//              return
//            }
//
//            // 2.
//            guard let responseJSON = response.result.value as? [String: Any],
//              let uploadedFiles = responseJSON["result"] as? [String: Any],
//              let firstFileID = uploadedFiles["upload_id"] as? String else {
//                print("Invalid information received from service")
//                completion([String](), [PhotoColor]())
//                return
//            }
//
//            print("Content uploaded with ID: \(firstFileID)")
//
//            // 3.
//            self.downloadTags(uploadId: firstFileID) { tags in
//              self.downloadColors(uploadId: firstFileID) { colors in
//                completion(tags, colors)
//              }
//            }
//          }
//        case .failure(let encodingError):
//          print(encodingError)
//        }
//    }
//    )
//  }
//  func downloadTags(uploadId: String, completion: @escaping ([String]) -> Void) {
//    AF.request(ImaggaRouter.tags(uploadId))
//      .responseJSON { response in
//        // 1.
//        guard response.result.isSuccess else {
//          print("Error while fetching tags: \(String(describing: response.result.error))")
//          completion([String]())
//          return
//        }
//
//        // 2.
//        guard let responseJSON = response.result.value as? [String: Any],
//          let result = responseJSON["result"] as? [String: Any],
//          let tagsAndConfidences = result["tags"] as? [[String: Any]] else {
//            print("Invalid tag information received from the service")
//            completion([String]())
//            return
//        }
//
//        // 3.
//        let tags = tagsAndConfidences.flatMap({ dict in
//          guard let tag = dict["tag"] as? [String: Any],
//            let tagName = tag["en"] as? String else {
//              return nil
//          }
//
//          return tagName
//        })
//
//        // 4.
//        completion(tags)
//    }
//  }
//  func downloadColors(uploadId: String, completion: @escaping ([PhotoColor]) -> Void) {
//    AF.request(ImaggaRouter.colors(uploadId))
//      .responseJSON { response in
//        // 2.
//        guard response.result.isSuccess else {
//          print("Error while fetching colors: \(String(describing: response.result.error))")
//          completion([PhotoColor]())
//          return
//        }
//
//        // 3.
//        guard let responseJSON = response.result.value as? [String: Any],
//          let result = responseJSON["result"] as? [String: Any],
//          let info = result["colors"] as? [String: Any],
//          let imageColors = info["image_colors"] as? [[String: Any]] else {
//            print("Invalid color information received from service")
//            completion([PhotoColor]())
//            return
//        }
//
//        // 4.
//        let photoColors = imageColors.flatMap({ (dict) -> PhotoColor? in
//          guard
//            let closestPaletteColorHex = dict["closest_palette_color_html_code"] as? String,
//            let closestPaletteColor = dict["closest_palette_color"] as? String,
//            let closestPaletteColorParentHex = dict["html_code"] as? String,
//            let closestPaletteColorParent = dict["closest_palette_color_parent"] as? String else {
//              return nil
//          }
//
//          return PhotoColor(
//                            colorHex: closestPaletteColorHex,
//                            colorName: closestPaletteColor,
//                            colorFamilyHex: closestPaletteColorParentHex,
//                            colorFamily: closestPaletteColorParent)
//        })
//
//        // 5.
//        completion(photoColors)
//    }
//  }
//}
