//
//  RegisterController.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import UIKit
import CoreData

class RegisterController: UIViewController {

    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rePasswordLabel: UILabel!
    
    @IBOutlet weak var rrPasswordTextFiled: UITextField!
    
    @IBOutlet weak var buttonRegister: UIButton!
    
    @IBOutlet weak var passwordCheck: UILabel!
    
    @IBOutlet weak var rePassCheck: UILabel!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setUp()
       
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkKeys)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @objc private func checkKeys(){
        self.view.endEditing(true)
    }
    var count = 0
    @objc private func keyboardWillShow(noti: NSNotification){
        if let keyboard: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            if(count == 0){
                count = 1
                let keybH = keyboard.cgRectValue.height
                let bottom = self.view.frame.height - (buttonRegister.frame.origin.y + buttonRegister.frame.height)
                self.view.frame.origin.y -= keybH - bottom + 10
            }
        }
    }
    @objc private func keyboardWillHide(){
        self.view.frame.origin.y = 0
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUp(){
        registerLabel.text = "Register"
        
        emailLabel.text = "Email"
        emailTextField.placeholder = "Enter email"
        
        passwordLabel.text = "Password"
        passwordTextField.placeholder = "Enter password"
        passwordCheck.text = ""
        
        rePasswordLabel.text = "Confirm Password"
        rrPasswordTextFiled.placeholder = "Enter conform password"
        rePassCheck.text = ""
        
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = .blue
        buttonRegister.setTitleColor(.white, for: .normal)
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkInput() -> Bool{
        let email: String = (self.emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        
        if (!isValidEmail(email)){
            didLogin(inf: "Please enter email with format example@gmail.com")
            return false
        } else if (passwordTextField.text != rrPasswordTextFiled.text){
            didLogin(inf: "Password and Confirm password not equal")
            return false
        }
        return true
    }
//    func validate(value: String) -> Bool {
//        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result = phoneTest.evaluate(with: value)
//        return result
//    }
    func checkLevel() -> Bool{
        
        if (passwordTextField.text!.count) < 6 {
            passwordCheck.text = "Password must be >= 6 characters."
            return false
        }
        else if (passwordTextField.text!.count) >= 6 && (passwordTextField.text!.count) <= 8 {
            passwordCheck.text = "Password weak."
            return true
        } else if (passwordTextField.text!.count) > 8 {
            passwordCheck.text = "Password strong."
            return true
        }
        return true
    }
    
    func checkLevelRePass() -> Bool{
        if (rrPasswordTextFiled.text!.count) < 6 {
            rePassCheck.text = "Password must be >= 6 characters."
            return false
        } else if (rrPasswordTextFiled.text!.count) >= 6 && (rrPasswordTextFiled.text!.count) <= 8 {
            rePassCheck.text = "Password weak."
            return true
        } else if (rrPasswordTextFiled.text!.count) > 8 {
            rePassCheck.text = "Password strong."
            return true
        }
        return true
    }
    
    
    
    @IBAction func buttonShowPass(_ sender: UIButton) {
        if (passwordTextField.isSecureTextEntry) {
            let imagess = UIImage(systemName: "eye.fill")
            sender.setImage(imagess, for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
        else {
            let images = UIImage(systemName: "eye.slash.fill")
            sender.setImage(images, for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func buttonShowRePass(_ sender: UIButton) {
        if (rrPasswordTextFiled.isSecureTextEntry) {
            let imagess = UIImage(systemName: "eye.fill")
            sender.setImage(imagess, for: .normal)
            rrPasswordTextFiled.isSecureTextEntry = false
        }
        else {
            let images = UIImage(systemName: "eye.slash.fill")
            sender.setImage(images, for: .normal)
            rrPasswordTextFiled.isSecureTextEntry = true
        }
    }
    
    private func didLogin(inf: String){
        let mess = inf
        let alert = UIAlertController(title: "Error", message: mess, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func checkStrongPass(_ sender: UITextField) {
        checkLevel()
    }
    
    @IBAction func rePassStrong(_ sender: UITextField) {
        checkLevelRePass()
    }
    
    
    @IBAction func clickButtonRegister(_ sender: UIButton) {
        let authena = Users(context: context)
        if(checkInput()){
            if (checkLevel()){
                authena.email = emailTextField.text
                authena.pass = passwordTextField.text
                saveContext()
                self.navigationController?.popViewController(animated: true)
            }
        }}
    
}
