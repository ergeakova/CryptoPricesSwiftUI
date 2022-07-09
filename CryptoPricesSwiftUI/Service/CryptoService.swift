//
//  CryptoService.swift
//  CryptoPricesSwiftUI
//
//  Created by Erge Gevher Akova on 9.07.2022.
//

import Foundation

class CryptoService {
    
    func downloadCurrencies(url: URL, key: String, completion: @escaping(Result<[CryptoCurrency]?, DownloaderError>) -> Void){
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(key, forHTTPHeaderField: "X-CoinAPI-Key")
           
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
                completion(.failure(.badURL))
            }
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
                
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self,from: data) else {
                return completion(.failure(.dataParserError))
            }
            
            print(currencies)
            completion(.success(currencies))
        }.resume()
    }
    
    
}

enum DownloaderError: Error {
    case badURL
    case noData
    case dataParserError
}
