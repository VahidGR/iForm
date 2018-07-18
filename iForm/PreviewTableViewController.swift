//
//  PreviewTableViewController.swift
//  iForm
//
//  Created by Vahid Ghanbarpour on 7/23/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PreviewTableViewController: UITableViewController {

    @IBAction func downloadButton(_ sender: UIBarButtonItem) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 667
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let imageC = UserDefaults.standard.string(forKey: "imageC")!
        let imageCount: Int = Int(imageC)!
        
        return imageCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        
        let imageC = UserDefaults.standard.string(forKey: "imageC")!
        let id = UserDefaults.standard.string(forKey: "id")!
        let url = "https://jahanco.net/api/iform/v1/downloadImage?id=\(id)&number=\(imageC)"
        self.downloadImage(url, inView: cell.formImage)
        
        return cell
    }
    
    func downloadImage(_ uri : String, inView: UIImageView) {
        
        let url = URL(string: uri)
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                    
                }else {
                    let alert = UIAlertController(title: "Error", message:"No data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}
                }
            }else{
                let alert = UIAlertController(title: "Error", message:"\(error!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
        }
        task.resume()
    }
}
