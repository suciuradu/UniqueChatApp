//
//  CreatePostVC.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        sendBtn.bindToKeyboard() //cand se incarca viewul, butonul de send va fi tot timpul legat de tastatura si de view
        //uibutton, uiimagine toate astea vin de la uiview si de asta putem sa atribuim functiile astea la orice uiview sibling

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameLbl.text = Auth.auth().currentUser?.email
    }

    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here..." {
            sendBtn.isEnabled = false //il apasam o singura data si apoi e disabled. sa nu putem apasa de o mie de ori send la informatie
            
            //apelam functia din data service care pune postul in baza de date
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("Suciu: Error to post!")
                }
            })
        }
    }
    
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreatePostVC: UITextViewDelegate { //cand incepem sa scriem, dispare "placeholderul"
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}





