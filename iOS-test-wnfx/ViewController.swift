//
//  ViewController.swift
//  iOS-test-wnfx
//
//  Created by Владислав Шушпанов on 17.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManeger = NetworkManager()
    let validation = Validation()
    let toast = Toast()

    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!

    @IBAction func showPassword(_ sender: UIButton) {
        password.isSecureTextEntry = false
        passwordConfirm.isSecureTextEntry = false
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        if !textFieldIsValid()  {
            return
        }
        
        let url = "http://94.127.67.113:8099/registerUser"
        
        let userData = ["email": String(describing: email.text!), "surname": String(describing: surname.text!), "firstname": String(describing: firstname.text!), "lastname": String(describing: lastname.text!), "password": String(describing: password.text!)]
        
        networkManeger.postRequest(url: url, data: userData) { status in
            if status == 200 {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "detailSegue", sender: nil)
                }
            } else {
                self.toast.showToast(message: "Ошибка при регистрации \(status)")

            }
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textFieldIsValid() -> Bool {
        
        let surnameIsValid = validation.tFIsValid(surname)
        let firstnameIsValid = validation.tFIsValid(firstname)
        let lastnameIsValid = validation.tFIsValid(lastname)
        let emailIsValid = validation.tFIsValid(email)
        let passwordIsValid = validation.tFIsValid(password)
        let passwordConfirmIsValid = validation.tFIsValid(passwordConfirm)
        let passwordConcide = validation.passwordConcide(password, passwordConfirm)
        let isSimpleEmail = validation.isSimpleEmail(email.text!)
        if !isSimpleEmail {
            self.email.layer.borderWidth = 1
            self.email.layer.cornerRadius = 5
            self.email.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        return surnameIsValid &&
            firstnameIsValid &&
            lastnameIsValid &&
            emailIsValid &&
            passwordIsValid &&
            passwordConfirmIsValid &&
            passwordConcide &&
            isSimpleEmail
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
