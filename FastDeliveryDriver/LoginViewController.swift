//
//  LoginViewController.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 07/02/2024.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var driver: Driver?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tfEmail.placeholder = String(format: NSLocalizedString("home.email", comment: ""))
        tfPassword.placeholder = String(format: NSLocalizedString("home.password", comment: ""))
        btnLogin.titleLabel?.text = String(format: NSLocalizedString("home.main_button", comment: ""))
    }
    
    @IBAction func onLoginRequest(_ sender: Any) {
        guard let _email = tfEmail.text,
              let _password = tfPassword.text else {
            return
        }
                
        DriverWebService.login(email: _email, password: _password, completion: { driver, err in
            if (err != nil) {
                print("Login::onLoginRequest error : \(err)")
                DispatchQueue.main.async {
                    showToast(view: self.view, message: NSLocalizedString("error_login", comment: ""))
                }
                return
            }
            
            DispatchQueue.main.async {
                self.driver = driver
                let homeViewController = HomeViewController.newInstance(driver: driver!)
                self.navigationController?.setViewControllers([homeViewController], animated: false)
            }
        })
    }    
}
