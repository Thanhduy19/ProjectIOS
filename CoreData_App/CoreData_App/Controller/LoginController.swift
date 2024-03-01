//
//  LoginController.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import UIKit
import CoreData

class LoginController: UIViewController {

    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBOutlet weak var buttonRegister: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var results = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
       // self.deleteAllData("Users")
        fecth()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkKeys)))
    }
    @objc private func checkKeys(){
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fecth()
        emailTextField.text = ""
        passwordTextFiled.text = ""
    }
    
    func fecth(){
        let res = NSFetchRequest<Users>(entityName: "Users")
            do {
                results = try context.fetch(res)
            }
            catch {
                print(error)
            }
        
    }
    
    func setUp(){
        loginLabel.text = "Login"
        
        emailLabel.text = "Email"
        emailTextField.placeholder = "Enter email"
        emailTextField.layer.cornerRadius = 10
        
        passwordLabel.text = "Password"
        passwordTextFiled.placeholder = "Enter password"
        passwordTextFiled.layer.cornerRadius = 10
        
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = .blue
        buttonLogin.layer.cornerRadius = 10
        buttonLogin.setTitleColor(.white, for: .normal)
        
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = .blue
        buttonRegister.layer.cornerRadius = 10
        buttonRegister.setTitleColor(.white, for: .normal)
        
        
    }
    
    
    
    func toHome(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeController")
            as? HomeController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickButtonLogin(_ sender: UIButton) {
        guard let emails = emailTextField.text, let passwords = passwordTextFiled.text else {
            return
        }
        loadUsers(email: emails, passwords: passwords)
   
        //toHome()
        
      //  self.performSegue(withIdentifier: "mySegueIdentifier", sender: nil)

    }
    
    @IBAction func buttonShowPass(_ sender: UIButton) {
        if (passwordTextFiled.isSecureTextEntry) {
            let imagess = UIImage(systemName: "eye.fill")
            sender.setImage(imagess, for: .normal)
            passwordTextFiled.isSecureTextEntry = false
        }
        else {
            let images = UIImage(systemName: "eye.slash.fill")
            sender.setImage(images, for: .normal)
            passwordTextFiled.isSecureTextEntry = true
        }
    }
    
    
    
    @IBAction func clickButtonRegister(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterController")
            as? RegisterController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    func loadUsers(email: String, passwords: String){
        var checkEmail = results.filter{
            $0.email == emailTextField.text
        }
        var checkPassword = results.filter{
            $0.pass == passwordTextFiled.text
        }
        for test in results {
            if(checkEmail.isEmpty || checkPassword.isEmpty){
                didLogin(inf: "Please enter email or password agains")
            } else if (email == test.email && passwords == test.pass){
                self.performSegue(withIdentifier: "mySegueIdentifier", sender: nil)
            }
        }

    }
    private func didLogin(inf: String){
        let mess = inf
        let alert = UIAlertController(title: "Error", message: mess, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
