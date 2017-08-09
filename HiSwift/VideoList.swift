//
//  VideoList.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/16.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit
var SeleceVideoURLs:String = "init"
class VideoList: UITableViewController {
    //init var
    var VideoListData:[[String:Any]]=[]
    var VideoIDs = [0]
    var VideoNames = ["init"]
    var VideoUrls = ["init"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        //get data of Course and decode json String
        let jsonString = "{\"content\":"+HTTPRequest_Get()+"}"
        let data = jsonString.data(using: .utf8)!
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
            VideoListData = parsedData["content"] as! [[String:Any]]//id , name , URL
            print(VideoListData[0])
        }
        
        // update names ,id and URLs
        VideoIDs = []
        VideoNames = []
        VideoUrls = []
        for VideoUnit in VideoListData {
            print(VideoUnit["name"] ?? "can't getting name")
            VideoNames.append((VideoUnit["name"] as! String?)!)
            VideoUrls.append((VideoUnit["URL"] as! String?)!)
            VideoIDs.append((VideoUnit["id"] as! Int?)!)
        }
        
        
        
        
        // goback button
        let backButton = UIBarButtonItem(
            title: "back",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(self.goback)
        )
        
        //init custom class of Table Cell
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cellId")
        tableView.sectionHeaderHeight = 50
        
        // 導覽列 update        
        navigationItem.title = "select course video"
        navigationItem.leftBarButtonItem = backButton
        
    }
    func goback(){
        // go Course table
        self.dismiss(animated: true, completion:nil)
    }
    
    //UPDATE tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath as IndexPath) as! VideoCell
        myCell.nameLabel.text = VideoNames[indexPath.row]
        myCell.myTableViewController = self
        return myCell
    }
    
    
    
    func printH(cell: UITableViewCell){
        //print data
        let index = tableView.indexPath(for: cell)?.row ?? 11
        print("Video Index:" + String(index))
        print("Video ID:" + String(VideoIDs[index]))
        
        //update data
        SeleceVideoURLs = VideoUrls[index]
        
        // go to VideoList
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeShow")
        self.present(vc!, animated: true, completion: nil)
    }
    func HTTPRequest_Get()->String {
        var ReData : String = "init"
        // Set up the URL request
        let url = NSURL(string: TargetServer+"QuizsApi/getVideo?cid="+String(SeleceCourseID))
        
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


// custom class of cell
class VideoCell: UITableViewCell {
    
    var myTableViewController: VideoList?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("video", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(VideoCell.handleAction), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": actionButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]))
        
    }
    
    func handleAction() {
        //myTableViewController?.deleteCell(cell: self)
        myTableViewController?.printH(cell:self)
    }
    
}

