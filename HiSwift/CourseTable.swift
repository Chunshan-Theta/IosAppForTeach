//
//  CourseTable.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/14.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class CourseTable: UITableViewController {

    //var PassData:String="init"
    var items = ["Item 1", "Item 2", "Item 3","123"]
    var IdForCourse = [11,2,33,42]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserID)
        //get data of Course and decode json String
        let jsonString = "{\"content\":"+HTTPRequest_Get()+"}"
        let data = jsonString.data(using: .utf8)!
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
            let Content = parsedData["content"] as! [[String:Any]]
            let name = Content[0]["name"]!
            print(name)
        }
        
        
        
        navigationItem.title = "hello TableView"
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        
        
        tableView.sectionHeaderHeight = 50
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath as IndexPath) as! MyCell
        myCell.nameLabel.text = items[indexPath.row]
        myCell.myTableViewController = self
        return myCell
    }
    
    
    func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            items.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
    }
    func printH(cell: UITableViewCell){
        //print("hello world")
        let index = tableView.indexPath(for: cell)?.row ?? 11
        print(index)
        print(IdForCourse[index])
    }

    func HTTPRequest_Get()->String { // Getting data of course
        var ReData : String = "init"
        // Set up the URL request
        let url = NSURL(string: "http://140.130.36.111/api/QuizsApi/Course")
        
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


// custom class of cell
class MyCell: UITableViewCell {
    
    var myTableViewController: CourseTable?
    
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
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(MyCell.handleAction), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": actionButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]))
        
    }
    
    func handleAction() {
        //myTableViewController?.deleteCell(cell: self)
        myTableViewController?.printH(cell:self)
    }
    
}
