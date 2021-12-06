//
//  BeersViewModel.swift
//  Cheers_v1
//
//  Created by Sooyoung Kim on 2021/11/03.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class BeersViewModel: ObservableObject {
  @Published var beers = [Beer]()
  @Published var beerDetails = Product()
  @ObservedObject var imgExt = ImageViewModel()
  @Published var beerImg = ""
  private var db = Firestore.firestore()
  
  func getBeersData() {
    db.collection("beers").getDocuments {
      querySnapshot, error in
          guard let documents = querySnapshot?.documents else {
                print("No documents! \(error!)")
                return
            }
          for documentSnapshot in documents {
            let data = documentSnapshot.data()
            let name = data["Name"] as? String ?? ""
            let abv = data["ABV"] as? Double ?? 0.0
            let sour = data["Sour"] as? Int ?? 0
            let astring = data["Astringency"] as? Int ?? 0
            let key = data["key"] as? Int ?? 0
            let style = data["Style"] as? String ?? ""
            let malty = data["Malty"] as? Int ?? 0
            let alcohol = data["Alcohol"] as? Int ?? 0
            let bitter = data["Bitter"] as? Int ?? 0
            let avgR = data["Ave Rating"] as? Double ?? 0.0
            let description = data["Description"] as? String ?? ""
            let fruits = data["Fruits"] as? Int ?? 0
            let spices = data["Spices"] as? Int ?? 0
            let hoppy = data["Hoppy"] as? Int ?? 0
            let sweet = data["Sweet"] as? Int ?? 0
            let salty = data["Salty"] as? Int ?? 0
            
            let b1 = Beer(abv: abv, sour: sour, astring: astring, key: key, style: style, malty: malty, alcohol: alcohol, bitter: bitter, avgRating: avgR, description: description, name: name, fruits: fruits, spices: spices, hoppy: hoppy, sweet: sweet, salty: salty)
            self.beers.append(b1)
//            print("ABV of Beer 1: \(b1.abv)")
//            print("Alcohol rate of Beer 1: \(b1.alcohol)")
//            print("Name of Beer 1: \(b1.name)")
//            print("Avg Rating of Beer 1: \(b1.avgRating)")
//            print("Test printing of Beer 1 Done. Breaking out!")
//            break
          }
    }
  }

  //var UserTags = ["Malty","Salty"]

  func getRandomBeers(tags: [String]? = nil) {
    var inputTags = tags
    if tags != nil {
      inputTags?.shuffle()
      let firstTag = inputTags![0]
      db.collection("beers").getDocuments {
        querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                  print("No documents! \(error!)")
                  //completion(nil)
                  return
              }
            for documentSnapshot in documents {
              let data = documentSnapshot.data()
              if data[firstTag] as! Int > 50 {
                let name = data["Name"] as? String ?? ""
                let abv = data["ABV"] as? Double ?? 0.0
                let sour = data["Sour"] as? Int ?? 0
                let astring = data["Astringency"] as? Int ?? 0
                let key = data["key"] as? Int ?? 0
                let style = data["Style"] as? String ?? ""
                let malty = data["Malty"] as? Int ?? 0
                let alcohol = data["Alcohol"] as? Int ?? 0
                let bitter = data["Bitter"] as? Int ?? 0
                let avgR = data["Ave Rating"] as? Double ?? 0.0
                let description = data["Description"] as? String ?? ""
                let fruits = data["Fruits"] as? Int ?? 0
                let spices = data["Spices"] as? Int ?? 0
                let hoppy = data["Hoppy"] as? Int ?? 0
                let sweet = data["Sweet"] as? Int ?? 0
                let salty = data["Salty"] as? Int ?? 0
                
                let b2 = Beer(abv: abv, sour: sour, astring: astring, key: key, style: style, malty: malty, alcohol: alcohol, bitter: bitter, avgRating: avgR, description: description, name: name, fruits: fruits, spices: spices, hoppy: hoppy, sweet: sweet, salty: salty)
                self.beers.append(b2)
//                print("ABV of Recommended Beer 1: \(b2.abv)")
//                print("Alcohol rate of Recommended Beer 1: \(b2.alcohol)")
//                print("Name of Recommended Beer 1: \(b2.name)")
//                print("Avg Rating of Recommended Beer 1: \(b2.avgRating)")
//                print("Test printing of Recommended Beer 1 Done. Breaking out!")
//                break
              }
              
          }
      }
      
    } else {
      //give Random beers
      getBeersData()
    }
  }
  
  func getBeerDetail(name: String) {
    
    let beerRef = self.db.collection("beers").document(name)
    beerRef.getDocument { document, error in
      if let error = error as NSError? {
        "Reference not found"
      }
      else {
        if let document = document {
          do {
            let data = document.data()
            let alc = data?["ABV"] as? Double ?? 0.0
            let style = data?["Style"] as? String ?? ""
            let brew = data?["Brewery"] as? String ?? ""
            let avgRating = data?["Ave Rating"] as? Double ?? 0.0
            let sour = data?["Sour"] as? Int ?? 0
            let bitter = data?["Bitter"] as? Int ?? 0
            let sweet = data?["Sweet"] as? Int ?? 0
            let fruity = data?["Fruits"] as? Int ?? 0
            print(alc)
            self.beerDetails = Product(name: name, image: "", avgRating: avgRating, alc: alc, brewery: brew, style: style, sweet: sweet, sour: sour, bitter: bitter, fruits: fruity)
            print(self.beerDetails.avgRating)
          }
          catch {
            print(error)
          }
        }
      }
    }
  }

  func load(barcode: String) {
    var arr = Array(barcode)
    var realbar = barcode
    var sub1 = ""
    if barcode.count == 8 {
      var seventh = arr[6]
      if ["0","1","2"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 3])
        sub1 += String(seventh) + "0000"
        sub1 += String(arr[3 ..< 6])
        sub1 += String(arr[7])
      }
      if ["3"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 4])
        sub1 += "00000"
        sub1 += String(arr[4 ..< 6])
        sub1 += String(arr[7])
      }
      if ["4"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 5])
        sub1 += "00000"
        sub1 += String(arr[5 ..< 6])
        sub1 += String(arr[7])
      }
      if ["5","6","7","8","9"].contains(String(seventh)) {
        sub1 = String(arr[0 ..< 6])
        sub1 += "0000" + String(seventh)
        sub1 += String(arr[7])
      }
    }

    print(sub1)
    if sub1 != "" {
      realbar = sub1
    }
   let url = "https://buycott.com/api/v4/products/lookup?barcode=\(realbar)&access_token=njpTtmc5if7vMhCXL4jGBqQ48fL9mxh_OSY-E3Wp"
   let myGroup = DispatchGroup()
   myGroup.enter()
   let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
     guard let data = data else {
       print("Error: No data to decode")
       return
     }
     guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
       print("Error: Couldn't decode data into a result")
       return
     }
   for p in result.products {
     print(p.name)
     myGroup.enter()
     self.imgExt.getImage(beer: p.name, completion: { (success) -> Void in
       print("+==============")
       print(success)
       if success {
         DispatchQueue.main.async {
           print("SHIBAL")
           print(self.imgExt.imgURL)
           self.beerImg = self.imgExt.imgURL
         }
         //self.beerImg = self.imgExt.imgURL
         
         self.getBeerDetail(name: self.imgExt.itemName)
       }
     })
     myGroup.leave()
     break
   }
   myGroup.leave()
 }
 myGroup.notify(queue: DispatchQueue.global(qos: .background)) {
 }
 task.resume()

 
 }
}

