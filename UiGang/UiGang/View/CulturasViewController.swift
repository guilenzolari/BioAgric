//
//  CulturasViewController.swift
//  UiGang
//
//  Created by Caio Zavarezzi balieiro on 04/07/23.
//


import UIKit
import Alamofire

class CulturasViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate, UITableViewDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
                if !searchText.isEmpty {
                    filteredData = arrayCulturas.filter { praga in
                        guard let firstLetter = praga.first?.lowercased() else {
                            return false
                        }
                        return firstLetter == searchText
                    }
                } else {
                    filteredData = arrayCulturas
                }
            culturasTableView.reloadData()
            }
    }
    
    func applySearchFilter() {
        if searchText.isEmpty {
            filteredData = arrayCulturas
        } else {
            filteredData = arrayCulturas.filter {$0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
    @IBOutlet weak var culturasTableView: UITableView!
    
    var controller: CulturasController = CulturasController()
    
    var arrayCulturas: [String] = []
    var sectionTitle = [String]()
    var culturasDict = [String: [String]]()
    
    var data = [String]()
    var filteredData = [String]()
    var searchActive = false
    var searchText: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    
  override func viewDidLoad() {
    super.viewDidLoad()
    searchController.searchBar.delegate = self
    navigationItem.searchController = searchController
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
      func filterData(searchText: String?) {
          if let searchText = searchText, !searchText.isEmpty {
              filteredData = arrayCulturas.filter { $0.lowercased().contains(searchText.lowercased()) }
          } else {
              filteredData = arrayCulturas
          }
          culturasTableView.reloadData()
      }
  }
}

//Table View
extension CulturasViewController: UITableViewDataSource{
    func numberOfSections (in tableView: UITableView) -> Int {
        return filteredData.isEmpty ? sectionTitle.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.isEmpty {
            let sectionKey = sectionTitle[section]
            return culturasDict[sectionKey]?.count ?? 0
        } else {
            return filteredData.count
        }
      //  return self.controller.count()
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if filteredData.isEmpty {
            let sectionKey = sectionTitle[indexPath.section]
            if let rowData = culturasDict[sectionKey]?[indexPath.row] {
                cell.textLabel?.text = rowData
            }
        } else {
            let rowData = filteredData[indexPath.row]
            cell.textLabel?.text = rowData
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
        culturasTableView.reloadData()
    }
            
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let culturasDetalhesVC = UIStoryboard(name: "CulturasDetalhes", bundle: nil).instantiateViewController(withIdentifier: "culturasDetalhes") as! CulturasDetalhesViewController
        
        self.navigationController?.pushViewController(culturasDetalhesVC, animated: true)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredData = arrayCulturas.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    func sectionIndexTitles (for tableView: UITableView) -> [String]? {
        sectionTitle
    }
}
