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
        let reback :String =  HTTPRequest_Get()
        print(reback)
        
        
    }
    func HTTPRequest_Get()->String {
        var ReData : String = "First"
        ReData = "fuck"
        // Set up the URL request
        let url = NSURL(string: "http://140.130.36.221/README.txt")
        
        let task = URLSession.shared.dataTask(with: url! as URL) {
            (data, response, error)->Void in if data != nil{
                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
                ReData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                
            }else{print("no data error") }
            
        }
        
        
        task.resume()
        sleep(1)
        return ReData
        
        
    }
    func HTTPRequest_Post(){
        // Set up the URL request
        let url4 = NSURL(string: "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.js")
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4 as! URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "data=Hello"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(dataString)")
        }
        task.resume()
    }
    
    
}

