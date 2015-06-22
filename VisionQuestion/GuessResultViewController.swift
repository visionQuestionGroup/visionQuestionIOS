//
//  GuessResultViewController.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/20/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class GuessResultViewController: UIViewController {

    @IBOutlet weak var yourGuessLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func keepPlayingButton(sender: AnyObject) {
        
        
    }
    
    @IBAction func finishButton(sender: AnyObject) {
    
    
    }
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()

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
