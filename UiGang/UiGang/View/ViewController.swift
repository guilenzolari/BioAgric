//
//  ViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 03/07/23.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate, UITableViewDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
                if !searchText.isEmpty {
                    filteredData = arrayPragas.filter { praga in
                        guard let firstLetter = praga.first?.lowercased() else {
                            return false
                        }
                        return firstLetter == searchText
                    }
                } else {
                    filteredData = arrayPragas
                }
                pragasTableView.reloadData()
            }
    }
    
    func applySearchFilter() {
        if searchText.isEmpty {
            filteredData = arrayPragas
        } else {
            filteredData = arrayPragas.filter {$0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    @IBOutlet weak var pragasTableView: UITableView!
    
    // Variaveis para manipulas as pragas
    var controller: PragasController = PragasController()
    var arrayPragas:[String] = []
   
    // Variaveis para Sections e Index
    var sectionTitle = [String]()
    var pragasDict = [String: [String]]()
    
    var data = [String]()
    var filteredData = [String]()
    var searchActive = false
    var searchText: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        self.pragasTableView.delegate = self
        self.pragasTableView.dataSource = self
        self.controller.getRequestPragas { response, error in
            if !response.isEmpty {
                self.arrayPragas = response
                self.sectionTitle = Array(Set(self.arrayPragas.compactMap({ String($0.prefix(1)) })))
                self.sectionTitle.sort()
                self.sectionTitle.forEach { letter in
                    let filteredPragas = self.arrayPragas.filter { $0.hasPrefix(letter) }
                    self.pragasDict[letter] = filteredPragas
                }
                self.pragasTableView.reloadData()
            } else {
                print(error)
            }
        }
        
        func filterData(searchText: String?) {
            if let searchText = searchText, !searchText.isEmpty {
                filteredData = arrayPragas.filter { $0.lowercased().contains(searchText.lowercased()) }
            } else {
                filteredData = arrayPragas
            }
            pragasTableView.reloadData()
        }
    }
  }

    //Table View
extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.isEmpty ? sectionTitle.count : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.isEmpty {
            let sectionKey = sectionTitle[section]
            return pragasDict[sectionKey]?.count ?? 0
        } else {
            return filteredData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if filteredData.isEmpty {
            let sectionKey = sectionTitle[indexPath.section]
            if let rowData = pragasDict[sectionKey]?[indexPath.row] {
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
            pragasTableView.reloadData()
        }
        
        func filterContentForSearchText(_ searchText: String) {
            filteredData = arrayPragas.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            sectionTitle[section]
        }
        func sectionIndexTitles (for tableView: UITableView) -> [String]? {
            sectionTitle
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detalhesVC = UIStoryboard(name: "Detalhes", bundle: nil).instantiateViewController(withIdentifier: "DetalhesViewController") as! DetalhesViewController
            detalhesVC.produtoBiologico = self.controller.loadCurrentProdutoBiologico(indexPath: indexPath)
            
            detalhesVC.marcaComercial = detalhesVC.produtoBiologico?.marcaComercial
            
            detalhesVC.nomeComum = detalhesVC.produtoBiologico?.pragas.first?.nomeComum.first
            detalhesVC.nomeCientifico = detalhesVC.produtoBiologico?.pragas.first?.nomeCientifico
            
            self.navigationController?.pushViewController(detalhesVC, animated: true)
           
        }
      }

