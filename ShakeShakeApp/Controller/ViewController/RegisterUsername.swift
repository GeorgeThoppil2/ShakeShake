//
//  RegisterUsername.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-08.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase

class RegisterUsername: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var usernameInput: UITextField!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //add a bottom border and set the placeholder for the username textfield
        usernameInput.setBottomBorder()
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Enter your username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.string(forKey: "Username") != nil  {
            performSegue(withIdentifier: "goToHomePage", sender: self)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
    
    
    
    //  =========================================================
    //  Method: registerUsername
    //  Desc: Set username default
    //  Args:   sender
    //  Return: None
    //  =========================================================
    @IBAction func registerUsername(_ sender: Any) {
        
        //set username and default highscore on register
        defaults.set(usernameInput.text!, forKey: "Username")
        defaults.set("0", forKey: "Highscore")
        
        performSegue(withIdentifier: "goToHomePage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePage" {
            if let destinationVC = segue.destination as? MainMenu {
                if let userName =  defaults.string(forKey: "Username"), let highScore = defaults.string(forKey: "Highscore")  {
                       destinationVC.userNameFromSegue = userName
                       destinationVC.highScoreFromSegue = highScore
                }
                
                
            }
        }
    }
}

extension UITextField {
    
    //  =========================================================
    //  Method: setBottomBorder
    //  Desc: Sets a UITextField bottom border
    //  Args:   None
    //  Return: None
    //  =========================================================
    func setBottomBorder() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}