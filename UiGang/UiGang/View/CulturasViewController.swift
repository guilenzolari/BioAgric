//
//  CulturasViewController.swift
//  UiGang
//
//  Created by Caio Zavarezzi balieiro on 04/07/23.
//


import UIKit
import Alamofire

class CulturasViewController: UIViewController {

    @IBOutlet weak var culturasTableView: UITableView!
    
    var controller: CulturasController = CulturasController()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.culturasTableView.delegate = self
    self.culturasTableView.dataSource = self
      
      controller.getRequestPragas { success, error in
          if success {
              self.culturasTableView.reloadData()
          } else {
              print("Erro ao carregar os dados das culturas:", error?.localizedDescription ?? "")
          }
      }
  }
}

//Table View
extension CulturasViewController: UITableViewDelegate, UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.controller.count()
  }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = self.controller.loadCurrentName(indexPath: indexPath)
    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let culturasDetalhesVC = UIStoryboard(name: "CulturasDetalhes", bundle: nil).instantiateViewController(withIdentifier: "culturasDetalhes") as! CulturasDetalhesViewController
        
        self.navigationController?.pushViewController(culturasDetalhesVC, animated: true)
    }
}
