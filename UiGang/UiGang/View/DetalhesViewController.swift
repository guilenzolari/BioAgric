//
//  DetalhesViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 05/07/23.
//

import UIKit

class DetalhesViewController: UIViewController {
    @IBOutlet var tbProd: UITableView!
    
    var produtoBiologico: DatumProdutosBiologicos?
    
    override func viewDidLoad() {
        
        self.tbProd.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbProd.dataSource = self
        self.tbProd.delegate = self
        super.viewDidLoad()
        
    }
}

extension DetalhesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DetailTableViewCell{
            
            return cell
        }
        return UITableViewCell()
    }
}
