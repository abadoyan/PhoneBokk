//
//  detallViewController.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 1/21/18.
//  Copyright © 2018 Badoyan Arman. All rights reserved.
//

import UIKit


class detallViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    // nkar@ kcum enq codi het
    
    @IBOutlet var contactImageView: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
   //  var contact = Contact(name: "", num: "", image: "")
    
    
    
    
    var contact: Contact!
      var contactImage = ""
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    contactImageView.image = UIImage(data: contact.image! as Data)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // inchqan tox u syun petqa veradarcni
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! detallTableViewCell
        switch indexPath.row{
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = contact.name
        case 1:
            cell.fieldLabel.text = "Num"
            cell.valueLabel.text = contact.num
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""

        }
        
        return cell
    }
    
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



