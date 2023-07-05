//
//  DetalhesViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 05/07/23.
//

import UIKit

class DetalhesViewController: UIViewController {
    @IBOutlet weak var lblNomeComum: UILabel!
    @IBOutlet weak var imgPraga: UIImageView!
    @IBOutlet var tbProd: UIView!
    @IBOutlet weak var lblNomeCientifico: UILabel!

    @IBOutlet weak var lblMarcaComercial: UILabel!
    
    
    
    
    var produtoBiologico: DatumProdutosBiologicos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let produto = produtoBiologico {
                    lblNomeComum.text = produto.pragas.first?.nomeComum.first
                    lblNomeCientifico.text = produto.pragas.first?.nomeCientifico
                    lblMarcaComercial.text = produto.marcaComercial
//                    lblRegistroProduto.text = "\(produto.registroProduto)"
//                    lblIngredienteAtivo.text = produto.ingredienteAtivo
//                    lblClasse.text = produto.classes.joined(separator: ", ")
//                    lblAprovadoAgriculturaOrganica.text = produto.aprovadoParaAgriculturaOrganica ? "Sim" : "Não"
//                    lblClassificacaoToxicologica.text = produto.classificacaoToxicologica.rawValue
                }
    }
    
}
