//
//  HomeController.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import UIKit
import CoreData

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
, UISearchDisplayDelegate{
    
    
    
    @IBOutlet weak var searchPerson: UISearchBar!
    @IBOutlet weak var tableViewPerson: UITableView!
    
   
    
    var results: [Person] = []
    var datas: [JsonPerson] = []
    
    var ab = LoadJsonPerson()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableViewPerson.delegate = self
        tableViewPerson.dataSource = self
        searchPerson.delegate = self
        tableViewPerson.register(UINib(nibName: PersonCell.className, bundle: nil), forCellReuseIdentifier: PersonCell.className)
        
        fecth()
        json()
        tableViewPerson.reloadData()
        // self.deleteAllData("Person")
        
        
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validatePhone(_ value: String) -> Bool {
        let PHONE_REGEX = "^0+\\d{3}\\d{3}\\d{3}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    private func didLogin(inf: String){
        let mess = inf
        let alert = UIAlertController(title: "Error", message: mess, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func json(){
        if (results.count <= 0){
            if (datas.count > 0){
                for data in datas {
                    var checkPhone = results.filter {
                        $0.phone == data.phone
                    }
                    var checkEmail = results.filter {
                        $0.email == data.email
                    }
                    if (checkEmail.isEmpty){
                        if (isValidEmail(data.email!)){
                        if(checkPhone.isEmpty){
                                if(validatePhone(data.phone!)){
                                    let person = Person(context: context)
                                    person.name = data.name
                                    person.email = data.email
                                    person.phone = data.phone
                                    person.gender = data.gender
                                    person.links = data.links
                                    saveContext()
                                    fecth()
                                } else {
                                    didLogin(inf: "Please check format phone of \(data.name!) in file Json")
                                }
                            }else {
                                
                                didLogin(inf: "Phone of \(data.name!) already exists in file Json")
                            }
                        } else{
                            
                            didLogin(inf: "Please check format email of \(data.name!) in file Json")
                        }
                    } else {
                        
                        didLogin(inf: "Email of \(data.name!) already exists in file Json")
                    }
                }
                }
        } else {
            if (datas.count > 0){
                for data in datas {
                    var check = results.filter {
                        $0.email == data.email
                    }
                    var checks = results.filter {
                        $0.phone == data.phone
                    }
                    if(isValidEmail(data.email!)){
                        if (check.isEmpty){
                            if (validatePhone(data.phone!)){
                                if(checks.isEmpty){
                                    let person = Person(context: context)
                                    person.name = data.name
                                    person.email = data.email
                                    person.phone = data.phone
                                    person.gender = data.gender
                                    person.links = data.links
                                    saveContext()
                                    fecth()
                                } else {
                                    //didLogin(inf: "Phone of \(data.name!) already exists in file Json")
                                }
                            } else {
                                didLogin(inf: "Please check format phone of \(data.name!) in file Json")
                            }
                        } else {
                          //  didLogin(inf: "Email of \(data.name!) already exists in file Json")
                        }
                    } else {
                        didLogin(inf: "Please check format email of \(data.name!) in file Json")
                    }
                }
            }
        }
    }
    
    @IBAction func buttonAddPerson(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPersonController") as? DetailPersonController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       // tableViewPerson.isEditing = !tableViewPerson.isEditing
    }
    @IBAction func buttonEdit(_ sender: UIButton) {
        
        tableViewPerson.isEditing = !tableViewPerson.isEditing
        tableViewPerson.reloadData()
        self.tableViewPerson.allowsMultipleSelectionDuringEditing = true
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tableViewPerson.dequeueReusableCell(withIdentifier: PersonCell.className, for: indexPath) as! PersonCell
        
        cells.labelNumber.text = "\(indexPath.row + 1)"
        
        let rslt = results[indexPath.row]
         cells.avatarPerSon.downloaded(from: rslt.links ?? "")
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 3
        
        
        var test = rslt.phone
        
//        let mang = test.words.map { number in
//            return numberFormatter.string(from: number as NSNumber)
//        }
        let numbr = NSNumber(value: Int(test ?? "") ?? 0)
        numberFormatter.string(from: numbr)
        let check = numberFormatter.string(from: numbr)
        
        cells.namePerson.text = "\(check ?? "")"
         cells.emailPerson.text = rslt.email
         cells.phonePerson.text = rslt.phone
        
         return cells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveRow = results[sourceIndexPath.row]
        results.remove(at: sourceIndexPath.row)
        results.insert(moveRow, at: destinationIndexPath.row)
        tableViewPerson.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let detais = story.instantiateViewController(withIdentifier: "DetailPersonController")
        as! DetailPersonController
        
        let push = results[indexPath.row]
        detais.getavater = push.links ?? ""
        detais.getName = push.name ?? ""
        detais.getmail = push.email ?? ""
        detais.getphone = push.phone ?? ""
        detais.getgender = push.gender ?? ""
        self.navigationController?.pushViewController(detais, animated: true)
    }
    
    private func deletes(person: Person, indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Are you sure delete ", preferredStyle: .alert)
        
        let del = UIAlertAction(title: "Yes", style: .default) { [self] (action) in
            self.context.delete(self.results[indexPath.row])
            saveContext()
            self.fecth()
            tableViewPerson.deleteRows(at: [indexPath], with: .automatic)
            tableViewPerson.reloadData()
            
        }
        let cancle = UIAlertAction(title: "No", style: .default, handler:  nil)
        alert.addAction(del)
        alert.addAction(cancle)
        present(alert, animated: true)
        //let wipe = UISwipeActionsConfiguration(actions: [alert])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletes(person: results[indexPath.row], indexPath: indexPath)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
            fecth()
            tableViewPerson.reloadData()
  
    }
    func fecth(){
        let res = NSFetchRequest<Person>(entityName: "Person")
            do {
                results = try context.fetch(res)
            }
            catch {
                print(error)
            }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
                var predicate: NSPredicate = NSPredicate()
                predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let managedObjectContext = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<Person>(entityName:"Person")
                fetchRequest.predicate = predicate
                do {
                    results = try managedObjectContext.fetch(fetchRequest)
                } catch let error as NSError {
                    print("Could not fetch. \(error)")
                }
        } else {
            fecth()
                tableViewPerson.reloadData()
        }
            tableViewPerson.reloadData()
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

