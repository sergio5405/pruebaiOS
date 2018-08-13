//
//  EventosTVC.swift
//  PruebaNextia
//
//  Created by Sergio Hernández Méndez on 8/13/18.
//  Copyright © 2018 Sergio Hernández Méndez. All rights reserved.
//

import UIKit
import Alamofire

class EventosTVC: UITableViewController{
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(cargarEventos), for: .valueChanged)
        return refreshControl
    }()
    
    func cargarEventosHelper(jsonUrl: String){
        print(jsonUrl)
        guard let url = URL(string: jsonUrl) else {
            refresher.endRefreshing()
            return
        }
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else{
                self.refresher.endRefreshing()
                return
            }
            
            do {
                let eventos = try JSONDecoder().decode([Evento].self, from: data)
                Eventos.eventos = eventos
                print(eventos)
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }catch let jsonErr{
                print("Error en respuesta ......\(jsonErr)")
                self.refresher.endRefreshing()
                return
            }
        }
    }
    
    @objc func cargarEventos(){
        let jsonUrl = "http://localhost:3000/api/eventos"
        cargarEventosHelper(jsonUrl: jsonUrl)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.refreshControl = refresher
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

class BusquedaTVCell : UITableViewCell, UITextFieldDelegate{
    @IBOutlet weak var busquedaTxt: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parentTableView.cargarEventosHelper(jsonUrl: "http://localhost:3000/api/eventos/buscar/\(textField.text!)")

        return true
    }
    
    var parentTableView: EventosTVC!
}

extension EventosTVC{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let eventos = Eventos.eventos else{
            return 1
        }
        return eventos.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "busquedaTVCell", for: indexPath) as! BusquedaTVCell
            cell.parentTableView = self
            cell.busquedaTxt.delegate = cell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventoTVCell", for: indexPath) as! EventoTVCell
        cell.evento = Eventos.eventos![indexPath.row-1]
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
}
