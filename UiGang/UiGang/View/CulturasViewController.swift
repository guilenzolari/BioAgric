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
    
    var arrayCulturas: [String] = []
    var sectionTitle = [String]()
    var culturasDict = [String: [String]]()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.culturasTableView.delegate = self
    self.culturasTableView.dataSource = self
    self.controller.getRequestPragas { response, error in
          if !response.isEmpty {
              self.arrayCulturas = response
              self.sectionTitle = Array(Set(self.arrayCulturas.compactMap({ String($0.prefix(1)) })))
              self.sectionTitle.sort()
              self.sectionTitle.forEach { letter in
                  let filteredCulturas = self.arrayCulturas.filter { $0.hasPrefix(letter) }
                  self.culturasDict[letter] = filteredCulturas
              }
              self.culturasTableView.reloadData()
          } else {
              print("Erro ao carregar os dados das culturas:", error?.localizedDescription ?? "")
          }
      }
  }
}

//Table View
extension CulturasViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections (in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        culturasDict[sectionTitle[section]]?.count ?? 0
      //  return self.controller.count()
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = culturasDict[sectionTitle[indexPath.section]]?[indexPath.row]
        // cell.textLabel?.text = self.controller.loadCurrentName(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let culturasDetalhesVC = UIStoryboard(name: "CulturasDetalhes", bundle: nil).instantiateViewController(withIdentifier: "culturasDetalhes") as! CulturasDetalhesViewController
        
        self.navigationController?.pushViewController(culturasDetalhesVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    func sectionIndexTitles (for tableView: UITableView) -> [String]? {
        sectionTitle
    }
}
