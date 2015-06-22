//
//  PlayGameViewController.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/17/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

var countNumber = 1
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        RailsRequest.session().getPosts { () -> Void in
            
        }
        
         setupGame()
        
    }
    
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
