//
//  AuthViewController.swift
//  iOS-test-wnfx
//
//  Created by Владислав Шушпанов on 17.08.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    let networkManeger = NetworkManager()
    let validation = Validation()
    let toast = Toast()

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func authButton(_ sender: UIButton) {
        
        if !textFieldIsValid()  {
            return
        }
        
        let url = "http://94.127.67.113:8099/checkLogin"
        
        let userData = ["email": String(describing: email.text!), "password": String(describing: password.text!)]
        
        networkManeger.postRequest(url: url, data: userData) { status in
            if status == 200 {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "secondSegue", sender: nil)
                }
            } else {
                self.toast.showToast(message: "Ошибка при авторизации \(status)")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textFieldIsValid() -> Bool {

        let emailIsValid = validation.tFIsValid(email)
        let passwordIsValid = validation.tFIsValid(password)
        let isSimpleEmail = validation.isSimpleEmail(email.text!)
        if isSimpleEmail {
            email.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        return emailIsValid &&
            passwordIsValid &&
            isSimpleEmail
    }

}
