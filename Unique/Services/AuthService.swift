//
//  AuthService.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()  //singleton. ai tot timpul acces la ea
    
    func registerUser(withEmail email: String, andPassword password:String, userCreationComplete: @escaping (_ status: Bool,_ error: Error? )->() ) { //handler escaping. un fel de lambda. cu status vedem ce se intampla, daca e inregistrat sau nu
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            //daca e returnat un user creem, daca nu ne vedem de erori
            
            guard let user = user else {
                userCreationComplete(false, error) //inseamna ca nu a fost creat
                return
            }
            //aici avem valoare la user
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUSER(uid: user.uid , userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password:String, loginComplete: @escaping (_ status: Bool,_ error: Error? )->() ) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false,error)
                return
            }
            loginComplete(true, nil)
            print("Suciu: Login cu succes!")
        }
    }
    
}
