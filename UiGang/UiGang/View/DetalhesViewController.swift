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
    var praga: Pragas?
    var nomeComum: String?
    var nomeCientifico: String?
    var marcaComercial: String?
    var classe: Class?
    var controller: PragasController = PragasController()
    
    override func viewDidLoad() {

        self.tbProd.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbProd.register(UINib(nibName: "PictureCell", bundle: nil), forCellReuseIdentifier: "PictureCell")
        self.tbProd.register(UINib(nibName: "TituloTableViewCell", bundle: nil), forCellReuseIdentifier: "TituloTableViewCell")
        self.tbProd.dataSource = self
        self.tbProd.delegate = self
        self.controller.getRequestPragas { response, error in
          if !response.isEmpty {
            self.tbProd.reloadData()
          }else{
            print(error)
          }
        }
        super.viewDidLoad()
        
    }
}

extension DetalhesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cellCard = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as? PictureCell else {
                fatalError()
            }
            cellCard.tableImage.image = UIImage(named: "Image")
            cellCard.tableTitle.text = nomeComum
            cellCard.tableSubTitle.text = nomeCientifico
            return cellCard
        }
        
        if indexPath.section == 1 {
            guard let tituloCell = tableView.dequeueReusableCell(withIdentifier: "TituloTableViewCell", for: indexPath) as? TituloTableViewCell else {
                fatalError()
            }
            tituloCell.lblTitulo.text = "Bio Insumos"
            return tituloCell

        }
        
        if indexPath.section == 2 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DetailTableViewCell else {
            fatalError()
        }
            cell.lblMarcaComercial?.text = marcaComercial ?? "Produto não encontrado"
            if let classe = produtoBiologico?.classes[indexPath.row] {
                cell.lblClasse.text = classe.rawValue
                }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prodVC = ProdViewController(nibName: "ProdViewController", bundle: nil)
        let vc0 = UINavigationController(rootViewController: prodVC)
        
        prodVC.produtoBiologico = self.controller.loadCurrentProdutoBiologico(indexPath: indexPath)
        
        prodVC.numeroRegistro = prodVC.produtoBiologico?.registroProduto
        prodVC.titularRegistro = prodVC.produtoBiologico?.titularRegistro
        prodVC.ingredienteAtivo = prodVC.produtoBiologico?.ingredienteAtivo
        prodVC.classe = prodVC.produtoBiologico?.classes
        prodVC.classificacaoToxicologica = prodVC.produtoBiologico?.classificacaoToxicologica
        prodVC.classificacaoAmbiental = prodVC.produtoBiologico?.classificacaoAmbiental
        
        self.present(vc0, animated: true, completion: nil)
    }
}
