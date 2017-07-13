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
        //print(data)
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [[String:Any]] {
            TestData = parsedData[0] //"Time_close","remark","DateTime","image","id","path"
            //print(TestData["id"] ?? "error")
            //print(TestData["path"] ?? "error")
        }
        /*
        let halfpath = "http://iselearn.im.nfu.edu.tw"+(TestData["path"] as! String)
        let urlwithPercentEscapes = halfpath.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let PNG404_path = urlwithPercentEscapes
        print(PNG404_path ?? "fuck")
        let url404 = NSURL(string: PNG404_path!)
        let data404 = NSData(contentsOf: url404! as URL)
        ShowImage.image = UIImage(data: data404! as Data)
        */
        
        
        var target_path :String = "init"
        let PNG404_path = "https://assets.weeblr.net/images/products/sh404sef/2015-10-14/medium/joomla-404-error-page.png"
        if String(describing: TestData["path"]) != ""{
             let halfpath = "http://iselearn.im.nfu.edu.tw"+(TestData["path"] as! String)
             target_path = halfpath.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
             print(target_path)
             print(PNG404_path)
             print(PNG404_path)
        }
        let url404 = NSURL(string: PNG404_path)
        let data404 = NSData(contentsOf: url404! as URL)
        ShowImage.image = UIImage(data: data404! as Data)
        
        if let Turl = NSURL(string: target_path){
                if let Tdata = NSData(contentsOf: Turl as URL) {
                     ShowImage.image = UIImage(data: Tdata as Data)
                }
            print(Turl)
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
        let url = NSURL(string: TargetServer+"QuizsApi/GetQuizPart?status=1&token=null&qid="+String(SelectTestId))
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
