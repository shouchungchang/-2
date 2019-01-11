//
//  Game.swift
//  Snake
//
//  Created by User08 on 2019/1/2.
//

import Foundation
import GameplayKit

enum  Move{
    case top , down , left , right
}

enum  Status{
    case move , eat , dead
}

struct SnakeCell {
    var type: Int
    var x: Int
    var y: Int
    var move: Move
}

struct Food {
    var x:Int
    var y:Int
    var foodImg:Int
}

class Game {
    var foodImgCount = 1
    var snakeHead = SnakeCell(type:1 , x:10 , y:12 ,move:Move.top)
    var snakeTail = SnakeCell(type:3 , x:10 , y:14 ,move:Move.top)
    var snakeBody = Array<SnakeCell>()
    var food:Food
    var boundaryX = 20
    var boundaryY = 26
    var point=0
    var status=Status.move

    init(){
        snakeBody.append(SnakeCell(type:2 , x:10 , y:13 ,move:Move.top))
        food=Food(x: 0, y: 0,foodImg:0)
        
        生成食物()
    }
    
    
    func 移動()->Bool{
        var tmp=snakeHead
        tmp.type=2
        switch snakeHead.move {
            case .top:
                if !碰撞(snakeCell: tmp, move: .top){
                    return false
                }
                snakeHead.y-=1
                print("上")
                break
            case .down:
                if !碰撞(snakeCell: tmp, move: .down){
                    return false
                }
                snakeHead.y+=1
                print("下")
                break
            case .right:
                if !碰撞(snakeCell: tmp, move: .right){
                    return false
                }
                snakeHead.x+=1
                print("右")
                break
            case .left:
                if !碰撞(snakeCell: tmp, move: .left){
                    return false
                }
                snakeHead.x-=1
                print("左")
                break
        }
        snakeBody.insert(tmp, at:0)
        snakeTail=snakeBody[snakeBody.count-1]
        snakeTail.type=3
        snakeBody.removeLast()
        return true
    }
    
    func 增長()->Bool{
        var tmp=snakeHead
        tmp.type=2
        var check=false
        switch snakeHead.move {
        case .top:
            if food.y==snakeHead.y-1 && food.x==snakeHead.x{
                snakeHead.y-=1
                check=true
            }
            break
        case .down:
            if food.y==snakeHead.y+1 && food.x==snakeHead.x{
                snakeHead.y+=1
                check=true
            }
            break
        case .right:
            if food.x==snakeHead.x+1 && food.y==snakeHead.y{
                snakeHead.x+=1
                check=true
            }
            break
        case .left:
            if food.x==snakeHead.x-1 && food.y==snakeHead.y{
                snakeHead.x-=1
                check=true
            }
            break
        }
        
        if check {
            snakeBody.insert(tmp, at:0)
            point=point+1
            
            return true
        }
        return false
    }
    
    func 碰撞(snakeCell:SnakeCell ,move:Move)->Bool{
        var snakeCell=snakeCell
        switch snakeCell.move {
        case .top:
            snakeCell.y-=1
            if snakeCell.y == 0 {
                snakeHead.y=25
            }
            break
        case .down:
            snakeCell.y+=1
            if snakeCell.y == boundaryY {
                snakeHead.y=1
            }
            break
        case .right:
            snakeCell.x+=1
            if snakeCell.x == boundaryX {
                snakeHead.x=1
            }
            break
        case .left:
            snakeCell.x-=1
            if snakeCell.x == 0 {
                snakeHead.x=19
            }
            break
        }
        for sn in snakeBody{
            if sn.x==snakeCell.x && sn.y==snakeCell.y{
                return false
            }
        }
        return true
    }
    
    func 生成食物(){
        let  randomDistributionX  =  GKRandomDistribution(lowestValue:  2,  highestValue:  boundaryX-2)
        let  randomDistributionY  =  GKRandomDistribution(lowestValue:  2,  highestValue:  boundaryY-2)
        let  randomDistributionFood = GKRandomDistribution(lowestValue:  1,  highestValue:  foodImgCount)
        var canCreateFood=false
        
        while !canCreateFood {
            canCreateFood=true
            
            food=Food(x:randomDistributionX.nextInt() , y:randomDistributionY.nextInt(),foodImg:randomDistributionFood.nextInt())
            
            if snakeHead.x==food.x && snakeHead.y==food.y{
                canCreateFood=false
            }
            
            for sn in snakeBody{
                if sn.x==food.x && sn.y==food.y{
                    canCreateFood=false
                }
            }
            
            if snakeTail.x==food.x && snakeTail.y==food.y{
                canCreateFood=false
            }
        }
        
    }
    
    func runOneRound()->Bool{
        
        if 增長(){
            生成食物()
            print("長大")
            status=Status.eat
            return true
        }
        else{
            if 移動(){
                status=Status.move
                return true
            }
            else{
                status=Status.dead
                print("死亡")
            }
        }
        return false
    }

}
