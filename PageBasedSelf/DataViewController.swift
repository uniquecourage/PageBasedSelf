//
//  DataViewController.swift
//  PageBasedSelf
//
//  Created by 林金龍 on 2015/9/1.
//  Copyright (c) 2015年 林金龍. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var labelWeapon: UILabel!
    
    
    @IBOutlet weak var labelPoem: UILabel!
    var dataObject: AnyObject?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            var content:String = obj.description
            var result:Array<String> = content.componentsSeparatedByString("|")
            self.dataLabel.text = result[0]
            self.labelWeapon.text = result[1]
            self.labelPoem.text = result[2]
            self.labelPoem.numberOfLines = 0 //設定label可以顯示幾行，0為不限制
        }
    }


}

