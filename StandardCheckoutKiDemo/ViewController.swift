//
//  ViewController.swift
//  StandardCheckoutKiDemo
//
//  Created by Vinicius on 09/06/17.
//  Copyright © 2017 Paymentz. All rights reserved.
//

import UIKit
import StandardCheckoutKit

class ViewController: UIViewController, StandardCheckoutDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    @IBAction func pay(_ sender: UIButton) {
        
        let secureKey = "bzI93aEQeYDeE50Pa929NiDk3us8XTbU"
        
        let requestParameters = RequestParameters()
        requestParameters.memberId = "10558"
        requestParameters.paymentMode = ""
        requestParameters.terminalId = "7079"
        requestParameters.merchantTransactionId = "PZ858473484575536"
        requestParameters.amount = "50.00"
        requestParameters.currency = "USD"
        requestParameters.toType = "paymentz"
        requestParameters.paymentBrand = ""
        requestParameters.orderDescription = "Test"
        requestParameters.country = "IN"
        requestParameters.state = "MH"
        requestParameters.street = "Malad"
        requestParameters.city = "Mumbai"
        requestParameters.email = "savitha.m@paymentz.com"
        requestParameters.postCode = "400064"
        requestParameters.telnocc = "+91"
        requestParameters.phone = "9096831666"
        requestParameters.hostUrl = "https://sandbox.paymentplug.com/transaction/Checkout"
        requestParameters.device = "ios"
        let standardCheckout = StandardCheckout(viewController: self)
        standardCheckout.initPayment(requestParameters: requestParameters, standardCheckoutDelegate: self, secureKey: secureKey)
        
    }

    // Delegate methods is where you will receive the payment result
    func onSuccess(standardCheckoutResult: StandardCheckoutResult) {
        print("standardCheckoutResult: \(standardCheckoutResult.json)")
//        let resultViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
//        let json = standardCheckoutResult.json
//        resultViewController.standardCheckoutResult = "\(json)"
//        let resultNavigationController: UINavigationController = UINavigationController(rootViewController: resultViewController)
//        self.present(resultNavigationController, animated: true, completion: nil)
        let resultCode = standardCheckoutResult.json["resultCode"] as? Int ?? 0
        let message = standardCheckoutResult.json["resultDescription"] as? String
        
        if resultCode == 00001{
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Failed", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func onFail(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

