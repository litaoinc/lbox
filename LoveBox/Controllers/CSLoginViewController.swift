//
//  CSLoginViewController.swift
//  LoveBox
//
//  Created by kx on 2019/1/4.
//  Copyright © 2019年 shu. All rights reserved.
//

import UIKit

class CSLoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let bottomLineForName = CALayer()
        bottomLineForName.frame = CGRect(x: 0, y: nameTextField.frame.height-1, width: nameTextField.frame.width, height: 1)
        bottomLineForName.backgroundColor = UIColor.lightGray.cgColor
        nameTextField.layer.addSublayer(bottomLineForName)
        
        let bottomLineForPass = CALayer()
        bottomLineForPass.frame = CGRect(x: 0, y: nameTextField.frame.height-1, width: nameTextField.frame.width, height: 1)
        bottomLineForPass.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.layer.addSublayer(bottomLineForPass)
        
        nameTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    }
    
    @objc
    func handleTextChanged() {
        if (!(nameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)) {
            loginBtn.isEnabled = true
        } else {
            loginBtn.isEnabled = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
