//
//  DetailPersonController.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import UIKit
import CoreData

class DetailPersonController: UIViewController {

    
    @IBOutlet weak var imagePersonDetail: UIImageView!
    
    
    @IBOutlet weak var linkPersonDetail: UILabel!
    
    @IBOutlet weak var linkPersonTextView: UITextField!
    
    @IBOutlet weak var namePersonDetail: UILabel!
    
    @IBOutlet weak var namePersonTextField: UITextField!
    
    @IBOutlet weak var emailPersonDetail: UILabel!
    
    @IBOutlet weak var emailPersonTextField: UITextField!
    
    @IBOutlet weak var phonePersonDetail: UILabel!
    
    @IBOutlet weak var phonePersonTextField: UITextField!
    
    @IBOutlet weak var genderPersonDetail: UILabel!
    
    @IBOutlet weak var genderPersonTextField: UITextField!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    
    @IBOutlet weak var buttonUpdate: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var getName = String()
    var getmail = String()
    var getphone = String()
    var getgender = String()
    var getavater = String()
    var getimage = UIImage()
    
    var results1: Person?
    var results2 = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        imagePersonDetail.makeRounded()
        linkPersonTextView.text = getavater
        namePersonTextField.text = getName
        emailPersonTextField.text = getmail
        phonePersonTextField.text = getphone
        genderPersonTextField.text = getgender
        change()
        setUp()
        linkPersonTextView.delegate = self
        fecth()
        imagePersonDetail.downloaded(from: linkPersonTextView.text ?? "")
    }
    func fecth(){
        let res = NSFetchRequest<Person>(entityName: "Person")
        do {
            results2 = try context.fetch(res)
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    func setUp(){
        linkPersonDetail.text = "URL"
        linkPersonTextView.placeholder = "Url"
        
        namePersonDetail.text = "Name"
        namePersonTextField.placeholder = "Enter name"
        
        emailPersonDetail.text = "Email"
        emailPersonTextField.placeholder = "Enter email"
        
        phonePersonDetail.text = "Phone"
        phonePersonTextField.placeholder = "Enter phone"
        
        genderPersonDetail.text = "Gender"
        genderPersonTextField.placeholder = "Enter gender"
        
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.backgroundColor = .blue
        buttonSave.layer.cornerRadius = 10
        
        buttonUpdate.setTitle("Update", for: .normal)
        buttonUpdate.backgroundColor = .blue
        buttonUpdate.layer.cornerRadius = 10
    }
    
    func change(){
        let emails = emailPersonTextField.text
        results1?.setValue(emails, forKey: "email")
        if emails != "" {
            buttonSave.isHidden = true
        } else {
            buttonUpdate.isHidden = true
        }
    }
    
    func validatePhone(_ value: String) -> Bool {
        let PHONE_REGEX = "^0+\\d{3}\\d{3}\\d{3}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkInput() -> Bool{
        let email: String = (self.emailPersonTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let phone: String = (self.phonePersonTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if(linkPersonTextView.text == ""){
            didLogin(inf: "Link image can not empty!")
            return false
        } else if (namePersonTextField.text == ""){
            didLogin(inf: "Name can not empty!")
            return false
        }else if (email == ""){
            didLogin(inf: "Please enter phone with format example@gmail.com")
            return false
        }else if(email != ""){
            for rls in results2 {
                if rls.email == email {
                    didLogin(inf: "Email already exists")
                    return false
                } else if (!isValidEmail(email)){
                    didLogin(inf: "Please enter email with format example@gmail.com")
                    return false
                }
            }
        }
        if (phone == ""){
            didLogin(inf: "Phone can not empty!")
            return false
        } else if(phone != ""){
                for rls in results2 {
                    if rls.phone == phone {
                        didLogin(inf: "Phone already exists")
                        return false
                    } else if (!validatePhone(phone)){
                        didLogin(inf: "Please enter phone with 0xxxxxxxxx")
                        return false
                    }
                }
            }
        if (genderPersonTextField.text == ""){
            didLogin(inf: "Gender is not empty")
            return false
        }
        
        return true
    }
    func checkInputUpdate() -> Bool{
        let email: String = (self.emailPersonTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let phone: String = (self.phonePersonTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if(linkPersonTextView.text == ""){
            didLogin(inf: "Link image can not empty!")
            return false
        } else if (namePersonTextField.text == ""){
            didLogin(inf: "Name can not empty!")
            return false
        }else if (email == ""){
            didLogin(inf: "Please enter phone with format example@gmail.com")
            return false
        }else if (phone == ""){
            didLogin(inf: "Phone can not empty!")
            return false
        }
        if (phone != ""){
            if (!validatePhone(phone)){
                didLogin(inf: "Please enter phone with 0xxxxxxxxx")
                return false
            }}
        if (genderPersonTextField.text == ""){
            didLogin(inf: "Gender is not empty")
            return false
        }
        
        return true
    }
    
    private func didLogin(inf: String){
        let mess = inf
        let alert = UIAlertController(title: "Error", message: mess, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updatePerson(){
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            
            let context = container.viewContext
            let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
            var name = self.namePersonTextField.text
            var email = self.emailPersonTextField.text
            var phone = self.phonePersonTextField.text
            var gender = self.genderPersonTextField.text
            var linkAvt = self.linkPersonTextView.text

            fetchRequest.predicate = NSPredicate(format: "email == %@", email!)
            do {
                
                let results = try context.fetch(fetchRequest)
                if (results.count > 0){

                    for result1 in results{
                        var check = results2.filter {
                            $0.phone == phonePersonTextField.text
                        }
                        var check1 = results.filter {
                            $0.phone == phonePersonTextField.text
                        }
                        if(check1 == check){
                            result1.setValue(name, forKey: "name")
                            result1.setValue(phone, forKey: "phone")
                            result1.setValue(linkAvt, forKey: "links")
                            result1.setValue(gender, forKey: "gender")
                            name = result1.name
                            phone = result1.phone
                            linkAvt = result1.links
                            gender = result1.gender
                        } else {
                            didLogin(inf: "Phone already exists")
                            return
                        }
                    }
                    try context.save()
                }
                
            }catch let error {
                
                print("Error....: \(error)")
                
            }
            
        }
    }
//    override func viewWillDisappear(_ animated: Bool) {
//            if(namePersonTextField.text == ""){
//                namePersonTextField.text = "1"
//            }
//
//    }
    
    @IBAction func clickButtonSave(_ sender: UIButton) {
        
        if(checkInput()){
            let model = Person(context: context)
            model.links = linkPersonTextView.text
            model.name = namePersonTextField.text
            model.email = emailPersonTextField.text
            model.phone = phonePersonTextField.text
            model.gender = genderPersonTextField.text
            saveContext()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clickButtonUpdate(_ sender: UIButton) {
        if (checkInputUpdate()){
            updatePerson()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
//    @IBAction func buttonBackHome(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



//extension DetailPersonController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        imagePersonDetail.downloaded(from: linkPersonTextView.text ?? "")
//        return true
//    }
//}
extension DetailPersonController: UITextFieldDelegate {
//    func textFieldDidChangeSelection(_ textField: UITextField){
//            textField.resignFirstResponder()
//            imagePersonDetail.downloaded(from: linkPersonTextView.text ?? "")
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        imagePersonDetail.downloaded(from: linkPersonTextView.text ?? "")
        return true
    }
//        func textFieldDidEndEditing(_ textField: UITextField){
//                textField.resignFirstResponder()
//                imagePersonDetail.downloaded(from: linkPersonTextView.text ?? "")
//        }
    
}
extension UIImageView {
    
    func makeRounded() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
