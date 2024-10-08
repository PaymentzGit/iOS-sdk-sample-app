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

    @IBOutlet weak var merchantId: UITextField!
    @IBOutlet weak var amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    @IBAction func pay(_ sender: UIButton) {
        
        guard let merchantId = merchantId.text, !merchantId.isEmpty else {
            let alert = UIAlertController(title: "Mandatory Field", message: "Please enter Merchant Id", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
            return
        }
        guard let amount = Float(amount.text!), amount >= 1 else { 
            let alert = UIAlertController(title: "Invalid Amount", message: "Please enter valid amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
            return
        }

        let secureKey = "YOiHKCvM2XSHcMEMbBrHCYzNS8iIZOi4"
        
        let requestParameters = RequestParameters()
        requestParameters.memberId = "13219"
        requestParameters.paymentMode = ""
        requestParameters.paymentBrand = ""
        requestParameters.terminalId = ""
        requestParameters.merchantTransactionId = merchantId
        requestParameters.amount = String(amount)
        requestParameters.currency = "INR"
        requestParameters.toType = "paymentz"
        requestParameters.orderDescription = "Test"
        requestParameters.country = "IN"
        requestParameters.state = "MH"
        requestParameters.street = "Malad"
        requestParameters.city = "Mumbai"
        requestParameters.email = "tejas.gandhi@paymentz.com"
        requestParameters.postCode = "400064"
        requestParameters.telnocc = "+91"
        requestParameters.phone = "9096831666"
        requestParameters.hostUrl = "https://test.paymentz.com/transaction/Checkout"
        requestParameters.device = "ios"
        let standardCheckout = StandardCheckout(viewController: self)
        standardCheckout.initPayment(requestParameters: requestParameters, standardCheckoutDelegate: self, secureKey: secureKey)
        
    }

    // Delegate methods is where you will receive the payment result
    func onSuccess(standardCheckoutResult: StandardCheckoutResult) {
        print("standardCheckoutResult: \(standardCheckoutResult.json)")
        let resultCode = Int(standardCheckoutResult.json["resultCode"] as? String ?? "0")
        let message = standardCheckoutResult.json["resultDescription"] as? String
        
        if resultCode == 00001{
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){_ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Failed", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){_ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func onFail(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

