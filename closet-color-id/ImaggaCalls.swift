////
////  ViewController.swift
////  PhotoTagger
////
//import UIKit
import Alamofire
import Foundation
import UIKit
import SwiftUI
class ImaggaCalls: ObservableObject{
//    @Published var colors = [PhotoColor]()
//    @Published var image: UIImage
//    init(image: UIImage){
//        uploadImage(image: image)
//    }
    @Published var colors: [PhotoColor]?
    let viewModel = ViewModel()
  let image: UIImage? = UIImage(named: "pusheen.png")
    @State var article: Article = Article()
    
  func uploadImage(image: UIImage, completion: @escaping((Article) -> ())) {
        let myGroup = DispatchGroup()
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
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
                    
                  self.downloadColors(uploadId: firstFileID, completion: completion)
                  //myGroup.leave()
                  
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
            //print(self.article.primary_color_name!)
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
                        let photoColors = imageColors.compactMap({ (dict) -> PhotoColor? in
                            guard
                                let hex = dict["closest_palette_color_html_code"] as? String,
                                let name = dict["closest_palette_color"] as? String,
                                let family = dict["closest_palette_color_parent"] as? String
                            else {
                                return nil
                            }

                            return PhotoColor(
                                //'primaryHex', 'primaryName', 'primaryFamily', 'secondaryHex', 'secondaryName', 'secondaryFamily' in call
                                primaryHex: hex,
                                primaryName: name,
                                primaryFamily: family)
                        })
                        self.colors = photoColors
                      if photoColors.count == 1 {
                          self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: photoColors.first!.primaryName, primary_color_family: photoColors.first!.primaryFamily, primary_color_hex: photoColors.first!.primaryHex)!
                      } else {
                        self.article = self.viewModel.saveArticle(image_data: self.image!.pngData()!, primary_color_name: photoColors.first!.primaryName, primary_color_family: photoColors.first!.primaryFamily, primary_color_hex: photoColors.first!.primaryHex, secondary_color_name: photoColors[1].primaryName, secondary_color_family: photoColors[1].primaryFamily, secondary_color_hex: photoColors[1].primaryHex)!
                      }
                      //print(self.article.primary_color_name!)
                    } catch{
                        print("Error while uploading file: \(String(describing: response.result))")
                    }
                    
                }
                
                
                // 4.
                
                
                // 5.
//                completion(photoColors)
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
