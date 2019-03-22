//
//  ViewController.swift
//  assignment1
//
//  Created by 曹相成 on 2019/3/22.
//  Copyright © 2019 曹相成. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let triangle = MyTriangle(frame:CGRect(x:150,y:250,width:400,height:400))
        triangle.backgroundColor = UIColor.clear//保证frame的背景颜色与周围一致！
        self.view.addSubview(triangle)
    }
}


class MyTriangle:UIView{
    override func draw(_ rect: CGRect){
        let path = UIBezierPath()
        path.move(to: CGPoint(x:80,y:50))
        path.addLine(to: CGPoint(x:140,y:150))
        path.addLine(to: CGPoint(x:10,y:150))
        
        path.close()
        
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.lineWidth = 3.0
        path.fill()
        path.stroke()

    }
}
