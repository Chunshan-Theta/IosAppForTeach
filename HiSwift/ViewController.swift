//
//  ViewController.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/2/19.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var MainButton: UIButton!
    @IBOutlet weak var Input_email: UITextField!
    @IBOutlet weak var Input_pasw: UITextField!
    var UserID:String = "NoUser"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showMessage() {
        if Input_email.text==""{
           MainLabel.text = "信箱未填"
        }
        else if Input_pasw.text==""{
            MainLabel.text = "密碼未填"
        }
        else{
            UserID = HTTPRequest_Post()
            if UserID == "Account not Registed"{
                MainLabel.text = "Account not Registed"
            }
            else{
                MainLabel.text!="您的ＩＤ："+UserID
                MainButton.isEnabled = false
            }
            
        }
        
    }
    func HTTPRequest_Post()->String{
        var ReData : String = "init"
        // Set up the URL request
        var request = URLRequest(url: URL(string: "http://140.130.36.111/api/AccountApi/getToken")!)
        request.httpMethod = "POST"
        let postString = "email="+Input_email.text!+"&pswd="+Input_pasw.text!
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
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            ReData = String(data: data, encoding: .utf8) ?? "responds can't convert 2 String"
            //print(ReData)
        }
        task.resume()
        while ReData == "init"{
            //print("wait responds")
        }
        let StringRange = ReData.index(ReData.startIndex, offsetBy: 1)..<ReData.index(ReData.startIndex, offsetBy: ReData.lengthOfBytes(using: .utf8)-1)
        ReData = ReData.substring(with: StringRange)   // Hello
        
        return ReData
    }
    
}

