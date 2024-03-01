//
//  PersenPresenter.swift
//  CoreData_App
//
//  Created by Macbook on 04/04/2023.
//

import Foundation
import UIKit
import CoreData

//protocol PersonPresenter: AnyObject {
//    func presenterPerson(persons: [PersonCollection])
//}
//typealias PresenterDelegate = PersonPresenter & UIViewController
//

class LoadPersonCollection {
    @Published var personData = [PersonCollection]()
   // weak var delegate: PresenterDelegate?
    func load(){
        if let fileLocation = Bundle.main.url(forResource: "dataJsons", withExtension: "json"){
            do {
                let data = try Data(contentsOf: fileLocation)
                let dataDeco = JSONDecoder()
                let dataJson = try dataDeco.decode([PersonCollection].self, from: data)
                self.personData = dataJson
            } catch {
                print(error)
            }
        }
    }
    
    
    
}
extension ShowImageController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageZoom
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageZoom.image {
                let ratiW = imageZoom.frame.width / image.size.width
                let ratiH = imageZoom.frame.height / image.size.height

                let radio = ratiW < ratiH ? ratiW : ratiH
                let newW = image.size.width * radio
                let newH = image.size.height * radio
                let condiL = newW * scrollView.zoomScale > imageZoom.frame.width
                let left = 0.5 * (condiL ? newW - imageZoom.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conTop = newH * scrollView.zoomScale > imageZoom.frame.height
                let top = 0.5 * (conTop ? newH - imageZoom.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
extension PersonCollectionViewController {
    
    
    func deleteItems(){
        let alert = UIAlertController(title: "Delete", message: "Are you sure delete ", preferredStyle: .alert)
        let del = UIAlertAction(title: "Yes", style: .default) { [self] (action) in
            if let selected = collectionView.indexPathsForSelectedItems {
                let items = selected.map{$0.item}.sorted().reversed()
                for item in items {
                    //self.results.remove(at: item)
                    self.context.delete(self.results[item])
                    saveContext()
                    self.fecth()
                    collectionView.deleteItems(at: selected)
                    collectionView.reloadData()
                }
            }
        }
        let cancle = UIAlertAction(title: "No", style: .default, handler:  nil)
        alert.addAction(del)
        alert.addAction(cancle)
        present(alert, animated: true)
    }
    ////
    func fecth(){
        let res = NSFetchRequest<Person>(entityName: "Person")
            do {
                results = try context.fetch(res)
            }
            catch {
                print(error)
            }
        
    }
}
