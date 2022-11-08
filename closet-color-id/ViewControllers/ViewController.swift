////
////  ViewController.swift
////  closet-color-id
////
////  Created by Waverly Chin on 11/2/22.
////
//
//import Foundation
//import Alamofire
//
//class ViewController: ObservableObject{
//    extension ViewController {
//        func upload(image: UIImage,
//                    progressCompletion: @escaping (_ percent: Float) -> Void,
//                    completion: @escaping (_ tags: [String], _ colors: [PhotoColor]) -> Void) {
//            guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
//                print("Could not get JPEG representation of UIImage")
//                return
//            }
//            Alamofire.upload(
//                multipartFormData: { multipartFormData in
//                    multipartFormData.append(imageData,
//                                             withName: "image",
//                                             fileName: "image.jpg",
//                                             mimeType: "image/jpeg")
//                },
//                with: ImaggaRouter.content,
//                encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .success(let upload, _, _):
//                        upload.uploadProgress { progress in
//                            progressCompletion(Float(progress.fractionCompleted))
//                        }
//                        upload.validate()
//                        upload.responseJSON { response in
//                            // 1.
//                            guard response.result.isSuccess else {
//                                print("Error while uploading file: \(String(describing: response.result.error))")
//                                completion([String](), [PhotoColor]())
//                                return
//                            }
//                            
//                            // 2.
//                            guard let responseJSON = response.result.value as? [String: Any],
//                                  let uploadedFiles = responseJSON["result"] as? [String: Any],
//                                  let firstFileID = uploadedFiles["upload_id"] as? String else {
//                                print("Invalid information received from service")
//                                completion([String](), [PhotoColor]())
//                                return
//                            }
//                            
//                            print("Content uploaded with ID: \(firstFileID)")
//                            
//                            // 3.
//                            self.downloadTags(uploadId: firstFileID) { tags in
//                                self.downloadColors(uploadId: firstFileID) { colors in
//                                    completion(tags, colors)
//                                }
//                            }
//                        }
//                    case .failure(let encodingError):
//                        print(encodingError)
//                    }
//                }
//            )
//        }
//        
//        func downloadColors(uploadId: String, completion: @escaping ([PhotoColor]) -> Void) {
//            Alamofire.request(ImaggaRouter.colors(uploadId))
//                .responseJSON { response in
//                    // 2.
//                    guard response.result.isSuccess else {
//                        print("Error while fetching colors: \(String(describing: response.result.error))")
//                        completion([PhotoColor]())
//                        return
//                    }
//                    
//                    // 3.
//                    guard let responseJSON = response.result.value as? [String: Any],
//                          let result = responseJSON["result"] as? [String: Any],
//                          let info = result["colors"] as? [String: Any],
//                          let imageColors = info["image_colors"] as? [[String: Any]] else {
//                        print("Invalid color information received from service")
//                        completion([PhotoColor]())
//                        return
//                    }
//                    
//                    // 4.
//                    let photoColors = imageColors.flatMap({ (dict) -> PhotoColor? in
//                        guard
//                            let hex = dict["closest_palette_color_html_code"] as? String,
//                            let name = dict["closest_palette_color"] as? String,
//                            let family = dict["closest_palette_color_parent"] as? String
//                        else {
//                            return nil
//                        }
//                        
//                        return PhotoColor(
//                            //'primaryHex', 'primaryName', 'primaryFamily', 'secondaryHex', 'secondaryName', 'secondaryFamily' in call
//                            primaryHex: hex,
//                            primaryName: name,
//                            primaryFamily: family)
//                    })
//                    completion(photoColors)
//                }
//        }
//    }
//}
