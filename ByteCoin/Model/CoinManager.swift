//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateData(_ coinManager : CoinManager, _ coinData: Double)
    func didFailWithError(_ coinManager : CoinManager, error : Error)
}
struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "CC4E70BC-B6B6-4239-ABBE-E5F6468D9833"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getConversion(currency : String)
    {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        self.perfromRequest(with: urlString)
    }
    
    func perfromRequest(with urlString: String)
    {
        if  let url = URL(string: urlString){
        let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    print(error)
                }
                if let safeData = data{
                    if let price = self.parseJSON(safeData){
                        self.delegate?.didUpdateData(self, price)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ data : Data)->Double?
    {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodeData.rate
            print(lastPrice)
            return lastPrice
        }
        catch {
            self.delegate?.didFailWithError(self, error: error)
            return nil
            
        }
        
        
    }
}
