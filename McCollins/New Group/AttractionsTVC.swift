//
//  AttractionsTVC.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/31/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class AttractionsTVC: UITableViewController {


    
    @IBOutlet var tblAttractions: UITableView!
    var listAttractions : [Attraction] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tblAttractions.reloadData()
            }
        }
    }
    
    var userID : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ATTRACTIONS"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground")!)
        userID = "noh@email.com"
//        var errMsg : String?
        SVProgressHUD.show()
        APIHandler.sharedInstance.getAttractions(email: userID!) { (listAttractions, errMsg) in
            SVProgressHUD.dismiss()
            if errMsg == nil{
                self.listAttractions = listAttractions!
            } else{
                print(errMsg)
            }
        }
        
        tblAttractions.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return listAttractions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAttractions.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AttractionCell
        let attObj = listAttractions[indexPath.row]
        DispatchQueue.main.async {
            cell?.backgroundColor = .clear
            cell?.lblName.text = attObj.title
            cell?.lblTiming.text = attObj.timing
            cell?.lblContact.text = attObj.contact
            //        cell?.lblDistance.text =
            cell?.lblDescription.text = attObj.desc
            if let url = URL(string: attObj.img!){
                cell?.attImage.sd_setImage(with: url, placeholderImage: UIImage.init(named: "No image available"))
            }
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlStr = listAttractions[indexPath.row].siteLink
        let url = URL(string: urlStr!)
        if #available(iOS 10.0, *){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Settings") as? Settings
        vc?.userID = userID
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
