//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
  //  var coinManagerDelegate : CoinManagerDelegate?
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
        
    }
    


}
//MARK:- UIPickerViewdelagate

extension ViewController: UIPickerViewDelegate
{
    
}

extension ViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currencyLabel.text = coinManager.currencyArray[row]
        coinManager.getConversion(currency: coinManager.currencyArray[row])
       // print(coinManager.currencyArray[row])
    }
}

//MARK:- CoinManagerDelegate

extension ViewController: CoinManagerDelegate
{
    func didUpdateData(_ coinManager: CoinManager, _ coinData: Double) {
        DispatchQueue.main.async {
             self.bitcoinLabel.text = String(format: "%.2f", coinData)
        }
       
        
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }
    
    
}
