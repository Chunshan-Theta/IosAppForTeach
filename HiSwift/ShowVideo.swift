//
//  ShowVideo.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/16.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class ShowVideo: UIViewController {

    @IBOutlet weak var Maintitle: UILabel!
    @IBOutlet weak var YoutubeView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: SeleceVideoURLs);
        let requestObj = NSURLRequest(url: url! as URL);
        YoutubeView.loadRequest(requestObj as URLRequest);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func GoBack(_ sender: Any) {
        // go to Videolist
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

}
