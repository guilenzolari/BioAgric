import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let meta: Meta
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let registroProduto, cnpj, razaoSocial: String
    let uf: Uf
    let atividade: Atividade
    let tipoFertilizante: TipoFertilizante
    let especie, dataRegistro, garantia: String
    let naturezaFisica: NaturezaFisica
    let culturas: [Cultura]
}

enum Atividade: String, Codable {
    case comerciante = "COMERCIANTE"
    case exportador = "EXPORTADOR"
    case importador = "IMPORTADOR"
    case produtor = "PRODUTOR"
}

// MARK: - Cultura
struct Cultura: Codable {
    let cultura, nomeCientifico: String
}

enum NaturezaFisica: String, Codable {
    case fluido = "FLUIDO"
    case liquido = "LIQUIDO"
    case solido = "SOLIDO"
}

enum TipoFertilizante: String, Codable {
    case bactériaFixadoraDeNitrogênioPorSimbiose = "BACTÉRIA FIXADORA DE NITROGÊNIO POR SIMBIOSE"
    case bactériasAssociativas = "BACTÉRIAS ASSOCIATIVAS"
    case microOrganismosPromotoresDeCrescimentoDePlantas = "MICRO-ORGANISMOS PROMOTORES DE CRESCIMENTO DE PLANTAS"
}

enum Uf: String, Codable {
    case ba = "BA"
    case df = "DF"
    case mg = "MG"
    case mt = "MT"
    case pr = "PR"
    case rs = "RS"
    case sc = "SC"
    case sp = "SP"
    case to = "TO"
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount: Int
}
