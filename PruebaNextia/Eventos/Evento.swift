//
//  Evento.swift
//  PruebaNextia
//
//  Created by Sergio Hernández Méndez on 8/13/18.
//  Copyright © 2018 Sergio Hernández Méndez. All rights reserved.
//

import UIKit

struct Evento: Decodable {
    let id: Int
    let direccion: String
    let latitud: Double
    let longitud: Double
    let nombreEvento: String
    let nombreEncargado: String
    let fechaHoraInicio: String
    var fechaInicio: Date?
    let fechaHoraFin: String
    var fechaFin: Date?
    let cupo: Int
}

class Eventos{
    static var eventos: [Evento]?
}
