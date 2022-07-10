//
//  CryptoService.swift
//  CryptoPricesSwiftUI
//
//  Created by Erge Gevher Akova on 9.07.2022.
//

import Foundation

class CryptoService {
    
    func downloadCurrenciesAsync(url: URL, key: String) async throws -> [CryptoCurrency] {
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(key, forHTTPHeaderField: "X-CoinAPI-Key")
    
        let (data, res ) = try await URLSession.shared.data(for: request)
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self,from: data)
        return currencies ?? []
    }
}

enum DownloaderError: Error {
    case badURL
    case noData
    case dataParserError
}
