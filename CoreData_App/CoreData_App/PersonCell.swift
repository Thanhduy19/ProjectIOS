//
//  PersonCell.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var avatarPerSon: UIImageView!
    
    @IBOutlet weak var namePerson: UILabel!
    
    
    @IBOutlet weak var emailPerson: UILabel!
    
    @IBOutlet weak var phonePerson: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarPerSon.image = UIImage(named: "login")
        avatarPerSon.makeRounded()
        // Initialization code
    }

    
}
