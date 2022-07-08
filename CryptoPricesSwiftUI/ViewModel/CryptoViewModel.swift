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
    
    func downloadCryptos(url: URL, key: String){
        service.downloadCurrencies(url: url, key: key) { result in
            switch result {
                case .failure(let error):
                    print(error)
            case .success(let cryptos):
                if let cryptos = cryptos{
                    DispatchQueue.main.async {
                        self.crtptoList = cryptos.map(CryptoViewModel.init)
                    }
                }
            }
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
