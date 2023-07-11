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
    var marcaComercial: String?
    var classe: Class?
    
    override func viewDidLoad() {
        
        self.tbProd.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbProd.dataSource = self
        self.tbProd.delegate = self
        
        super.viewDidLoad()
        
    }
}

extension DetalhesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtoBiologico?.classes.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DetailTableViewCell{
            cell.lblMarcaComercial.text = marcaComercial
            if let classe = produtoBiologico?.classes[indexPath.row] {
                    cell.lblClasse.text = classe.rawValue
                }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let produtoVC = UIStoryboard(name: "Detalhes", bundle: nil).instantiateViewController(withIdentifier: "ProdutoViewController") as! ProdutoViewController
        self.navigationController?.present(produtoVC, animated: true)
    }
}
