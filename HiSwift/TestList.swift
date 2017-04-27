//
//  ShowTest.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/26.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class TestList: UITableViewController {
    //init var
    var TestListData:[[String:Any]]=[]
    var TestDateTime = ["init"]
    var Testremark = ["init"]
    var TestName = ["init"]
    var Testid = [0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get data of Course and decode json String
        let jsonString = "{\"content\":"+HTTPRequest_Get()+"}"
        let data = jsonString.data(using: .utf8)!
        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
            TestListData = parsedData["content"] as! [[String:Any]]//"DateTime",remark", "id", "Name"
            print(TestListData)
        }
        
        
        // update names ,id and URLs
        
        TestDateTime = []
        Testremark = []
        TestName = []
        Testid = []
        for TestUnit in TestListData {
            
            //TestDateTime.append((TestUnit["DateTime"] as! String?)!)
            //Testremark.append((TestUnit["remark"] as! String))
            
            TestName.append((TestUnit["Name"] as! String?)!)
            Testid.append((TestUnit["id"] as! Int?)!)
        }
        
        
        
        // goback button
        let backButton = UIBarButtonItem(
            title: "back",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(self.goback)
        )
        
        //init custom class of Table Cell
        tableView.register(TestCell.self, forCellReuseIdentifier: "cellId")
        tableView.sectionHeaderHeight = 50
        
        // 導覽列 update
        navigationItem.title = "select Test"
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func printH(cell: UITableViewCell){
        print("clicked!")
        
    }
    
    func goback(){
        // go Course table
        self.dismiss(animated: true, completion:nil)
    }
    //UPDATE tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(TestName.count)
        return TestName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath as IndexPath) as! TestCell
        myCell.nameLabel.text = TestName[indexPath.row]
        myCell.myTableViewController = self
        return myCell
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
        let url = NSURL(string: "http://140.130.36.111/api/QuizsApi/GetQuizPart?status=0&token=gldpbxbr&qid=")

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
class TestCell: UITableViewCell {
    
    var myTableViewController: TestList?
    
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
        button.setTitle("show", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(TestCell.handleAction), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": actionButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]))
        
    }
    
    func handleAction() {
        //myTableViewController?.deleteCell(cell: self)
        myTableViewController?.printH(cell:self)
    }
    
}

