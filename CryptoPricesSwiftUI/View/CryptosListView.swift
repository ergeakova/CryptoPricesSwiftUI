//
//  ContentView.swift
//  CryptoPricesSwiftUI
//
//  Created by Erge Gevher Akova on 8.07.2022.
//

import SwiftUI

struct CryptosListView: View {
    @ObservedObject var crptos: CryptoListViewModel
    
    init(){
        crptos = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView{
            List(crptos.crtptoList, id:\.id){ crpto in
                VStack{
                    Text(crpto.asset_id)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(String(crpto.price_usd))
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }.toolbar(content: {
                Button{
                    Task.init{
                        await crptos.downloadCryptosAsync(url: URL(string:"https://rest.coinapi.io/v1/assets?filter_asset_id=BTC,ETC,XRP,LTC,NMC,USDT,DOGE,NVC,FTC,PPC,TRC,KST,TOR,NMC,NXT")!, key: "YOUR_API_KEY")
                    }
                }label: { Text("Refresh") }
            }).navigationTitle("Cryptos")
        }.task {
            await crptos.downloadCryptosAsync(url: URL(string:"https://rest.coinapi.io/v1/assets?filter_asset_id=BTC,ETC,XRP,LTC,NMC,USDT,DOGE,NVC,FTC,PPC,TRC,KST,TOR,NMC,NXT")!, key: "YOUR_API_KEY")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CryptosListView()
    }
}
