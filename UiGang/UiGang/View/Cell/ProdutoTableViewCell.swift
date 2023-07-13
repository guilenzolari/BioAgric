//
//  ProdutoTableViewCell.swift
//  UiGang
//
//  Created by Matheus Barbosa on 12/07/23.
//

import UIKit

class ProdutoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSubName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(title: String, sub: String) {
        labelName.text = title
        labelSubName.text = sub
    }
}
