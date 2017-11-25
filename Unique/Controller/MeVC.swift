//
//  MeVC.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) { //imi pune emailul in loc de "_username"
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    
    @IBAction func signOutBtnPressed(_ sender: Any) { //animatii care imi apar de jos daca sunt sigur ca vreau as ma delogez, si daca vreau fac delogarea
        let logOutPop = UIAlertController (title: "Logout?", message: "Are you sure you wanna leave?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonPressed) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
                //daca reuseste sign out, instantiem loginVC si apoi il prezentam peste orice am fost inainte (adica peste meVC)
            } catch {
                print("Suciu: ",error)
            }
        }
        logOutPop.addAction(logOutAction)
        present(logOutPop, animated: true, completion: nil)
    }
    
}
