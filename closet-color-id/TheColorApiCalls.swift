////
////  TheColorApiCalls.swift
////  closet-color-id
////
////  Created by Allison Cao on 11/9/22.
////
//
//import Foundation
//import Foundation
//
//class TheColorApiCalls: ObservableObject {
//  let url = "https://www.thecolorapi.com/"
//  let params  = "scheme?hex=0047AB&rgb=0,71,171&hsl=215,100%,34%&cmyk=100,58,0,33&format=html&mode=analogic&count=6"
//  
//  var components = URLComponents()
//  components.scheme = "https"
//  components.host = "www.thecolorapi.com"
//  components.path = "/scheme"
//  
//  components.queryItems = [
//    URLQueryItem(name: "hex", value: "0047AB"),
//    URLQueryItem(name: "rgb", value: "0,71,171"),
//    URLQueryItem(name: "hsl", value: "215,100,34"),
//    URLQueryItem(name: "cmyk", value: "100,58,0,33"),
//  ]
//  
//  struct Result: Decodable {
//    let mode: String
//    let colors: [Color]
//    
//    enum CodingKeys : String, CodingKey {
//      case mode
//      case colors
//    }
//  }
//  
//  struct Color: Decodable {
//    let hex: Hex
//    let rgb: RGB
//    
//    enum CodingKeys : String, CodingKey {
//      case hex
//      case rgb
//    }
//  }
//  
//  struct Hex: Decodable {
//    let value: String
//    let clean: String
//    
//    enum CodingKeys : String, CodingKey {
//      case value
//      case clean
//    }
//  }
//  
//  struct RGB: Decodable {
//    let r: Int
//    let g: Int
//    let b: Int
//    
//    enum CodingKeys : String, CodingKey {
//      case r
//      case g
//      case b
//    }
//  }
//  
//  let task = URLSession.shared.dataTask(with: components.url!) { (data, response, error) in
//    guard let data = data else {
//      print("Error: No data to decode")
//      return
//    }
//    
//    guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
//      print("Error: Couldn't decode data into a result")
//      return
//    }
//    
//    print("Mode: \(result.mode)")
//    print("---------------------------")
//    
//    print("Complimentary Colors:")
//    for color in result.colors {
//      print("- \(color.hex.value)")
//    }
//    
//  }
//}
