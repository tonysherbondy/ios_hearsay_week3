//
//  ViewController.swift
//  animations
//
//  Created by Anthony Sherbondy on 10/21/14.
//  Copyright (c) 2014 iosfd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButton(sender: AnyObject) {
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            self.imageView.center.y += 270
            self.imageView.transform = CGAffineTransformMakeScale(2, 2)
            }) { (finished: Bool) -> Void in
            
                self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, CGFloat(-10 * M_PI/180))
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
                
                var angle = CGFloat(20 * M_PI / 180)
                self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, angle)
                
                }, completion: nil)
        }
        
        
    }

    @IBAction func onPanHead(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        println("velocity \(velocity)")
        
        if sender.state == UIGestureRecognizerState.Began {
            imageCenter = imageView.center
            imageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            imageView.center.y = imageCenter.y + translation.y
            imageView.center.x = imageCenter.x + translation.x
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            imageView.transform = CGAffineTransformIdentity
            
            var animationTime = NSTimeInterval(abs(100/velocity.x))
            
            UIView.animateWithDuration(animationTime, animations: { () -> Void in
                
                if velocity.x < 0 {
                    self.imageView.center.x = 30
                } else {
                    self.imageView.center.x = 290
                }
                
            })
            
        }
        
    }
    
    
    @IBAction func onHeadTap(sender: UITapGestureRecognizer) {
        println("head tapped")
    }
}

