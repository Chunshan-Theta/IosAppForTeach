//
//  ShowTest.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/28.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class TakePhoto: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let PNG404_path = "https://assets.weeblr.net/images/products/sh404sef/2015-10-14/medium/joomla-404-error-page.png"
        let url404 = NSURL(string: PNG404_path)
        let data404 = NSData(contentsOf: url404! as URL)
        imageView.image = UIImage(data: data404! as Data)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func GoBack(_ sender: Any) {
        
        // go Test table
        self.dismiss(animated: true, completion:nil)
    }
    @IBAction func goBack(_ sender: Any) {
        // go Show Test
        self.dismiss(animated: true, completion:nil)
    }
    @IBAction func TakeAPhoto(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let origImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = origImage
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func UploadIMG(_ sender: Any) {
        _ = HTTPRequest_Post()
    }
    @IBOutlet weak var MainLabel: UITextField!
    
    func HTTPRequest_Post()->String{
        var ReData : String = "init"
        // Set up the URL request
        var request = URLRequest(url: URL(string: "https://140.130.36.46/api/QuizsApi/PostAnswer")!)
        request.httpMethod = "POST"
        let param = [
            "myname"  : "name",
            "qid"    : String(SelectTestId),
            "token"  : String(UserID)!
            ] as [String : Any]
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
        request.httpBody = createBodyWithParameters(parameters: param as? [String : String], imageDataKey:imageData! as NSData) as Data
        //print(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "gg")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                self.MainLabel.text = String(describing: response)
                
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
    func createBodyWithParameters(parameters: [String: String]?,imageDataKey: NSData) -> NSData {
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
        body.appendString(string:"image=")
        body.append(imageDataKey as Data)
        //body.appendString(string: "\r\n")
        
        
        
        //body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
}


    
