//
//  ViewController.swift
//  UiGang
//
//  Created by Matheus Barbosa on 03/07/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var pragasTableView: UITableView!
    
    var controller: PragasController = PragasController()
    var arrayPragas:[String] = []
   
    
    var sectionTitle = [String]()
    var pragasDict = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
      }

       /* func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell: UITableViewCell = pragasTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = self.controller.loadCurrentName(indexPath: indexPath)
           // cell.textLabel?.text = pragasDict[sectionTitle[indexPath.section]]?[indexPath.row]
          return cell
            
            func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                sectionTitle[section]
            }
        }*/
