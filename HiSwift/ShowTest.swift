//
//  ShowTest.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/28.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class ShowTest: UIViewController {
    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var ShowImage: UIImageView!
    //init var
    var TestData:[String:Any]=[:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get data of Course and decode json String
        let data = HTTPRequest_Get().data(using: .utf8)!
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
            TestData = parsedData //"Time_close","remark","DateTime","image","id"
            print(TestData["id"] ?? "error")
        }
        
        //show image
        let dataDecoded:NSData = NSData(base64Encoded: TestData["image"] as! String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        if let decodedimage = UIImage(data: dataDecoded as Data){
            //print(decodedimage)
            ShowImage.image = decodedimage
        }
        else{
            
            MainLabel.text = "no pic , go back plz"
        }
        
    

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func GoBack(_ sender: Any) {
        
        // go Test table
        self.dismiss(animated: true, completion:nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func HTTPRequest_Get()->String {
        var ReData : String = "init"
        // Set up the URL request
        let url = NSURL(string: "http://140.130.36.111/api/QuizsApi/GetQuiz?id="+String(SelectTestId))
        
        let task = URLSession.shared.dataTask(with: url! as URL) {
            (data, response, error)->Void in if data != nil{
                //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
                ReData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                
            }else{print("no data error") }
            
        }
        
        
        task.resume()
        while ReData == "init"{
            //print("wait responds")
        }
        
        return ReData
        
        
    }
}
