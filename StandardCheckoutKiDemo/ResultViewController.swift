//
//  ResultViewController.swift
//  StandardCheckoutKiDemo
//
//  Created by Savitha on 8/14/17.
//  Copyright © 2017 Paymentz. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var standardCheckoutResult: String?
    @IBOutlet weak var labelResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelResult.text = standardCheckoutResult
    }
    
    @IBAction func closeNavigationButton(_ sender: UIBarButtonItem) {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let viewNavigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        self.present(viewNavigationController, animated: true, completion: nil)
    }

}
