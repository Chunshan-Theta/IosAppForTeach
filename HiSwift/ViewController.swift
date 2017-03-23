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
    @IBAction func POSTBUTTON(_ sender: Any) {
        let reback :String =  HTTPRequest_Post()
        print(reback)
    }
    func HTTPRequest_Get()->String {
        var ReData : String = "init"
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
    func HTTPRequest_Post()->String{
        var ReData : String = "init"
        ReData = "init2"
        // Set up the URL request
        var request = URLRequest(url: URL(string: "http://www.thisismylink.com/postName.php")!)
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        return ReData
    }
    
    
}

