//
//  Course.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/3/28.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//
import UIKit

class Course: UIViewController {
    
    var PassData:String="No Geting Data"
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var MainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        MainLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        MainLabel.numberOfLines = 0
        MainLabel.text = HTTPRequest_Get()
        TitleLabel.text = PassData
        let jsonString = "{\"content\":"+HTTPRequest_Get()+"}"
        let data = jsonString.data(using: .utf8)!
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
            let Content = parsedData["content"] as! [[String:Any]]
            let name = Content[0]["name"]!
            print(name) 
        }
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func HTTPRequest_Get()->String {
        var ReData : String = "init"
        // Set up the URL request
        let url = NSURL(string: TargetServer+"AccountApi/Course")
        
        let task = URLSession.shared.dataTask(with: url! as URL) {
            (data, response, error)->Void in if data != nil{
                //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
                ReData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                
            }else{print("no data error") }
            
        }
        
        
        task.resume()
        while ReData == "init"{
            //print("wait responds")
        }
        
        return ReData
        
        
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
