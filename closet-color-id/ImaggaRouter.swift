//
//  ImaggaRouter.swift
//  closet-color-id
//
//  Created by Waverly Chin on 11/2/22.
//

import Foundation
import Alamofire

public enum ImaggaRouter: URLRequestConvertible {
  static let baseURLPath = "https://api.imagga.com/v2"
  static let authenticationToken = "Basic YWNjXzc2NGUwZjgzNDIwZGVlYjplMjczOWY0MTM5NTEzMWZmMDRmM2ExODhlNjYwNmQ1Zg=="
  
  case content
  case colors(String)
  
  var method: HTTPMethod {
    switch self {
    case .content:
      return .post
    case .colors:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .content:
      return "/uploads"
    case .colors:
      return "/colors"
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let parameters: [String: Any] = {
      switch self {
      case .colors(let uploadId):
        return ["image_upload_id": uploadId, "extract_object_colors": 0]
      default:
        return [:]
      }
    }()
    
    let url = try ImaggaRouter.baseURLPath.asURL()
    //print(url)
    var request = URLRequest(url: url.appendingPathComponent(path))
    request.httpMethod = method.rawValue
    request.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
    //print(request)
    request.timeoutInterval = TimeInterval(10 * 1000)
    
    return try URLEncoding.default.encode(request, with: parameters)
  }
}
