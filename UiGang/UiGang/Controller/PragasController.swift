//
//  PragasController.swift
//  UiGang
//
//  Created by Ana Elisa Lima on 04/07/23.
//

import Foundation
import Alamofire

class PragasController {
    private var arrayPragas: [String] = []
    private var produtosBiologicos: [DatumProdutosBiologicos] = []
    private var pragas: [Pragas] = []
    
    func count() -> Int{
        return self.arrayPragas.count
    }
    func loadCurrentName(indexPath: IndexPath) -> String {
        return self.arrayPragas[indexPath.row]
    }
    
    func loadCurrentProdutoBiologico(indexPath: IndexPath) -> DatumProdutosBiologicos? {
            let nomeComum = loadCurrentName(indexPath: indexPath)
            
            return produtosBiologicos.first { produto in
                produto.pragas.contains { $0.nomeComum.contains(nomeComum) }
            }
        }
    
        func getProdutosByNomeComum(nomeComum: String) -> [DatumProdutosBiologicos] {
            let filteredProducts = produtosBiologicos.filter { praga in
                praga.pragas.contains { $0.nomeComum.contains(nomeComum) }
            }
            return filteredProducts
        }
    
    func getRequestPragas(completionHandler: @escaping([String], Error?) -> Void){
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer fa31c5ec-034f-3202-bca6-c00ef36d7591"
        ]
        let urlAPI = "https://api.cnptia.embrapa.br/bioinsumos/v1/produtos-biologicos"
        AF.request(urlAPI, headers: headers).responseJSON { response in
            if let statusCode = response.response?.statusCode,
               statusCode == 200 {
                if let data = response.data {
                    do {
                        let pragaModel: ProdutoBiologico? = try JSONDecoder().decode(ProdutoBiologico.self, from: data)
                        
                        if let pragas = pragaModel?.data {
                            
                            var array: [String] = []
                            
                            for praga in pragas {
                                if let nomeComum = praga.pragas.first?.nomeComum.first {
                                    array.append(nomeComum)
                                    
                                }
                            }
                            //capital letters, alphabetical order and deleting repeated ones
                            self.arrayPragas = Array(Set(array)).sorted().map { $0.capitalized }
                            completionHandler(self.arrayPragas, nil)
                            
                            
                            self.produtosBiologicos = pragas
                        }
                    } catch {
                        print(error)
                        completionHandler([], error)
                    }
                }
            }
        }
    }
}
