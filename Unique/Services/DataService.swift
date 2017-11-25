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
    
    func getUsername(forUID uid: String, handler: @escaping(_ username: String) -> () ) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            //downaloadam toti userii si il cautam pe acela care are keya ca si uid si apoi in handler returnam stringul cu emailul
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid:String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool)->()) { //escaping e handler sa vedem ce facem cu informatia
        if groupKey != nil {
            //trimitem in firebase la groups
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages (handler: @escaping (_ messages: [Message])-> () ) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in   //observam tot ce e in "feed", ii downloadam .value si o salvam in snapshot
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return } //acum avem un array de datasnaphot din firebase
            
            //mergem prin tot datasnaphost si adaugam in msgarray
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                let message = Message(content: content, senderID: senderID)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> () ) {  //imi cauta emialurile care contine litera sau literele pe care le scriu in textfield. query e litera sau literele
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {  //daca email contine litere din query si email nu sunt eu, imi pune in array acel email
                    emailArray.append(email)
                }
            }
            handler(emailArray) //ii trimitem arrayul
        }
    }
    
}

































