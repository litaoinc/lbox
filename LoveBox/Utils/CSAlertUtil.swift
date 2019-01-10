//
//  CSAlertUtil.swift
//  LoveBox
//
//  Created by litao on 2018/12/28.
//  Copyright © 2018年 shu. All rights reserved.
//

import UIKit

class CSAlertUtil: NSObject {
    public static let shared = CSAlertUtil()
    
    func showMessage(viewController : UIViewController,
                     title:String?, msg:String?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBtn)
        viewController.present(alert, animated: true, completion: nil)
    }
}
