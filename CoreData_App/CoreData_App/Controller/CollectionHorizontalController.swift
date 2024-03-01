//
//  CollectionHorizontalController.swift
//  CoreData_App
//
//  Created by Macbook on 05/04/2023.
//

import UIKit
import CoreData

class CollectionHorizontalController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionViewCell: UICollectionView!
    @IBOutlet weak var buttonCheckBox1: UIButton!
    @IBOutlet weak var labelCheckBox1: UILabel!
    @IBOutlet weak var buttonCheckBox2: UIButton!
    @IBOutlet weak var labelCheckBox2: UILabel!
    @IBOutlet weak var labelResults: UILabel!
    @IBOutlet weak var switchChange: UISwitch!
    @IBOutlet weak var buttonClick: UIButton!
    @IBOutlet weak var collection2: UICollectionView!
    
    var results: [Person] = []
    var check = false
    var check2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCell.dataSource = self
        collection2.dataSource = self
        collectionViewCell.delegate = self
        buttonCheckBox1.layer.borderWidth = 1
        buttonCheckBox2.layer.borderWidth = 1
        buttonClick.isEnabled = false
        buttonClick.backgroundColor = .gray
        buttonClick.setTitleColor(.white, for: .normal)
        labelResults.text = "Result: "
        fecth()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection2 {
            return results.count
        }
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCell.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.imageCell.downloaded(from: results[indexPath.row].links ?? "")
        if (collectionView == collection2) {
            let cell2 = collection2.dequeueReusableCell(withReuseIdentifier: "collection2CollectionViewCell", for: indexPath) as! collection2CollectionViewCell
                cell2.labelName2.text = (results[indexPath.row].name ?? "")
                return cell2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let detais = story.instantiateViewController(withIdentifier: "Screen3ViewController")
        as! Screen3ViewController
        self.navigationController?.pushViewController(detais, animated: true)
    }
    
    
    @IBAction func clickButtonCheckBox1(_ sender: UIButton) {
        if (check == false) {
            sender.setBackgroundImage(UIImage(named: "checkboxbutton"), for: .normal)
            if check2 == true {
                labelResults.text! += ", " + (labelCheckBox1.text ?? "")
            } else {
                labelResults.text = "Result: " + (labelCheckBox1.text ?? "")
            }
            check = true
        } else {
            sender.setBackgroundImage((UIImage(named: "")), for: .normal)
            check = false
            if (check == false && check2 == true){
                labelResults.text = "Result: " + (labelCheckBox2.text ?? "")
            } else {
                labelResults.text = "Result: "
            }
        }
        
    }
    
    @IBAction func clickButtonCheckBox2(_ sender: UIButton) {
        if (check2 == false) {
            sender.setBackgroundImage(UIImage(named: "checkboxbutton"), for: .normal)
            if check == true {
                labelResults.text! += ", " + (labelCheckBox2.text ?? "")
            } else {
                labelResults.text = "Result: " + (labelCheckBox2.text ?? "")
            }
            check2 = true
        } else {
            sender.setBackgroundImage((UIImage(named: "")), for: .normal)
            check2 = false
            if (check == true && check2 == false){
                labelResults.text = "Result: " + (labelCheckBox1.text ?? "")
            } else {
                labelResults.text = "Result: "
            }
        }
    }
    
    
    @IBAction func switchButton(_ sender: UISwitch) {
        if sender.isOn {
            buttonClick.backgroundColor = .blue
            buttonClick.tintColor = .white
            buttonClick.isEnabled = true
        } else {
            buttonClick.backgroundColor = .gray
            buttonClick.isEnabled = false
        }
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Screen3ViewController") as! Screen3ViewController
        if (labelResults.text != "Result: ") {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.gets = labelResults.text ?? ""
        } else {
            didLogin(inf: "Please chooes checkbox")
        }
    }
    
    private func didLogin(inf: String){
        let mess = inf
        let alert = UIAlertController(title: "Error", message: mess, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switchChange.isOn = false
        buttonClick.backgroundColor = .gray
        buttonClick.isEnabled = false
        buttonCheckBox1.setBackgroundImage((UIImage(named: "")), for: .normal)
        buttonCheckBox2.setBackgroundImage((UIImage(named: "")), for: .normal)
        labelResults.text = "Result: "
        check = false
        check2 = false
    }
}
