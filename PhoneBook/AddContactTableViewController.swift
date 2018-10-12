//
//  AddContactTableViewController.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 1/24/18.
//  Copyright © 2018 Badoyan Arman. All rights reserved.
//

import UIKit
import CoreData

class AddContactTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var numTextField:UITextField!
    
    
      var contact: Contact!
    
    

    
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
    
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    tableView.deselectRow(at: indexPath, animated: true)
    // select arac nkar@ ira image view vra pahelu hamar
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
 
    }
    // savei avelacum
    @IBAction func save(_sender:UIBarButtonItem){
        let name = nameTextField.text
        let num = numTextField.text
        
        // toxeri lracman stugum
        if name == "" && num == "" {
            let alertController = UIAlertController(title: "CHSATACVEC", message: "Toxeric mek@ petqe lracnel", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        // xranilisha
        if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
            contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: managedObjectContext) as! Contact

            contact.name = name!
            contact.num = num!
            if let contactImage = imageView.image{
                contact.image = UIImagePNGRepresentation(contactImage)! as Data
        }
            do {
                try managedObjectContext.save()
            }catch {
                print(error)
                return
            }

        }
 
        
        // consulum grancel
       // print("Name: \(name!)")
       //print("Num: \(num!)")
        
        dismiss(animated: true, completion: nil)
    }
}

