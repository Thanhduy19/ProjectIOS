//
//  PersonCollectionCell.swift
//  CoreData_App
//
//  Created by Macbook on 04/04/2023.
//

import UIKit

class PersonCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var labelPerson: UILabel!
    @IBOutlet weak var imagePersonC: UIImageView!
    
    @IBOutlet weak var selectDelate: UILabel!
    var isEditings: Bool = false {
        didSet {
            selectDelate.isHidden = !isEditings
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectDelate.layer.cornerRadius = 15
        self.selectDelate.layer.masksToBounds = true
        self.selectDelate.layer.borderColor = UIColor.white.cgColor
        self.selectDelate.layer.borderWidth = 1.0
        self.selectDelate.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    var count = 0
    override var isSelected: Bool {
        
        didSet {

            if (count == 0){
                if isEditings {
                    count = 1
                    selectDelate.text = isSelected ? "✓":""
                }
                else {
                    selectDelate.text = isSelected ? "":"✓"
                    count = 0
                }
            } else {
                selectDelate.text = isSelected ? "":"✓"
                count = 0
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectDelate.isHidden = !isEditings
    }
    
}
