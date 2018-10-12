//
//  PbTableViewController.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 3/3/17.
//  Copyright © 2017 Badoyan Arman. All rights reserved.
//

import UIKit
import CoreData

class PbTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var contacts: [Contact] = []
    var searchResult: [Contact] = []
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>!
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                contacts = fetchResultController.fetchedObjects as! [Contact]
                
            } catch {
                print(error)
            }
        }
        
        
        
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
        if searchController.isActive {
            return searchResult.count
        } else{
            return contacts.count
            
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PBTableViewCell
        
        let contact = (searchController.isActive) ? searchResult[indexPath.row] : contacts[indexPath.row]
        
        cell.NameLable?.text = contact.name
        cell.NumLable?.text = contact.num
        //cell.nkar.image = UIImage(data: contact.image! as NSData)
        
        
        cell.nkar?.image = UIImage(data: contact.image! as Data)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    // fetchRequestic heto tableViewi update
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRows(at: [_newIndexPath], with: .fade)
            }
        case .delete:
            if let _newIndexPath = newIndexPath {
                tableView.deleteRows(at: [_newIndexPath], with: .fade)
            }
        case .update:
            if let _newIndexPath = newIndexPath {
                tableView.reloadRows(at: [_newIndexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        
        contacts = controller.fetchedObjects as! [Contact]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: -Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Delete
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(actin, indexPath) -> Void in
            self.contacts.remove(at: indexPath.row)
            
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
                let contactToDelete = self.fetchResultController.object(at: indexPath) as! Contact
                
                managedObjectContext.delete(contactToDelete)
                tableView.deleteRows(at: [indexPath], with: .fade)
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
        })
        return [deleteAction]
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
     
     contacts.remove(at: indexPath.row)
     
     
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     
     */
    
    // perexod
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetall" {
            if  let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! detallViewController
                destinationController.contact = (searchController.isActive) ? searchResult[indexPath.row] : contacts[indexPath.row]
                
            }
        }
    }
    // add contact ancum
    
    @IBAction func unwindToContacts(_ segue: UIStoryboardSegue) {
        
    }
    
    // ====
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            tableView.reloadData()
            
        }
    }
    
    func filterContent(searchText: String) {
        searchResult = contacts.filter({ (Contact: Contact) -> Bool in
            let nameMatch = Contact.name.range(of: searchText)
            let numMatch = Contact.num.range(of: searchText)
            
            return nameMatch != nil || numMatch != nil
        })
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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "showDetail" {
     if let indexPath = tableView.indexPathForSelectedRow {
     let destinationController = segue.destination as! detallViewController
     destinationController.contact = contacts[indexPath.row]
     }
     }
     }
     
     @IBAction func unwindToContacts(_ segue: UIStoryboardSegue) {
     
     } */
    
}





