//
//  Canvas.swift
//  PaintApp
//
//  Created by Qili Ou on 1/6/19.
//  Copyright © 2019 Qili Ou. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    fileprivate var lines = [[CGPoint]]()
    
    // public function
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
        
    }
    
    
    override func draw(_ rect: CGRect) {
        // custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // test lines
        //        let startPoint = CGPoint(x: 0, y: 0)
        //        let endPoint = CGPoint(x: 100, y: 100)
        //
        //        context.move(to: startPoint)
        //        context.addLine(to: endPoint)
        
        // set up default line value
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        // same as: for line in lines {...}
        lines.forEach { (line) in
            for (index, position) in line.enumerated() {
                //start point
                if (index == 0) {
                    context.move(to: position)
                } else {
                    context.addLine(to: position)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    
    // track finger position
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        print("first touch position: \(point)")
        
        //remove the last element of lines array
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        
        lines.append(lastLine)
        
        //        var lastLine = lines.last
        //        lastLine?.append(point)
        //
        //
        //        line.append(point)
        
        // Redrawn/Update Canvas
        setNeedsDisplay()
        
    }
}
