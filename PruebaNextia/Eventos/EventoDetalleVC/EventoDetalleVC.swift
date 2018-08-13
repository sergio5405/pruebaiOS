//
//  EventoDetalleVC.swift
//  PruebaNextia
//
//  Created by Sergio Hernández Méndez on 8/13/18.
//  Copyright © 2018 Sergio Hernández Méndez. All rights reserved.
//

import UIKit
import GoogleMaps

class EventoDetalleVC: UIViewController {
    var evento: Evento!
    @IBOutlet weak var responsableLbl: UILabel!
    @IBOutlet weak var fechaHoraLbl: UILabel!
    @IBOutlet weak var direccionLbl: UILabel!
    @IBOutlet weak var googleMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.updateMap()
    }
    
    func updateMap(){
        let camera = GMSCameraPosition.camera(withLatitude: evento.latitud, longitude: evento.longitud, zoom: 6.0)
        googleMapView.camera = camera

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: evento.latitud, longitude: evento.longitud)
        marker.title = evento.nombreEvento
        marker.map = googleMapView
        marker.isDraggable = false
    }
    
    func updateUI(){
        self.title = evento.nombreEvento
        self.responsableLbl.text = evento.nombreEncargado
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let fechaInicio = dateFormatter.date(from: evento.fechaHoraInicio)
        let fechaFin = dateFormatter.date(from: evento.fechaHoraFin)
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        var fechaHoraStr = "\(dateFormatter.string(from: fechaInicio!))"
        
        dateFormatter.dateFormat = "HH:mm"
        fechaHoraStr += " \(dateFormatter.string(from: fechaInicio!)) - \(dateFormatter.string(from: fechaFin!))"
        
        self.fechaHoraLbl.text = fechaHoraStr
        self.direccionLbl.text = evento.direccion
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
