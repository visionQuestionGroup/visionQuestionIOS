//
//  MainMenuViewController.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/17/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let imagePick = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func takePictures(sender: AnyObject) {
    
        let cameraVC = storyboard?.instantiateViewControllerWithIdentifier("cameraVC") as! CameraViewController
        
        presentViewController(cameraVC, animated: true, completion: nil)
        
        
    }

    
    @IBAction func playGame(sender: AnyObject) {
        

        
        let playGameVC = storyboard?.instantiateViewControllerWithIdentifier("playGameVC") as! PlayGameViewController
        
        self.navigationController?.pushViewController(playGameVC, animated: true)
        
    }
    
    @IBAction func logOut(sender: AnyObject) {
        
        RailsRequest.session().username = ""
        RailsRequest.session().firstName = ""
        RailsRequest.session().lastName = ""
        RailsRequest.session().password = ""
        RailsRequest.session().email = ""
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
