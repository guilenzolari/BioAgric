//
//  DetalhesViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 05/07/23.
//

import UIKit

class DetalhesViewController: UIViewController {
    @IBOutlet weak var lblNomeComum: UILabel!
    @IBOutlet weak var lblMarcaComercial: UILabel!
    var nomeComumText: String?
    var marcaComercialText: String?
    var produtoBiologico: DatumProdutosBiologicos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nomeComum = nomeComumText {
            lblNomeComum.text = nomeComum
            
        }
        
    }
}
