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
        print(data)
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [[String:Any]] {
            TestData = parsedData[0] //"Time_close","remark","DateTime","image","id","path"
            print(TestData["id"] ?? "error")
            print(TestData["path"] ?? "error")
        }
        var target_path :String = "init"
        if String(describing: TestData["path"]) != ""{
            target_path = "http://140.130.33.228"+(TestData["path"] as! String)
            target_path = "http://play.fisher-price.com/en_US/Images/lnl_123_game_tcm1404-73099.png"
            print(target_path)
        }
        else{
            MainLabel.text = "no pic"
        }
        if let url = NSURL(string: target_path ) {
                if let data = NSData(contentsOf: url as URL) {
                    
                    ShowImage.image = UIImage(data: data as Data)
                }        
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
        let url = NSURL(string: "http://140.130.36.46/api/QuizsApi/GetQuizPart?status=0&token=null&qid="+String(SelectTestId))
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
}
