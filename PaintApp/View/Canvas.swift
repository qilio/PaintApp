//
//  Canvas.swift
//  PaintApp
//
//  Created by Qili Ou on 1/6/19.
//  Copyright © 2019 Qili Ou. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    fileprivate var lines = [Line]()
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    
    // public function
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    
    override func draw(_ rect: CGRect) {
        // custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        

        // same as: for line in lines {...}
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            
            for (index, position) in line.points.enumerated() {
                //start point
                if (index == 0) {
                    context.move(to: position)
                } else {
                    context.addLine(to: position)
                }
            }
            context.strokePath()
        }
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, strokeWidth: strokeWidth, points: []))
    }
    
    
    // track finger position
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        print("first touch position: \(point)")
        
        //remove the last element of lines array
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
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
