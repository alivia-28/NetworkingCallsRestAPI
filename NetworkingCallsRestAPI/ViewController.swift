//
//  ViewController.swift
//  NetworkingCallsRestAPI
//
//  Created by Alivia Guin on 10/18/21.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class ViewController: UIViewController {
    let baseURL = "https://financialmodelingprep.com/api/v3/quote-short/"
    let apiKey = "7944c7ed8bb2eea5c7913e92669fd37d"

    @IBOutlet weak var txtStock: UITextField!
    
    
    @IBOutlet weak var lblStock: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getStockValue(_ sender: Any) {
        if lblStock.text == "" {
            return;
        }
        
        let url = baseURL + txtStock.text! + "?apikey=" + apiKey
        
        SwiftSpinner.show("Getting stock value")
        
        AF.request(url).responseJSON { response in
            
            SwiftSpinner.hide()
            
            if response.error != nil {
                print(response.error!)
                return
            }
            
            print(response.data!)
            let stocks = JSON(response.data!).array
            
            if stocks?.isEmpty == true {
                print("Stock symbol was incorrect")
                return
            }
            
            //We have atleast one value
            let firstStock = stocks![0]
            let price = firstStock["price"]
            let symbol = firstStock["symbol"]
            let volume = firstStock["volume"]
            
            self.lblStock.text = "\(symbol) price = \(price)"
            
        }
    }
    
}

