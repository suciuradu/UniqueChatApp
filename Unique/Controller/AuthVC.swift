//
//  AuthVC.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func emailBtnPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func googleBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
    }
}
