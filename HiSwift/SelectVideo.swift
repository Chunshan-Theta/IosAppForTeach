//
//  SelectVideo.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/13.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class SelectVideo: UIViewController {

    @IBOutlet weak var Lab_VideoData: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Lab_VideoData.lineBreakMode = NSLineBreakMode.byWordWrapping
        Lab_VideoData.numberOfLines=0
        Lab_VideoData.text = HTTPRequest_Get()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func HTTPRequest_Get()->String {
        var ReData : String = "init"
        // Set up the URL request
        let url = NSURL(string: "http://140.130.36.46/api/QuizsApi/getVideo?cid=11")
        
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
