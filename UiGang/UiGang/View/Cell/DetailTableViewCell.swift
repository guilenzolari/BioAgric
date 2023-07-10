//
//  DetailTableViewCell.swift
//  UiGang
//
//  Created by Matheus Barbosa on 10/07/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblClasse: UILabel!
    @IBOutlet weak var lblMarcaComercial: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
