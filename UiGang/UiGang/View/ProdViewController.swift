//
//  TesteViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 12/07/23.
//

import UIKit

class ProdViewController: UIViewController {

    @IBOutlet weak var tbDadosProd: UITableView!
    @IBOutlet weak var navbar: UINavigationBar!
    
    var produtoBiologico: DatumProdutosBiologicos?
    var numeroRegistro: Int?
    var titularRegistro: String?
    var ingredienteAtivo: String?
    var classe: [Class]?
    
    var aprovado: Bool?
    var classificacaoToxicologica: ClassificacaoToxicologica?
    var classificacaoAmbiental: ClassificacaoAmbiental?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        title = produtoBiologico?.marcaComercial
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerLabel: String!
        if section == 0 {
            headerLabel = "DESCRIÇÃO"
        } else {
            headerLabel = "CARACTERÍSTICAS"
        }
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                //Numero do Registro no Mapa
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                cell.commonInit(title: "Numero do Registro no Mapa", sub: numeroRegistro.map { String($0) } ?? "")
                return cell
            }
            
            if indexPath.item == 1 {
                //Titular do Registro
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                cell.commonInit(title: "Titular do Registro", sub: titularRegistro ?? "Não encontrado")
                return cell
            }
            
            if indexPath.item == 2 {
                //Ingrediente Ativo
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                cell.commonInit(title: "Ingrediente Ativo", sub: ingredienteAtivo ?? "Não encontrado")
                return cell
            }
            
            if indexPath.item == 3 {
                //Numero do Registro no Mapa
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                let classeString = classe?.map { $0.rawValue }.joined(separator: ", ") ?? "Não encontrado"
                cell.commonInit(title: "Classe", sub: classeString)
                return cell
            }

        }
        
        if indexPath.section == 1 {
            if indexPath.item == 0 {
                //Aprovado para Agricultura Orgânica
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                cell.commonInit(title: "Aprovado para Agricultura Orgânica", sub: aprovado ?? false ? "Produto com Uso Aprovado para Agricultura Orgânica" : "Produto Não Aprovado")
                return cell
            }
            
            if indexPath.item == 1 {
                //classificacaoToxicologica
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                cell.commonInit(title: "Toxicológica", sub: classificacaoToxicologica?.rawValue ?? "Produto não classificado")
                return cell
            }
            
            if indexPath.item == 2 {
                //classificacaoAmbiental
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoTableViewCell", for: indexPath) as? ProdutoTableViewCell else {
                    fatalError()
                }
                cell.commonInit(title: "Potencial de periculosidade ambiental", sub: classificacaoAmbiental?.rawValue ?? "Produto não classificado")
                return cell
            }
        }
        
        
        
        return UITableViewCell()
    }
    
    
}
