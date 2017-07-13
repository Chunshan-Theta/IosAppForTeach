//
//  ViewController.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/2/19.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

var UserID:String = "NoUser"
let TargetServer = "http://iselearn.im.nfu.edu.tw/api/"

class ViewController: UIViewController {
    
    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var MainButton: UIButton!
    @IBOutlet weak var Input_email: UITextField!
    @IBOutlet weak var Input_pasw: UITextField!
    @IBOutlet weak var EnterCourseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        EnterCourseButton.isEnabled=false
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
                EnterCourseButton.isEnabled = true
            }
            
        }
        
    }
    func HTTPRequest_Post()->String{
        var ReData : String = "init"
        // Set up the URL request
        var request = URLRequest(url: URL(string: TargetServer+"AccountApi/getToken")!)
        request.httpMethod = "POST"
        let param = [
            "email"  : Input_email.text!,
            "pswd"    : Input_pasw.text!
        ] as [String : Any]
        
        request.httpBody = createBodyWithParameters(parameters: param as? [String : String]) as Data
        print(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "gg")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
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
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CourseTable
        controller.PassData = "pass data hahaha"
        
    }
    */
    func createBodyWithParameters(parameters: [String: String]?) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "\(key)=\(value)")
                body.appendString(string: "&")
            }
        }
        
        //let filename = "user-profile.jpg"
        //let mimetype = "image/jpg"
        
        //body.appendString(string: "--\(boundary)\r\n")
        //body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        //body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        //body.append(imageDataKey as Data)
        //body.appendString(string: "\r\n")
        
        
        
        //body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    



}
extension NSMutableData {

        func appendString(string: String) {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
           append(data!)
        }
}


