//
//  ViewController.swift
//  Demon Casino
//
//  Created by jerry on 16/7/16.
//  Copyright © 2016年 jerry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var devil: UILabel!
    
    //设置定时器
    var timer:NSTimer?
    
    //设置骰子翻页次数初始化为零
    var imageNumber = 0
    
    //定义选择结果枚举，有押大，押小，还有相同的豹子
    enum selectType{
        case big
        case small
        case same
    }
    
    //初始化选择为押大
    var st = selectType.big
    
    //这是分别代表第一个，第二个，第三个骰子点数的数字
    var image1Num = 0
    
    var image2Num = 0
    
    var image3Num = 0
    
    //代表玩家的幸运值点数
    var playerlucky = 1000
    //代表电脑的幸运值点数
    var devillucky = 2000
    
    @IBAction func buybig(sender: AnyObject) {
        st = .big
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    
    @IBAction func buysame(sender: AnyObject) {
        st = .same
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    @IBAction func buysmall(sender: AnyObject) {
        st = .small
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    func changeImage(){
        let id1 = arc4random()%6 + 1
        //%6代表随机0～5，＋1即1～6
        var name = "骰子"+String(id1)+".png"
        var image = UIImage(named: name)
        image1.image = image
        image1Num = Int(id1)
        
        let id2 = arc4random()%6 + 1
        name = "骰子"+String(id2)+".png"
        image = UIImage(named: name)
        image2.image = image
        image2Num = Int(id2)
        
        let id3 = arc4random()%6 + 1
        name = "骰子"+String(id3)+".png"
        image = UIImage(named: name)
        image3.image = image
        image3Num = Int(id3)
        
        imageNumber++
        if imageNumber>20{
            timer?.invalidate()
            imageNumber = 0
            judgmentResult()
            winorlose()
        }
    }
    
    func judgmentResult(){
        switch st{
        case .big:
            if image1Num+image2Num+image3Num>11{
                playerlucky += 50
                devillucky -= 50
            }else{
                playerlucky -= 50
                devillucky += 50
            }
            playerLabel.text = String(playerlucky)
            devil.text = String(devillucky)
        case .small:
            if image1Num+image2Num+image3Num<=11{
                playerlucky += 50
                devillucky -= 50
            }else{
                playerlucky -= 50
                devillucky += 50
            }
            playerLabel.text = String(playerlucky)
            devil.text = String(devillucky)
        case .same:
            if image1Num == image2Num && image2Num == image3Num{
                playerlucky += 500
                devillucky -= 500
            }else{
                playerlucky -= 500
                devillucky += 500
            }
            playerLabel.text = String(playerlucky)
            devil.text = String(devillucky)
        }
        
    }
    
    func winorlose(){
        if playerlucky <= 0 {
            playerLabel.text = "你的运气全被恶魔夺取了，老老实实搬砖吧"
            devil.text = "😈"
        }
        if devillucky <= 0{
            playerLabel.text = "卧槽，恶魔的运气你都敢要？"
            devil.text = "👿,给回老子运气！"
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

