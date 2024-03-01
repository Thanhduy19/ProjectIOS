//
//  DetailPersonCollectionController.swift
//  CoreData_App
//
//  Created by Macbook on 04/04/2023.
//

import UIKit
import CoreData

class DetailPersonCollectionController: UIViewController {

    @IBOutlet weak var imagePersonZoom: UIImageView!
    
    @IBOutlet weak var linkPersonC: UITextField!
    
    @IBOutlet weak var namePersonC: UITextField!
    
    @IBOutlet weak var emailPersonC: UITextField!
    
    
    @IBOutlet weak var phonePersonC: UITextField!
    
    @IBOutlet weak var genderPersonC: UITextField!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet weak var buttonUpdate: UIButton!
    
    var getlinkPersonC = String()
    var getNamePersonC = String()
    var getEmailPersonC = String()
    var getPhonePersonC = String()
    var getGenderPersonC = String()
    var results1: Person?
    var results2 = [Person]()
    var previewImage: ((UIImageView) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        linkPersonC.text = getlinkPersonC
        namePersonC.text = getNamePersonC
        emailPersonC.text = getEmailPersonC
        phonePersonC.text = getPhonePersonC
        genderPersonC.text = getGenderPersonC
        linkPersonC.delegate = self
        clickImage()
        fecth()
        change()
       
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
    func clickImage(){
        let click = UITapGestureRecognizer(target: self, action: #selector(imageChange))
        self.imagePersonZoom.isUserInteractionEnabled = true
        self.imagePersonZoom.addGestureRecognizer(click)
    }
    @objc func imageChange(){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let detais = story.instantiateViewController(withIdentifier: "ShowImageController")
        as! ShowImageController
        
        detais.getLinkZoom = getlinkPersonC
        self.navigationController?.pushViewController(detais, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imagePersonZoom.downloaded(from: getlinkPersonC)
    }
    
    
    
    func change(){
        let emails = emailPersonC.text
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
        let email: String = (self.emailPersonC.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let phone: String = (self.phonePersonC.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if(linkPersonC.text == ""){
            didLogin(inf: "Link image can not empty!")
            return false
        } else if (namePersonC.text == ""){
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
        if (genderPersonC.text == ""){
            didLogin(inf: "Gender is not empty")
            return false
        }
        
        return true
    }
    func checkInputUpdate() -> Bool{
        let email: String = (self.emailPersonC.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let phone: String = (self.phonePersonC.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if(linkPersonC.text == ""){
            didLogin(inf: "Link image can not empty!")
            return false
        } else if (namePersonC.text == ""){
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
        if (genderPersonC.text == ""){
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
            var name = self.namePersonC.text
            var email = self.emailPersonC.text
            var phone = self.phonePersonC.text
            var gender = self.genderPersonC.text
            var linkAvt = self.linkPersonC.text

            fetchRequest.predicate = NSPredicate(format: "email == %@", email!)
            do {
                
                let results = try context.fetch(fetchRequest)
                if (results.count > 0){

                    for result1 in results{
                        var check = results2.filter {
                            $0.phone == phonePersonC.text
                        }
                        var check1 = results.filter {
                            $0.phone == phonePersonC.text
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
    
    
    @IBAction func addButton(_ sender: UIButton) {
        if (checkInput()){
            let model = Person(context: context)
            model.links = linkPersonC.text
            model.name = namePersonC.text
            model.email = emailPersonC.text
            model.phone = phonePersonC.text
            model.gender = genderPersonC.text
            saveContext()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        if(checkInputUpdate()){
            updatePerson()
        }
    }
    
    
}
extension DetailPersonCollectionController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        imagePersonZoom.downloaded(from: linkPersonC.text ?? "")
        return true
    }
    
}
