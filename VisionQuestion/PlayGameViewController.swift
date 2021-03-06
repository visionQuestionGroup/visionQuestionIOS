//
//  PlayGameViewController.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/17/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

var countNumber = 0
var globalScore = 0

class PlayGameViewController: UIViewController {

    @IBOutlet weak var currentScoreLabel: UILabel!

    @IBOutlet weak var currentGamePic: UIImageView!
    
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var answerButton: CustomButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var currentScore: Int = 0
    var timer = NSTimer()
    var seconds = 0
    var count = 0

    var gameImage: UIImage?
    var gameImageObject: AnyObject?
    var gameImageDictionary = [:]
    var gameImageURLString: String?
    
    // local array
    var gameInfo = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        RailsRequest.session().getPlayablePosts { (posts) -> Void in
            
            // set a local array = posts
            // reset tableview
            
            self.gameInfo = posts
            
            self.gameImageObject = self.gameInfo[0]["post_info"]!
            
            self.gameImageDictionary = self.gameImageObject as! NSDictionary
            
            self.gameImageURLString = self.gameImageDictionary["image_url"] as? String
                        
            // Create image from URL string
            let imageURL = NSURL(string: self.gameImageURLString!)
            
            let imageDataFromURL = NSData(contentsOfURL: imageURL!)
            
            let newImageFromData = UIImage(data: imageDataFromURL!)
            
            println("Play Game Test 6: \(newImageFromData)")
            
            self.gameImage = newImageFromData!
            
            self.currentGamePic.image = self.gameImage
            
        }
        
            
        
//        testing 
//         setupGame()
     
//        if let url = NSURL(gameInfo[countNumber]["image_url"]) as? String {
        
//            if let data = NSData(contentsOfURL: url!)

            
            
        
        
        
        
    }
    
//    func getImageFromURL(url: URL) {
//        
//        NSURLRequest
//        
//        
//        
//    }
    
    func setupGame() {
        
        seconds = 30
//        count = 0
        
        timerLabel.text = "Timer: \(seconds)"
        currentScoreLabel.text = "Current Score: \(globalScore)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
    }
    
    func countDown() {
        
        seconds--
        timerLabel.text = "Time: \(seconds)"
        
        if (seconds == 0) {
            timer.invalidate()
        }
        
        
    }
    
    
    
    @IBAction func answerButtonPressed(sender: AnyObject) {
        
        if answerField.text == "" {
            
            answerField.placeholder = "You have to type an answer!"
            
        } else {
            
//            RailsRequest.session().guessImage(<#postId: String#>, guess: <#String#>, completion: <#() -> Void##() -> Void#>)
            
            
            let guessResultVC = storyboard?.instantiateViewControllerWithIdentifier("guessResultVC") as! GuessResultViewController
            
            presentViewController(guessResultVC, animated: true, completion: nil)
            
        }
        
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
