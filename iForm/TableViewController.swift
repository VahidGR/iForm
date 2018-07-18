//
//  TableViewController.swift
//  iForm
//
//  Created by Vahid Ghanbarpour on 7/19/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    func StartIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func LoadData() {
        let catagoryid = UserDefaults.standard.string(forKey: "cID")!
        let url = "https://jahanco.net/api/iform/v1/getItems?categoryId=\(catagoryid)"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.result.value!)
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.table.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message:"No such data!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}
                }
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message:"Something is wrong!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
        }
    }
    
    func EndIndicator() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        StartIndicator()
        LoadData()
    }
    
    @objc func downloadPressed() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @objc func previewPressed() {
        self.performSegue(withIdentifier: "preview", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableDetailsVCTableViewCell
        var dict = arrRes[indexPath.row]
        cell.lable?.text = dict["title"] as? String
        cell.dlB?.addTarget(self, action: #selector(downloadPressed), for: .touchUpInside)
        cell.pvB?.addTarget(self, action: #selector(previewPressed), for: .touchUpInside)
        cell.dlB.layer.cornerRadius = 0.1 * cell.dlB.bounds.size.width
        cell.dlB.layer.cornerRadius = 0.1 * cell.dlB.bounds.size.height
        cell.pvB.layer.cornerRadius = 0.1 * cell.pvB.bounds.size.width
        cell.pvB.layer.cornerRadius = 0.1 * cell.pvB.bounds.size.height
        let imageCount = dict["image_count"] as! String
        let ID = dict["id"] as! Int
        let idString = "\(ID)"
        UserDefaults.standard.set(String(describing: imageCount), forKey: "imageC")
        UserDefaults.standard.set(String(describing: idString), forKey: "id")
        UserDefaults.standard.synchronize()
        EndIndicator()

        return cell
    }
}
