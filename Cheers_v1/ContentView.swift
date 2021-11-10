//
//  ContentView.swift
//  Cheers_v1
//
//  Created by Sung Tae Kim on 10/28/21.
//

import SwiftUI
import Alamofire

enum Tab {
    case home
    case search
    case feed
    case profile
    case scan
    case result
}

struct ContentView: View {
//    @ObservedObject var obs = observer(barcode: "038766301208")

    @Binding var selectedTab: Tab
    @Binding var selectedImage: UIImage?
    @Binding var barcodeValue: String?
    
//    init() {
//        UINavigationBar.appearance().barTintColor = UIColor(Color("Background Color"))
//        let coloredAppearance = UINavigationBarAppearance()
//            coloredAppearance.configureWithOpaqueBackground()
//            coloredAppearance.backgroundColor = UIColor(Color("Background Color"))
//            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//            UINavigationBar.appearance().standardAppearance = coloredAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//    }
    
    var body: some View {
        VStack {
            
            switch selectedTab {
                case .home:
                    NavigationView {
                        HomeView()
                    }
                case .search:
                    NavigationView {
                        SearchView()
                    }
                case .feed:
                    NavigationView {
                        FeedView()
                    }
                case .profile:
                    NavigationView {
                        ProfileView()
                    }
                case .scan:
                    NavigationView {
                        ScanView(selectedImage: self.$selectedImage, barcodeValue: self.$barcodeValue, selectedTab: self.$selectedTab).navigationBarHidden(true)
                    }
                case .result:
//                HStack {
//                    Text(self.barcodeValue!)
//
//                }
                DetailScreen(barcodeValue: self.$barcodeValue)
//                    NavigationView {
//                        DetailsView(selectedImage: self.$selectedImage, barcodeValue: self.$barcodeValue, selectedTab: self.$selectedTab).navigationBarHidden(true)
//                    }
            }
            if (selectedTab != .scan) {
            CustomTabView(selectedTab: $selectedTab)
                .frame(height: 50)
            }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

//class observer : ObservableObject {
////  @Published var datas = [Product]()
//
//  init(barcode: String) {
//    let url = "https://buycott.com/api/v4/products/lookup?barcode=\(barcode)&access_token=qeqwI-4DPMJeAm2rBUrwTzgNA1aF3fCjb2r2rmEb"
//    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
//      guard let data = data else {
//        print("Error: No data to decode")
//        return
//      }
//      guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
//        print("Error: Couldn't decode data into a result")
//        return
//    }
//    for p in result.products {
//      print(p.name)
//      print(p.image)
//    }
//  }
//  task.resume()
//}
//
//
//}
