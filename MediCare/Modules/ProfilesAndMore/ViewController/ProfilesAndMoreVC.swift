//
//  ProfilesAndMoreVC.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/29/22.
//

import UIKit

class ProfilesAndMoreVC: UIViewController {

    @IBOutlet weak var btnLogOut: UIButton!
       
        // MARK: - Outlets
        
        // MARK: - Constants and variables
        
        // MARK: - ViewController Functions
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
        }
        override func viewWillAppear(_ animated: Bool) {
            
            
        }

// MARK: - IBAction Functions

    @IBAction func btnLogOut(_ sender: Any) {
        let alert = UIAlertController(title: "Logout?", message: "Do you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
            self.navigationController?.dismiss(animated: true, completion: nil)
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
       
        
        
        
    }
    // MARK: - Additional Functions
}
