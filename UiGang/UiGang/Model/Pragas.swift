//
//  Pragas.swift
//  UiGang
//
//  Created by Ana Elisa Lima on 04/07/23.
//

import Foundation

// MARK: - ProdutoBiologico
struct ProdutoBiologico: Codable {
  let meta: MetaProdutoBiologico
  let data: [DatumProdutosBiologicos]
}
// MARK: - Datum
struct DatumProdutosBiologicos: Codable {
  let registroProduto: Int
  let marcaComercial, titularRegistro, ingredienteAtivo: String
  let classes: [Class]
  let pragas: [Pragas]
  let aprovadoParaAgriculturaOrganica: Bool
  let classificacaoToxicologica: ClassificacaoToxicologica
  let classificacaoAmbiental: ClassificacaoAmbiental
  let url: String
}
enum Class: String, Codable {
  case acaricidaMicrobiológico = "Acaricida Microbiológico"
  case agenteBiológicoDeControle = "Agente Biológico de Controle"
  case bactericidaMicrobiológico = "Bactericida Microbiológico"
  case classFungicidaMicrobiológico = " Fungicida Microbiológico"
  case classInseticidaMicrobiológico = " Inseticida Microbiológico"
  case classNematicidaMicrobiológico = " Nematicida Microbiológico"
  case feromônio = "Feromônio"
  case fungicida = "Fungicida"
  case fungicidaMicrobiológico = "Fungicida Microbiológico"
  case inseticida = " Inseticida"
  case inseticidaMicrobiológico = "Inseticida Microbiológico"
  case nematicidaMicrobiológico = "Nematicida Microbiológico"
}
enum ClassificacaoAmbiental: String, Codable {
  case produtoDeBaixoRiscoAoMeioAmbiente = "Produto de Baixo Risco ao Meio Ambiente"
  case produtoPerigosoAoMeioAmbiente = "Produto Perigoso ao Meio Ambiente"
  case produtoPoucoPerigosoAoMeioAmbiente = "Produto Pouco Perigoso ao Meio Ambiente"
}
enum ClassificacaoToxicologica: String, Codable {
  case baixaExposiçãoParaUsoRestritoEmArmadilhas = "Baixa Exposição para Uso Restrito em Armadilhas"
  case medianamenteTóxico = "Medianamente Tóxico"
  case nãoDeterminadoDevidoÀNaturezaDoProduto = "Não Determinado Devido à Natureza do Produto"
  case poucoTóxico = "Pouco Tóxico"
  case produtoImprovávelDeCausarDanoAgudo = "Produto Improvável de Causar Dano Agudo"
  case produtoNãoClassificado = "Produto Não Classificado"
  case produtoPoucoTóxico = "Produto Pouco Tóxico"
}
// MARK: - Pragas
struct Pragas: Codable {
  let cultura, nomeCientifico: String
  let nomeComum: [String]
}
// MARK: - Meta
struct MetaProdutoBiologico: Codable {
  let totalCount: Int
}
