//
//  ViewController.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/2/19.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var Mainlab: UILabel!
    @IBAction func showMessage(_ sender: Any) {
        Mainlab.text = "HI"
    }
    @IBAction func HTTPRequest(_ sender: Any) {
        // Set up the URL request
        let url = NSURL(string: "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.js")
        
        let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        
        task.resume()
        
        
        
    }
    
    
}

