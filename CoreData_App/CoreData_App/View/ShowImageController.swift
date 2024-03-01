//
//  ShowImageController.swift
//  CoreData_App
//
//  Created by Macbook on 04/04/2023.
//

import UIKit

class ShowImageController: UIViewController {

    @IBOutlet weak var imageZoom: UIImageView!
    
    @IBOutlet weak var linkImage: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var getLinkZoom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        linkImage.text = getLinkZoom
        scrollView.delegate = self
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        
    }
    override func viewWillAppear(_ animated: Bool) {
        imageZoom.downloaded(from: getLinkZoom)
        linkImage.isHidden = true
    }

}
