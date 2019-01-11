//
//  GameViewController.swift
//  Snake
//
//  Created by User04 on 2019/1/3.
//  Copyright © 2019 User04. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer=Timer()
    var game:Game!
    var counter = 0.0
    var notfinish = false
    var pause1=true
    var setting=Setting.readLoversFromFile()
    var speed=1
 
    @IBOutlet weak var gameRange: UIView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    
    @IBAction func startGame(_ sender: Any) {
        game=Game()
        timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)),
                                     target:self,
                                     selector: #selector( tickDown ),
                                     userInfo:nil,repeats:true)
        start.setTitle("重新開始", for: .normal)
        pause.setTitle("暫停", for: .normal)
        pause.isEnabled=true
        start.isEnabled=true

        topButton.isEnabled=true
        downButton.isEnabled=true
        rightButton.isEnabled=true
        leftButton.isEnabled=true
    }

    @IBAction func pauseGame(_ sender: Any) {
        if pause1{
            timer.invalidate()
            pause.setTitle("恢復", for: .normal)
            pause1=true
            
            topButton.isEnabled=false
            downButton.isEnabled=false
            rightButton.isEnabled=false
            leftButton.isEnabled=false
        }
        else{
            if (1-(0.05*Double(speed-1)+Double(game.point/5))) >= 0{
                timer.invalidate()
                
                timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)+0.1*Double(game.point/5)),
                                             target:self,
                                             selector: #selector( tickDown ),
                                             userInfo:nil,repeats:true)
            }
            else {
                timer = Timer.scheduledTimer(timeInterval:1 - 0.95,
                                             target:self,
                                             selector: #selector( tickDown ),
                                             userInfo:nil,repeats:true)
            }

            pause.setTitle("暫停", for: .normal)
            pause1=true
            
            topButton.isEnabled=true
            downButton.isEnabled=true
            rightButton.isEnabled=true
            leftButton.isEnabled=true
        }
    }
    
    @IBAction func 轉方向(_ sender: UIButton) {
        if sender.titleLabel?.text=="上"{
            if game.snakeHead.move != Move.down{
                game.snakeHead.move=Move.top
            }
        }
        else if sender.titleLabel?.text=="下"{
            if game.snakeHead.move != Move.top{
                game.snakeHead.move=Move.down
            }
        }
        else if sender.titleLabel?.text=="左"{
            if game.snakeHead.move != Move.right{
                game.snakeHead.move=Move.left
            }
        }
        else if sender.titleLabel?.text=="右"{
            if game.snakeHead.move != Move.left{
                game.snakeHead.move=Move.right
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        start.isEnabled=true
        pause.isEnabled=false
        topButton.isEnabled=false
        downButton.isEnabled=false
        rightButton.isEnabled=false
        leftButton.isEnabled=false
        
        
        if let speedd = setting?.speed{
            speed=speedd
        }

        let swipeUp = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeUp.direction = .up

        swipeUp.numberOfTouchesRequired = 1

        self.view.addGestureRecognizer(swipeUp)

        let swipeLeft = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeLeft.direction = .left

        self.view.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeDown.direction = .down
 
        self.view.addGestureRecognizer(swipeDown)

        let swipeRight = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeRight.direction = .right
 
        self.view.addGestureRecognizer(swipeRight)
        
    }

    @objc func tickDown()
    {
        notfinish=game.runOneRound()
        if notfinish {
            let cgX=gameRange.frame.size.width/(CGFloat(game.boundaryX)-1)
            let cgY=gameRange.frame.size.height/(CGFloat(game.boundaryY)-1)

            for v in gameRange.subviews as [UIView] {
                v.removeFromSuperview()
            }

            var myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.snakeHead.x-1)*cgX,
                    y: CGFloat(game.snakeHead.y-1)*cgY,
                    width: cgX,
                    height: cgY))
            if game.snakeHead.move==Move.top{
                myImageView.image = UIImage(named: "head2.png")
            }
            else if game.snakeHead.move==Move.down{
                myImageView.image = UIImage(named: "head4.png")
            }
            else if game.snakeHead.move==Move.right{
                myImageView.image = UIImage(named: "head3.png")
            }
            else if game.snakeHead.move==Move.left{
                myImageView.image = UIImage(named: "head1.png")
            }
            gameRange.addSubview(myImageView)

            for sn in game.snakeBody{
                myImageView = UIImageView(
                    frame: CGRect(
                        x: CGFloat(sn.x-1)*cgX,
                        y: CGFloat(sn.y-1)*cgY,
                        width: cgX,
                        height: cgY))
                
                if sn.move==Move.top{
                    myImageView.image = UIImage(named: "body2.png")
                }
                else if sn.move==Move.down{
                    myImageView.image = UIImage(named: "body4.png")
                }
                else if sn.move==Move.right{
                    myImageView.image = UIImage(named: "body3.png")
                }
                else if sn.move==Move.left{
                    myImageView.image = UIImage(named: "body1.png")
                }
                
                gameRange.addSubview(myImageView)
            }

            myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.snakeTail.x-1)*cgX,
                    y: CGFloat(game.snakeTail.y-1)*cgY,
                    width: cgX,
                    height: cgY))
            
            if game.snakeTail.move==Move.top{
                myImageView.image = UIImage(named: "tail2.png")
            }
            else if game.snakeTail.move==Move.down{
                myImageView.image = UIImage(named: "tail4.png")
            }
            else if game.snakeTail.move==Move.right{
                myImageView.image = UIImage(named: "tail3.png")
            }
            else if game.snakeTail.move==Move.left{
                myImageView.image = UIImage(named: "tail1.png")
            }
            
            gameRange.addSubview(myImageView)
            
            myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.food.x-1)*cgX,
                    y: CGFloat(game.food.y-1)*cgY,
                    width: cgX,
                    height: cgY))
            
            myImageView.image = UIImage(named: "food"+String(game.food.foodImg)+".png")
            gameRange.addSubview(myImageView)

            point.text="分數： " + String(format: "%02i", game.point)
        
            print(game.food)
            print(game.snakeHead)
            
            if game.point%5 == 0 && game.point != 0{
                if (1-(0.05*Double(speed-1)+0.1*Double(game.point/5))) >= 0{
                    timer.invalidate()
                    
                    timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)+0.1*Double(game.point/5)),
                                                 target:self,
                                                 selector: #selector( tickDown ),
                                                 userInfo:nil,repeats:true)
                }
                else {
                    timer.invalidate()
                    
                    timer = Timer.scheduledTimer(timeInterval: 1-0.95,
                                                 target:self,
                                                 selector: #selector( tickDown ),
                                                 userInfo:nil,repeats:true)
                }
            }
        }
        else{
            let tmp=User(no: 0, point: game.point, user: (setting?.name)!, description: "")
            
            User.saveToFile(user: tmp)
            
            timer.invalidate()
            
            start.isEnabled=true
            pause.isEnabled=false
            
            topButton.isEnabled=false
            downButton.isEnabled=false
            rightButton.isEnabled=false
            leftButton.isEnabled=false
        }
    }
    
    
    @objc func 滑動(recognizer:UISwipeGestureRecognizer) {
        if recognizer.direction == .up {
            if game.snakeHead.move != Move.down{
                game.snakeHead.move=Move.top
            }
        }
        else if recognizer.direction == .left {
            if game.snakeHead.move != Move.right{
                game.snakeHead.move=Move.left
            }
        }
        else if recognizer.direction == .down {
            if game.snakeHead.move != Move.top{
                game.snakeHead.move=Move.down
            }
        }
        else if recognizer.direction == .right {
            if game.snakeHead.move != Move.left{
                game.snakeHead.move=Move.right
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        // Show the navigation bar on other view controllers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
