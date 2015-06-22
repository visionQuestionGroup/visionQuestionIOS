//
//  LoginViewController.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/17/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

// Use stringByReplacingOccurencesOfString for dealing with spaces in login/registration.

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func finishButtonPressed(sender: CustomButton) {
        
        if usernameField.text.isEmpty == false && passwordField.text.isEmpty == false {
            
            errorLabel.text = ""
            
            RailsRequest.session().username = usernameField.text
            RailsRequest.session().password = passwordField.text
            
            RailsRequest.session().login({ () -> Void in
                
                println("Login storyboard transition should perform now.")
                
                let mainMenu = self.storyboard?.instantiateViewControllerWithIdentifier("mainMenu") as! MainMenuViewController
                
                self.navigationController?.pushViewController(mainMenu, animated: true)

            })
            
            
            

            
            
        } else {
            
            errorLabel.text = "Please ensure that all fields have been completed."
            
        }
        
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = ""
        
//        self.emailField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}







