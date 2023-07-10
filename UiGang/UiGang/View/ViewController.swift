//
//  ViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 03/07/23.
//

import UIKit
import Alamofire



class ResultsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad ()
        //view.backgroundColor = .systemBlue
    }
}

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
    }
    
    
    @IBOutlet weak var pragasTableView: UITableView!
    
    // Variaveis para manipulas as pragas
    var controller: PragasController = PragasController()
    var arrayPragas:[String] = []
   
    // Variaveis para Sections e Index
    var sectionTitle = [String]()
    var pragasDict = [String: [String]]()
    
    let searchController = UISearchController(searchResultsController: ResultsVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
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
                

    }
}
    //Table View
    extension ViewController: UITableViewDelegate, UITableViewDataSource{
        func numberOfSections (in tableView: UITableView) -> Int {
            sectionTitle.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            pragasDict[sectionTitle[section]]?.count ?? 0
            //return self.controller.count()
      }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          //  cell.textLabel?.text = self.controller.loadCurrentName(indexPath: indexPath)
            cell.textLabel?.text = pragasDict[sectionTitle[indexPath.section]]?[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            sectionTitle[section]
        }
        func sectionIndexTitles (for tableView: UITableView) -> [String]? {
            sectionTitle
        }
        
      }

