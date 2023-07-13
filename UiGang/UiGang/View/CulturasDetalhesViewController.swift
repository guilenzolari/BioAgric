//
//  CulturasDetalhesViewController.swift
//  UiGang
//
//  Created by Guilherme Ferreira Lenzolari on 06/07/23.
//

import UIKit

class CulturasDetalhesViewController: UIViewController {

    @IBOutlet weak var inoculantesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inoculantesTableView.dataSource = self
        inoculantesTableView.delegate = self
        inoculantesTableView.register(UINib(nibName: "PictureCell", bundle: nil), forCellReuseIdentifier: "PictureCell")
    }
    


}

extension CulturasDetalhesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "PictureCell") as? PictureCell)!
        
        cell.tableImage.image = UIImage(named: "Image")
        cell.tableTitle.text = "Nome Comum"
        cell.tableSubTitle.text = "Nome Científico"
        
        return cell
    }
}
