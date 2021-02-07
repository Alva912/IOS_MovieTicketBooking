//
//  SignUpViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name_TextField: UITextField!
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var password_TextField: UITextField!
    @IBOutlet weak var confirmPassword_TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func SignUp_Action(_ sender: UIButton) {
        
        if !(name_TextField.text?.count ?? 0 > 0) {
            showMessageAlter(title: "Please fill in the full name information", actionTitle: "ok")
            return
        }
        
        if !(email_TextField.text?.count ?? 0 > 0) {
            showMessageAlter(title: "Please fill in the email information", actionTitle: "ok")
            return
        }
        
        if !(password_TextField.text?.count ?? 0 > 0) {
            showMessageAlter(title: "Please fill in the password information", actionTitle: "ok")
            return
        }
        
        if !(confirmPassword_TextField.text?.count ?? 0 > 0) {
            showMessageAlter(title: "Please fill in the retry password information", actionTitle: "ok")
            return
        }
        
        if password_TextField.text != confirmPassword_TextField.text {
            showMessageAlter(title: "Passwords do not match", actionTitle: "ok")
            return
        }
        
        UserDefaults.standard.set(password_TextField.text ?? "", forKey: email_TextField.text ?? "")
        UserDefaults.standard.set(true, forKey: "isLoginStatus")
        UserDefaults.standard.set(email_TextField.text, forKey: "loginEmailAccount")
        UserDefaults.standard.synchronize()
        showConfirmAlert()
        
    }
    
    func showConfirmAlert() {
        let alertController = UIAlertController(title: "Successful !", message: "Your created account:\n \(email_TextField.text ?? "")\n Your name:\n \(name_TextField.text ?? "")", preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(title: "confirm", style: .default) { (action: UIAlertAction!) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showMessageAlter(title: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: false, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
