//
//  DataService.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()   //va accesa baza de date . base url pentru baza . accesibil in clasa

class DataService { //singleton class care e accesibila pentru orice clasa din aplicatie
    
    static let instance = DataService()   //o instanta a clasei. singleton
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")    //asa creem copilul user. daca nu exista, il creeaza, daca exsita nu
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE : DatabaseReference! {
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference! {
        return _REF_USERS
    }
    
    var REF_GROUPS : DatabaseReference! {
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference! {
        return _REF_FEED
    }
    
    func createDBUSER(uid: String, userData: Dictionary<String,Any>) { // uid = unique identifier
        REF_USERS.child(uid).updateChildValues(userData)    //in userul cu acel uid, punem tot userData (email,USERNAMEpoate, etc)
    }
    
    func uploadPost(withMessage message: String, forUID uid:String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool)->()) {
        if groupKey != nil {
            //trimitem in firebase la groups
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
        }
        
    }
    
}













