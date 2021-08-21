//
//  ViewModel.swift
//  Order Apps
//
//  Created by William Santoso on 21/08/21.
//

import Foundation


class ViewModel: ObservableObject {
    @Published var listData: [DataModel] = []
    @Published var cartData: [DataModel] = []
    @Published var isLoading = false
    
    var total: Double {
        var temp: Double = 0
        if !cartData.isEmpty {
            for data in cartData {
                let price = Double(data.price) ?? 0
                temp += price * Double(data.qty)
            }
        }
        return temp
    }
    
    init() {
//        getData()
        listData = Bundle.main.decode([DataModel].self, from: "detail.json")
    }
    
    func addToCart(at index: Int) {
        listData[index].qty += 1
        cartData.append(listData[index])
    }
    
    func getData() {
        let urlString = "https://ranting.twisdev.com/index.php/rest/items/search/api_key/teampsisthebest/"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        isLoading = true
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print(urlString)
                return
            }
            
            guard let decoded = try? JSONDecoder().decode([DataModel].self, from: data) else {
                print(urlString)
                print(String(data: data, encoding: .utf8) ?? "no data")
                return
            }
            
            DispatchQueue.main.async {
                self.listData = decoded
                self.isLoading = false
            }
        }.resume()
        
        
    }
}


extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

extension String {
    func splitDigit() -> String {
        let num = Double(self) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: num)) ?? ""
    }
}

extension Double {
    func splitDigit() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
