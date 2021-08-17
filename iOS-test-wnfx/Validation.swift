//
//  Validation.swift
//  iOS-test-wnfx
//
//  Created by Владислав Шушпанов on 17.08.2021.
//

import Foundation
import UIKit

class Validation {
    func tFIsValid(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.isEmpty {
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            return false
        }
        return true
    }
    func passwordConcide(_ password: UITextField, _ passwordConfirm: UITextField) -> Bool {
        guard let password = password.text, let passwordConfirm = passwordConfirm.text else {
            return false
        }
        return password == passwordConfirm
    }

    func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }

    func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}


