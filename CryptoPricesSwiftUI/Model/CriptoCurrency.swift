//
//  CriptoCurrency.swift
//  CryptoPricesSwiftUI
//
//  Created by Erge Gevher Akova on 9.07.2022.
//

import Foundation


struct CryptoCurrency: Codable, Identifiable {
    let id = UUID()
    let asset_id: String
    let price_usd: Float
    
    private enum codingKeys: String, CodingKey {
        case asset_id = "asset_id"
        case price_usd = "price_usd"
    }
}
