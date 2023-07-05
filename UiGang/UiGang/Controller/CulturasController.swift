//
//  InsumosController.swift
//  UiGang
//
//  Created by Guilherme Ferreira Lenzolari on 04/07/23.
//

import Foundation
import Alamofire

class CulturasController {

  private var arrayCulturas: [String] = []

  func count() -> Int{
    return self.arrayCulturas.count
  }

  func loadCurrentName(indexPath: IndexPath) -> String {
    return self.arrayCulturas[indexPath.row]
  }

  func getRequestPragas(completionHandler: @escaping(Bool, Error?) -> Void){
    let headers: HTTPHeaders = [
      "Accept": "application/json",
      "Authorization": "Bearer fa31c5ec-034f-3202-bca6-c00ef36d7591"
    ]
    let urlAPI = "https://api.cnptia.embrapa.br/bioinsumos/v1/inoculantes"

    AF.request(urlAPI, headers: headers).responseJSON { response in
      if let statusCode = response.response?.statusCode, statusCode == 200 {
        if let data = response.data {
          do {
            let culturasModel: Welcome? = try JSONDecoder().decode(Welcome.self, from: data)

              if let culturas = culturasModel?.data {
              var array: [String] = []

              for cultura in culturas {

                if let nomeComum = cultura.culturas.first?.cultura {
                    array.append(String(nomeComum))
                }
              }
              //capital letters, alphabetical order and deleting repeated ones
              self.arrayCulturas = Array(Set(array)).sorted().map { $0.capitalized }
              completionHandler(true, nil)
            }
          } catch {
            print(error)
            completionHandler(false, error)
          }
        }
      }
    }
  }
}

