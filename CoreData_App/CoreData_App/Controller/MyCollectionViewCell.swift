//
//  MyCollectionViewCell.swift
//  CoreData_App
//
//  Created by Macbook on 05/04/2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCell.makeRounded()
        // Initialization code
    }
}
