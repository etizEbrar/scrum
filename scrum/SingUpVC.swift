//
//  SıngUpVC.swift
//  scrum
//
//  Created by Ebrar Etiz on 30.05.2023.
//

import UIKit
import Parse

class SingUpVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var adressTextField: UITextField!
    
    @IBOutlet weak var usertypeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        guard let name = nameTextField.text,
                 let username = usernameTextField.text,
                 let password = passwordTextField.text,
                 let id = idTextField.text,
                 let number = numberTextField.text,
                 let email = emailTextField.text,
                 let address = adressTextField.text,
                 let userType = usertypeTextField.text
           else {
               return
           }
           
           let user = PFUser()
           user["name"] = name
           user.username = username
           user.password = password
           user["id"] = id
           user["phoneNumber"] = number
           user.email = email
           user["addresd"] = address
           user["userType"] = userType
           
           user.signUpInBackground { (success, error) in
               if let error = error {
                   print("Kullanıcı oluşturulurken bir hata oluştu: \(error.localizedDescription)")
               } else {
                   print("Kullanıcı başarıyla oluşturuldu.")
               }
           }
        
    }
    
 

}
