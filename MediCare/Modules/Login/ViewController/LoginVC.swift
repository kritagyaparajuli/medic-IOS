//
//  ViewController.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/27/22.
//

import UIKit
import Lottie
import TransitionButton
import IBAnimatable



class LoginVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var btnLogin: TransitionButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var btnShowPass: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    // MARK: - Constants and variables
    
    // MARK: - ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarConfig()
        animationViewConfig()
        configureTextField()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBAction Functions
    @IBAction func btnLogin(_ sender: Any) {
        btnLogin.startAnimation()
        self.disableUserInteraction()
        if isloginValid(){
            loginApiCall(username: emailTextField.text ?? "", password: passTextField.text ?? "")
        }
    }
    @IBAction func btnShowPass(_ sender: Any) {
        btnShowPass.isSelected = !btnShowPass.isSelected
        self.passTextField.isSecureTextEntry = !self.passTextField.isSecureTextEntry
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
    }
    
    // MARK: - Additional Functions
    
    func navBarConfig(){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.btnLogin.layer.zPosition = 999
    }
    
    func animationViewConfig(){
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        animationView.backgroundBehavior = .pauseAndRestore
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField{
            UIView.animate(withDuration: 0.3, delay: 0.0,
                           options: [.curveEaseInOut, .allowUserInteraction],
                           animations: {
                            self.emailTextField.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
                           }, completion: nil)
            
            
            
            
        }
        else{
            UIView.animate(withDuration: 0.3, delay: 0.0,
                           options: [.curveEaseInOut, .allowUserInteraction],
                           animations: {
                            self.passTextField.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
                           }, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.emailTextField.backgroundColor = UIColor.systemBackground
                        self.passTextField.backgroundColor = UIColor.systemBackground
                       }, completion: nil)
        self.emailTextField.layer.borderColor =  UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        self.passTextField.layer.borderColor =  UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passTextField.becomeFirstResponder()
            return true
        }
        else if textField == passTextField && passTextField.text == ""{
            emailTextField.resignFirstResponder()
            passTextField.becomeFirstResponder()
            return true
        }
        else if textField == passTextField && emailTextField.text == ""{
            passTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        }else{
            btnLogin(btnLogin!)
        }
        return false
    }
    
    
    
    
    fileprivate func isloginValid() -> Bool {
        if emailTextField.text == ""{
            self.btnLogin.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.1)
            enableUserInteraction()
            emailTextField.layer.borderColor = UIColor(named: "BloodRed")?.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.masksToBounds = true
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Email required",attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "BloodRed") ?? .red, NSAttributedString.Key.font :UIFont(name: "Inter", size: 16)!])
            
            
            return false
        }
        else if passTextField.text == ""{
            self.btnLogin.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.1)
            enableUserInteraction()
            passTextField.attributedPlaceholder = NSAttributedString(string: "Password required",attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "BloodRed") ?? .green, NSAttributedString.Key.font :UIFont(name: "Inter", size: 16)!])
            passTextField.layer.borderColor = UIColor(named: "BloodRed")?.cgColor
            passTextField.layer.borderWidth = 1.0
            passTextField.layer.masksToBounds = true
            return false
        }
        return true
        
    }
    
    func disableUserInteraction() {
        emailTextField.isUserInteractionEnabled = false
        passTextField.isUserInteractionEnabled = false
        btnForgotPassword.isUserInteractionEnabled = false
        btnRegister.isUserInteractionEnabled = false
    }
    
    func enableUserInteraction() {
        emailTextField.isUserInteractionEnabled = true
        passTextField.isUserInteractionEnabled = true
        btnForgotPassword.isUserInteractionEnabled = true
        btnRegister.isUserInteractionEnabled = true
        
    }
    func configureTextField() {
        emailTextField.isLoginTextField(placeholder: "Username")
        passTextField.isLoginTextField(placeholder: "Password")
        
        
    }
}


extension LoginVC{
    private func loginApiCall(username: String, password: String){
        LoginViewModel().requestForLogin(Username: username, Password: password) { apiResponse in
            print(apiResponse)
            if (apiResponse.status!){
                let token = apiResponse.data?.token ?? ""
                UserDefaultManager.shared.accessToken = token
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                print("LOGIN_ACCESS_TOKEN ::: \(token)")
                self.btnLogin.stopAnimation(animationStyle: .expand, revertAfterDelay: 0.5) {
                    let tabBarVC = CustomTabBarController()
                    let navController = UINavigationController(rootViewController: tabBarVC)
                    navController.modalPresentationStyle = .overFullScreen
                    navController.modalTransitionStyle = .crossDissolve
                    self.present(navController, animated: true)
                }
            }
            else{
                self.btnLogin.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5) {
                    self.enableUserInteraction()
                    let alert = UIAlertController(title: "Oops Something doesnt seem right!", message: apiResponse.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
            }
        } fail: { msg in
            self.btnLogin.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5) {
                self.enableUserInteraction()
                let alert = UIAlertController(title: "Server Not Responding!", message: "Please Try Again Later..", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
}



