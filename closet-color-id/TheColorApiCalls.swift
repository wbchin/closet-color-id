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
        
        enum CodingKeys : String, CodingKey {
            case hex
            case hsv
            case name
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
                print("fail")
                return
            case .success(let data):
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any?],
//                          let result = json["result"] as? [String: Any],
                          let colors = json["colors"] as? [[String: Any]],
                          let nameArray = colors.first!["name"] as? [String: Any?],
                          let hsvArray = colors.first!["hsv"] as? [String: Any?],
                          let name = nameArray["value"] as? String,//unsure
                          let h = hsvArray["h"] as? Int
                    else{
                        print("fail")
                        return 
                    }
                    self.name = name
                    self.hue = h
                }catch {
                    print("json serial fail")
                    return
                }
            }
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                print("color api done aamo")
                //print(self.colors!.first!.primaryName)
                completion(true)
            }
        }
        
        
        
        func fetchName(rgb: String, completion: @escaping((String) -> ())) {
            let myGroup = DispatchGroup()
            myGroup.enter()
            
            let url = "https://www.thecolorapi.com/scheme?rgb=\(rgb)&mode=analogic-complement"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
                
                guard let data = data else {
                    Swift.print("Error: No data to decode")
                    return
                }
                
                guard let r = try? JSONDecoder().decode(Result.self, from: data) else {
                    Swift.print("Error: Couldn't decode data into a result")
                    return
                }
                self.name = r.colors[0].name.value
            }
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                print("fetchName completion")
                completion(self.name!)
            }
        }
        
        //  func load2(rgb: String) {
        //    Task {
        //      do {
        //        let hue = try await fetchHue(rgb: rgb, completion: hue
        //                                     in self.hue! = hue)
        //        print(hue)
        //      }
        //      catch {
        //        print(Error.self)
        //      }
        //    }
        //  }
        
        
        func load(rgb: String, completion: @escaping((Bool) -> ())) async {
            let myGroup = DispatchGroup()
            myGroup.enter()
            let url = "https://www.thecolorapi.com/scheme?rgb=\(rgb)&mode=analogic-complement"
            print(url)
            
            //let sem = DispatchSemaphore(value: 0)
            
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
                    
                    guard let data = data else {
                        Swift.print("Error: No data to decode")
                        return
                    }
                    
                    guard let r = try? JSONDecoder().decode(Result.self, from: data) else {
                        Swift.print("Error: Couldn't decode data into a result")
                        return
                    }
                    self.hue = Int(r.colors[0].hsv.h)
                    self.name = r.colors[0].name.value
                    print(self.hue)
                    print(self.name)
                    //SAVE TO ARTICLE
                }
                task.resume()
                //sem.wait(timeout: .distantFuture)
            }
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
                completion(true)
            }
        }
    }
}
