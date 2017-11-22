//
//  LogInVC.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class LogInVC: UIViewController{

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
    }

   
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil { //daca s-a mai logat, il logam direct, daca nu AICI AR TREBUI SA II LUAM USERNAME dupa ce il inregistram
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (succes, logInError) in
                if succes { //daca ne-am logat cu succes
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Suciu: \(logInError?.localizedDescription)")
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (succes, registrationError) in
                    if succes { //daca i-am inregistrat cu succes urmeaza sa ii logam
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (succes, nil) in
                            print("Suciu: Successfuly registered user!")
                            self.dismiss(animated: true, completion: nil)

                        })
                    } else {
                        print("Suciu: \(registrationError?.localizedDescription)")
                    }
                })
                
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LogInVC: UITextFieldDelegate { }
