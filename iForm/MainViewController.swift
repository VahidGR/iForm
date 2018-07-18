//
//  MainViewController.swift
//  iForm
//
//  Created by Vahid Ghanbarpour on 7/19/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!    
    @IBOutlet weak var footerImage: UIImageView!
        
    @IBAction func Button1(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tableID", sender: self)
        let catagoryID = "2"
        UserDefaults.standard.set(String(describing: catagoryID), forKey: "cID")
        UserDefaults.standard.synchronize()
    }
    @IBAction func Button2(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tableID", sender: self)
        let catagoryID = "1"
        UserDefaults.standard.set(String(describing: catagoryID), forKey: "cID")
        UserDefaults.standard.synchronize()
    }
    @IBAction func Button3(_ sender: UIButton) {
        self.performSegue(withIdentifier: "htmlShow", sender: self)
    }
    @IBAction func Button4(_ sender: UIButton) {
        print("Four")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
