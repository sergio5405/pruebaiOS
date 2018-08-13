//
//  EventoTVCell.swift
//  PruebaNextia
//
//  Created by Sergio Hernández Méndez on 8/13/18.
//  Copyright © 2018 Sergio Hernández Méndez. All rights reserved.
//

import UIKit

class EventoTVCell: UITableViewCell {
    @IBOutlet weak var nombreEventoLbl: UILabel!
    @IBOutlet weak var fechaLbl: UILabel!
    @IBOutlet weak var horarioLbl: UILabel!
    
    var evento: Evento! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        nombreEventoLbl.text = "\(evento.nombreEvento) impartido por \(evento.nombreEncargado)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let fechaInicio = dateFormatter.date(from: evento.fechaHoraInicio)
        let fechaFin = dateFormatter.date(from: evento.fechaHoraFin)

        dateFormatter.dateFormat = "dd/MM/yy"
        fechaLbl.text = "\(dateFormatter.string(from: fechaInicio!)) - \(dateFormatter.string(from: fechaFin!))"

        dateFormatter.dateFormat = "HH:mm"
        horarioLbl.text = "\(dateFormatter.string(from: fechaInicio!)) - \(dateFormatter.string(from: fechaFin!))"
    }
    
}
