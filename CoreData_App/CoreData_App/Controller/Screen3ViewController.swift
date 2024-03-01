//
//  Screen3ViewController.swift
//  CoreData_App
//
//  Created by Macbook on 19/04/2023.
//

import UIKit

class Screen3ViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
    var gets = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.text = gets
    }

    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
