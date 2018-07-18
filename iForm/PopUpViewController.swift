//
//  PopUpViewController.swift
//  iForm
//
//  Created by Vahid Ghanbarpour on 7/24/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 0.1 * popupView.bounds.size.width
        popupView.layer.cornerRadius = 0.1 * popupView.bounds.size.height
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Close(_ sender: UIButton) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    @IBAction func wordSelected(_ sender: UIButton) {
        let id = UserDefaults.standard.string(forKey: "id")!
        let url = URL(string: "https://jahanco.net/api/iform/v1/downloadForm?itemId=\(id)&type=docx")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func PDFSelected(_ sender: UIButton) {
        let id = UserDefaults.standard.string(forKey: "id")!
        let url = URL(string: "https://jahanco.net/api/iform/v1/downloadForm?itemId=\(id)&type=pdf")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
