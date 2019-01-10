//
//  CSRegisterViewController.swift
//  LoveBox
//
//  Created by kx on 2019/1/4.
//  Copyright © 2019年 shu. All rights reserved.
//

import UIKit
import Log
import MBProgressHUD

class CSRegisterViewController: UIViewController {
    private let logger = Logger()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cancel"), style: UIBarButtonItem.Style.done, target: self, action: #selector(dissmissSelf))
        
        let bottomLineForName = CALayer()
        bottomLineForName.frame = CGRect(x: 0, y: nameTextField.frame.height-1, width: nameTextField.frame.width, height: 1)
        bottomLineForName.backgroundColor = UIColor.lightGray.cgColor
        nameTextField.layer.addSublayer(bottomLineForName)
        
        let bottomLineForPass = CALayer()
        bottomLineForPass.frame = CGRect(x: 0, y: nameTextField.frame.height-1, width: nameTextField.frame.width, height: 1)
        bottomLineForPass.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.layer.addSublayer(bottomLineForPass)
        
        let bottomLineForRePass = CALayer()
        bottomLineForRePass.frame = CGRect(x: 0, y: nameTextField.frame.height-1, width: nameTextField.frame.width, height: 1)
        bottomLineForRePass.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.layer.addSublayer(bottomLineForRePass)
        
        nameTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        repasswordTextField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    }
    
    @IBAction func handleRegister(_ sender: Any) {
        if (passwordTextField.text != repasswordTextField.text) {
            let toast = MBProgressHUD.showAdded(to: self.view, animated: true)
            toast.label.text = "密码输入不一致"
            toast.mode = .text
            toast.hide(animated: true, afterDelay: 2)
        }
    }
    
    @objc
    func handleTextChanged() {
        if (!(nameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) && !(repasswordTextField.text?.isEmpty ?? true)) {
            registerBtn.isEnabled = true
        } else {
            registerBtn.isEnabled = false
        }
    }
    
    @objc
    func dissmissSelf() {
        self.dismiss(animated: true, completion: nil)
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
