//
//  TheColorApiCalls.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/9/22.
//

import Foundation
import Alamofire

class TheColorApiCalls: ObservableObject {
    var hue: Int?
    var name: String?
    var seedHue: Int?
    var seedName: String?
    var r: Int?
    var g: Int?
    var b: Int?
  
    struct Result: Decodable {
        let mode: String
        let colors: [Color]
        
        enum CodingKeys : String, CodingKey {
            case mode
            case colors
        }
    }
    
    struct Color: Decodable {
        let hex: Hex
        let hsv: HSV
        let name: Name
        let rgb: RGB
        
        enum CodingKeys : String, CodingKey {
            case hex
            case hsv
            case name
            case rgb
        }
        
    }
    
    struct Name: Decodable {
        let value: String
        
        enum CodingKeys : String, CodingKey {
            case value
        }
    }
    
    struct Hex: Decodable {
        let value: String
        let clean: String
        
        enum CodingKeys : String, CodingKey {
            case value
            case clean
        }
    }
    
    struct HSV: Decodable{
        let h: Int
        let s: Int
        let v: Int
        
        enum CodingKeys : String, CodingKey {
            case h
            case s
            case v
        }
    }
  
    struct RGB: Decodable{
        let r: Int
        let g: Int
        let b: Int
        
        enum CodingKeys : String, CodingKey {
            case r
            case g
            case b
        }
    }
    
    func fetchHue(rgb: String, completion: @escaping((Int) -> ()) ) async throws -> Int {
        let myGroup = DispatchGroup()
        myGroup.enter()
        let url = "https://www.thecolorapi.com/scheme?rgb=\(rgb)&mode=analogic-complement"
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        let hue = try Int(JSONDecoder().decode(Result.self, from: data).colors[0].hsv.h)
        myGroup.leave()
        myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
            completion(hue)
        }
        return hue
    }
    
    func fetchAlamo(rgb: String, completion: @escaping((Bool) -> ())){
        let myGroup = DispatchGroup()
        myGroup.enter()
        AF.request("https://www.thecolorapi.com/scheme?rgb=\(rgb)&mode=analogic-complement").responseData{
            response in
            switch response.result{
            case .failure:
                print("fail to get response from the color api")
                return
            case .success(let data):
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any?],
//                          let result = json["result"] as? [String: Any],
                          let colors = json["colors"] as? [[String: Any]],
                          let seed = json["seed"] as? [String: Any],
                          let seedName = seed["name"] as? [String: Any],
                          let seedNameValue = seedName["value"] as? String,
                          let seedHSVArray = seed["hsv"] as? [String: Any],
                          let seedH = seedHSVArray["h"] as? Int,
                          let nameArray = colors.first!["name"] as? [String: Any?],
                          let hsvArray = colors.first!["hsv"] as? [String: Any?],
                          let rgbArray = colors.first!["rgb"] as? [String: Any?],
                          let name = nameArray["value"] as? String,//unsure
                          let h = hsvArray["h"] as? Int,
                          let r = rgbArray["r"] as? Int,
                          let g = rgbArray["g"] as? Int,
                          let b = rgbArray["b"] as? Int
                    else{
                        print("fail to read json correctly")
                        return 
                    }
                    self.name = name
                    self.hue = h
                    self.r = r
                    self.g = g
                    self.b = b
                    self.seedName = seedNameValue
                    self.seedHue = seedH
                }catch {
                    print("json serial fail")
                    return
                }
            }
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                completion(true)
            }
        }
    }
}
