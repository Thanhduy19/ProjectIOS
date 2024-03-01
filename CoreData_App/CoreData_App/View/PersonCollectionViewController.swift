//
//  PersonCollectionViewController.swift
//  CoreData_App
//
//  Created by Macbook on 04/04/2023.
//

import UIKit
import CoreData

class PersonCollectionViewController: UIViewController {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var clickButtons: UIButton!
    var index: IndexPath?
    var personC: [PersonCollection] = []
    var results: [Person] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        clickButtons.isHidden = true
        fecth()
        collectionView.reloadData()
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cells = collectionView.cellForItem(at: indexPath) as! PersonCollectionCell
            cells.isEditings = editing
        }
    }
    
    
    @IBAction func deleteColl(_ sender: UIButton) {
        collectionView.isEditing = !collectionView.isEditing
        if collectionView.isEditing {
            setEditing(true, animated: true)
            clickButtons.isHidden = false
        }
        if !collectionView.isEditing {
            setEditing(false, animated: false)
            clickButtons.isHidden = true
        }
    }
   
    
    @IBAction func clickDelete(_ sender: UIButton) {
        deleteItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
            fecth()
            collectionView.reloadData()
  
    }
    

    
    @IBAction func buttonAdd(_ sender: UIButton) {
       if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPersonCollectionController") as?
        DetailPersonCollectionController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension PersonCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionCell", for: indexPath) as! PersonCollectionCell
        cell.imagePersonC.downloaded(from: results[indexPath.row].links ?? "")
        cell.labelPerson.text = results[indexPath.row].name ?? ""
        cell.isEditings = isEditing
        
         return cell
    }
    
}

extension PersonCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 170)
    }
}
extension PersonCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing{
            let story = UIStoryboard(name: "Main", bundle: nil)
            let detais = story.instantiateViewController(withIdentifier: "DetailPersonCollectionController")
            as! DetailPersonCollectionController
            detais.getlinkPersonC = results[indexPath.row].links ?? ""
            detais.getNamePersonC = results[indexPath.row].name ?? ""
            detais.getEmailPersonC = results[indexPath.row].email ?? ""
            detais.getPhonePersonC = results[indexPath.row].phone ?? ""
            detais.getGenderPersonC = results[indexPath.row].gender ?? ""
            
            self.navigationController?.pushViewController(detais, animated: true)
        }
    }
    
   
}
