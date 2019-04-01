//
//  Settings.swift
//  McCollins
//
//  Created by Noh Tewolde on 4/1/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class Settings: UIViewController {

    var userID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground")!)
    }

    @IBAction func userProfile(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Update") as? Update
        vc?.userEmail
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Login") as? Login
//        navigationController?.popToViewController(vc!, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
