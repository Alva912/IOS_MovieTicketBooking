//
//  ProfileViewController.swift
//  MovieTicketBooking
//
//  Created by JiakangLi on 2021/2/7.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var outLogin_Btn: UIButton!
    @IBOutlet var login_Btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    func setupViews() {
        if UserDefaults.standard.bool(forKey: "isLoginStatus") {
            outLogin_Btn.isHidden = false
            login_Btn.isHidden = true
        } else {
            outLogin_Btn.isHidden = true
            login_Btn.isHidden = false
        }
    }

    @IBAction func outLogin_Action(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoginStatus")
        UserDefaults.standard.set("", forKey: "loginEmailAccount")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateLoginStatus"), object: nil)
        setupViews()
    }

    @IBAction func login_Action(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateLoginStatus"), object: nil)
    }
}
