//
//  PicSelectorViewController.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/17/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import AmazonS3RequestManager
import AFNetworking
import AFAmazonS3Manager


class PicSelectorViewController: UIViewController, UITextFieldDelegate {

    let s3Manager = AFAmazonS3Manager(accessKeyID: accessKey, secret: secret)
    
    let username = RailsRequest.session().username
    
    var myImage: UIImage!
    
    var resizedImage: UIImage?
    
    var myUsername: String = RailsRequest.session().username
    
    var newURL: String!
    
    var imageURL: String!
    
    
    @IBOutlet weak var newlyChosenPhoto: UIImageView!
    
    @IBOutlet weak var answerField: UITextField!
    
    
    @IBAction func takeAnotherButtonPressed(sender: AnyObject) {
        
        if answerField.text != "" {
    
            imageResize()
            
//            let cameraVC = storyboard?.instantiateViewControllerWithIdentifier("cameraVC") as! CameraViewController
            
            dismissViewControllerAnimated(true, completion: nil)
            
//            presentViewController(cameraVC, animated: true, completion: nil)
    
        } else {
            
            answerField.placeholder = "Please add an answer!"
            
        }
        
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
    
        if answerField.text != "" {
        
            imageResize()
            
            let goodJobVC = storyboard?.instantiateViewControllerWithIdentifier("goodJobVC") as! GoodJobViewController
          
            presentViewController(goodJobVC, animated: true, completion: nil)
        
        } else {
            
               answerField.placeholder = "Please add an answer!"
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newlyChosenPhoto.image = myImage
        
        println(myUsername)
        
        println(RailsRequest.session().token)
        
    }

    func imageResize() {
        
        var newSize = CGSize(width: 480,height: 640)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        // image is a variable of type UIImage
        myImage?.drawInRect(rect)
        
        self.resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        saveImageToS3(resizedImage!)
        
      
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    

    
    func saveImageToS3(image: UIImage) {
        
        s3Manager.requestSerializer.bucket = bucket
        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion
//        s3Manager.requestSerializer.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        
        let timestamp = Int(NSDate().timeIntervalSince1970)
        
        let imageName = "\(username)_\(timestamp)"
        
        let imageData = UIImagePNGRepresentation(image)
        
        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
            
            println(imageName)
            
            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
            
            println(filePath)
            
            imageData.writeToFile(filePath, atomically: false)
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            
            s3Manager.putObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                
                let percentageWritten = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite) * 100.0)
                
                println("Uploaded \(percentageWritten)%")
                
                }, success: { (responseObject) -> Void in
                    
                    let info = responseObject as! AFAmazonS3ResponseObject
                    
                    self.newURL = info.URL.absoluteString
                    
                    RailsRequest.session().postImage(self.newURL, answer: self.answerField.text, completion: { () -> Void in
                        
                        
                    })
                    
                    println("\(responseObject)")
                    
                }, failure: { (error) -> Void in
                    
                    println("\(error)")
                    
            })
            
            
        }
        
        
        
        
        
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
