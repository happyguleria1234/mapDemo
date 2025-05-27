//
//  LoginVC.swift
//  mapDemo
//
//  Created by Happy Guleria on 12/05/25.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var btn_eye: UIButton!
    @IBOutlet weak var email_view: UIView!
    @IBOutlet weak var password_view: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewLyout(view: email_view, borderColor: UIColor.lightGray, borderWidth: 1.0, cornerRadius: 5, shadowColor: UIColor(red: 238, green: 238, blue: 238, alpha: 1), backgroundColor: UIColor(red: 238, green: 238, blue: 238, alpha: 1))
        
        setViewLyout(view: password_view, borderColor: UIColor.lightGray, borderWidth: 1.0, cornerRadius: 5, shadowColor: UIColor(red: 238, green: 238, blue: 238, alpha: 1), backgroundColor: UIColor(red: 238, green: 238, blue: 238, alpha: 1))


    }
    
    func setViewLyout(view:UIView,borderColor: UIColor, borderWidth: CGFloat,cornerRadius: CGFloat,shadowColor: UIColor,backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
        view.layer.shadowColor = shadowColor.cgColor
    }
    
    @IBAction func btn_eye_Action(_ sender: UIButton) {
        sender.isSelected.toggle()
        tf_password.isSecureTextEntry.toggle()
    }
    
}
