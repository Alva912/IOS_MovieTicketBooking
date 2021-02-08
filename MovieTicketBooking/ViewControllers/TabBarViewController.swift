//
//  TabBarViewController.swift
//  MovieTicketBooking
//
//  Created by JiakangLi on 2021/2/7.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLoginStatus), name:NSNotification.Name(rawValue: "UpdateLoginStatus"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: "isLoginStatus") {
            print("Not Login Status")
            performSegue(withIdentifier: "presentLoginVC", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    @objc func updateLoginStatus() {
        if !UserDefaults.standard.bool(forKey: "isLoginStatus") {
            print("Not Login Status")
            performSegue(withIdentifier: "presentLoginVC", sender: nil)
        }
    }

}
