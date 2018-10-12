//
//  PbTableViewController.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 3/3/17.
//  Copyright © 2017 Badoyan Arman. All rights reserved.
//

import UIKit

class PbTableViewController: UITableViewController {

    var contacts: [contact] = [
        contact(name: "Putin", num: "333", image: "111.jpg"),
        contact(name: "Trump", num: "444", image: "222.jpg"),
        contact(name: "Serj", num: "2", image: "333.jpg")
    
    ]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

  
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PBTableViewCell
        
        
        
        cell.nameLable?.text = contacts[indexPath.row].name
        cell.numLable?.text = contacts[indexPath.row].num
        cell.imageView?.image = UIImage(named: contacts[indexPath.row].image)
      
 
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        
        if editingStyle == .delete {
            
            contacts.remove(at: indexPath.row)
            
            
            
            
    
     
     // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
        
        
 }
 
    // perexod
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetall" {
            if  let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! detallViewController
                destinationController.contactImage = contacts[indexPath.row].image
            
            
            }
            
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
