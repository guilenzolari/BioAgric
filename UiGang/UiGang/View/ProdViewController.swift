//
//  TesteViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 12/07/23.
//

import UIKit

class ProdViewController: UIViewController {

    @IBOutlet weak var tbDadosProd: UITableView!
    
    var produtoBiologico: DatumProdutosBiologicos?
    var nRegistro: Int?
    var titularRegistro: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setTableView(){
        tbDadosProd.dataSource = self
        tbDadosProd.delegate = self
        tbDadosProd.register(UINib(nibName: "ProdutoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProdutoTableViewCell")
    }
}

extension ProdViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
            fatalError()
        }
        cell.labelSubName.text = titularRegistro
        return cell
    }
    
    
}
