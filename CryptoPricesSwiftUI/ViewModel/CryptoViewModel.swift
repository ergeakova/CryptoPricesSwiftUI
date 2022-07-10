//
//  CryptoViewModel.swift
//  CryptoPricesSwiftUI
//
//  Created by Erge Gevher Akova on 9.07.2022.
//

import Foundation
import Combine

class CryptoListViewModel: ObservableObject{
    
    let service = CryptoService()
    @Published var crtptoList = [CryptoViewModel]()
    
    func downloadCryptosAsync(url: URL, key: String) async {
        do{
            let cryptos = try await service.downloadCurrenciesAsync(url: url, key: key)
            DispatchQueue.main.async {
                self.crtptoList = cryptos.map(CryptoViewModel.init)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}


struct CryptoViewModel {
    let crypto: CryptoCurrency
    var id: UUID? {
        crypto.id
    }
    var asset_id: String {
        crypto.asset_id
    }
    var price_usd: Float {
        crypto.price_usd
    }
}
