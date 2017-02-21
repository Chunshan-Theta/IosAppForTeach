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
        let todoEndpoint: String = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.js"
        guard let url = NSURL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(url: url as URL)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            if let error = error {
                print(error)
            }
            
            if let data = data{
                print("data =\(NSString(data: data, encoding:String.Encoding.utf8.rawValue) as String?)")
            }
            if let response = response {
                
                //print("response = \(response)")
                let httpResponse = response as! HTTPURLResponse
                print("response code = \(httpResponse.statusCode)")
            }
            
            
        })
        task.resume()
        
    }
    
    
}

