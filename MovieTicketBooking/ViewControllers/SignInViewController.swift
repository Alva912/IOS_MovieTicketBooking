//
//  SignInViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var password_TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    @IBAction func SignIn_Action(_ sender: UIButton) {
        view.endEditing(true)
        
        if email_TextField.text?.count ?? 0 == 0 {
            showMessageAlter(title: "Please type in your email", actionTitle: "Ok")
            return
        }
        if password_TextField.text?.count ?? 0 == 0 {
            showMessageAlter(title: "Please type in your password", actionTitle: "Ok")
            return
        }
        
        let password = UserDefaults.standard.string(forKey: email_TextField.text ?? "")
        if password != password_TextField.text {
            showMessageAlter(title: "Wrong email or password", actionTitle: "Ok")
            return
        }
        UserDefaults.standard.set(true, forKey: "isLoginStatus")
        UserDefaults.standard.set(email_TextField.text, forKey: "loginEmailAccount")
        UserDefaults.standard.synchronize()
        showConfirmAlert()
    }
    
    func showConfirmAlert() {
        let alertController = UIAlertController(title: "Successful !", message: "Your login account:\n \(email_TextField.text ?? "")", preferredStyle: UIAlertController.Style.alert)
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
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
