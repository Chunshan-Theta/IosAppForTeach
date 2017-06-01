//
//  TitleBarPage.swift
//  HiSwift
//
//  Created by Theta Wang on 2017/4/15.
//  Copyright © 2017年 Theta Wang. All rights reserved.
//

import UIKit

class TitleBarPage: UINavigationController {

    var PassData:String = "init"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(PassData)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CourseTable
        controller.PassData = "pass data hahaha"
        
    }

}
