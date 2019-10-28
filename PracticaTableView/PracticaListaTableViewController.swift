//
//  PracticaListaTableViewController.swift
//  PracticaTableView
//
//  Created by Raul Armas Santiago on 10/9/19.
//  Copyright © 2019 Sento40. All rights reserved.
//

import UIKit

class PracticaListaTableViewController: UITableViewController {
    
    var list = [String]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = defaults.stringArray(forKey: "Items") ?? [String]()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alertDelete = UIAlertController(title: "Borrar Usuario", message: "Seguro que desea borrar el usuario ", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Si", style: .default, handler: {(UIAlertAction) -> Void in self.list.remove(at: indexPath.row)
                self.defaults.set(self.list, forKey: "Items")
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            })
            let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
            
            alertDelete.addAction(yesAction)
            alertDelete.addAction(noAction)
            
            present(alertDelete,animated: true, completion: nil)
            
            /*self.list.remove(at: indexPath.row)
            self.defaults.set(self.list, forKey: "Items")
            tableView.deleteRows(at: [indexPath], with: .automatic)*/
            
            /*
            
            let alertDelete = UIAlertController(title: "Borrar Usuario", message: "Seguro que desea borrar el usuario ", preferredStyle: .alert)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let yesAction = UIAlertAction(title: "Si", style: .default){[unowned self] action in
                self.list.remove(at: indexPath.row)
                self.defaults.set(self.list, forKey: "Items")
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            
            let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
            
            alertDelete.addAction(yesAction)
            alertDelete.addAction(noAction)
            
            present(alertDelete,animated: true, completion: nil)*/
        }
        
        
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Agrega nueva tarea", message: "Porfavor ingresa la tarea en la caja de texto", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: .default) {[unowned self] action in
            guard let textField = alertController.textFields?.first, let item = textField.text else { return }
            
            self.list.append(item)
            self.tableView.reloadData()
            
            self.defaults.set(self.list, forKey: "Items")
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController,animated: true, completion: nil)
    }
}
