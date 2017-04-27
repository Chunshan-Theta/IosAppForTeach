//
//  ShowTest.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/26.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class TestList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(HTTPRequest_Get())
        
        
        // goback button
        let backButton = UIBarButtonItem(
            title: "back",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(self.goback)
        )
        
        
        // 導覽列 update
        navigationItem.title = "select Test"
        navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func printH(cell: UITableViewCell){
        print("clicked!")
        //print data
        //let index = tableView.indexPath(for: cell)?.row ?? 11
        //print("Video Index:" + String(index))
        //print("Video ID:" + String(VideoIDs[index]))
        
        //update data
        //SeleceVideoURLs = VideoUrls[index]
        
        // go to VideoList
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeShow")
        //self.present(vc!, animated: true, completion: nil)
    }
    
    func goback(){
        // go Course table
        self.dismiss(animated: true, completion:nil)
    }

}




// custom class of cell
class TestCell: UITableViewCell {
    
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
        button.setTitle("show", for: .normal)
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

