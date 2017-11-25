//
//  CreateGroupVC.swift
//  Unique
//
//  Created by Suciu Radu on 23/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addPeopleTextField: UITextField!
    
    @IBOutlet weak var addedPeopleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneBtn: UIButton!

    var emailArray = [String]() //array pentru cautat si aratat emailurile pentru grup
    var chosenEmailArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        addPeopleTextField.delegate = self
        addPeopleTextField.addTarget(self, action: #selector(textFieldDidChanged) , for: .editingChanged)  //monitorizam ce se intampla in acest text field
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChanged () {
        if addPeopleTextField.text == "" {  //daca e gol atunci si email array trebuie sa fie gol
            emailArray = []
            tableView.reloadData()
        } else { //daca nu e gol, apelam functia la fiecare schimbare de text din text field si va afisa emailurile care contin literele care le-am scris in text field
            DataService.instance.getEmail(forSearchQuery: addPeopleTextField.text! , handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    

    @IBAction func doneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImg = UIImage(named: "defaultProfileImage")
        if chosenEmailArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImg: profileImg! , email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImg: profileImg! , email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //daca selectez o celula de la index path, fac ce scrie :
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !(chosenEmailArray.contains(cell.emailLbl.text!) ){  //daca nu apartine
            chosenEmailArray.append(cell.emailLbl.text!)
            addedPeopleLbl.text = chosenEmailArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenEmailArray = chosenEmailArray.filter({ $0 != cell.emailLbl.text!  })  //predicat !!!! lamba. ii dam pe toti inafara de cell.emaillbl.text
            if chosenEmailArray.count >= 1 {
                addedPeopleLbl.text = chosenEmailArray.joined(separator: ", ")
            } else {
                addedPeopleLbl.text = "add people"
                doneBtn.isHidden = true
            }
        }

    }
}


extension CreateGroupVC: UITextFieldDelegate {
    
}

























