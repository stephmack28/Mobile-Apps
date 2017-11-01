//
//  LineView.swift
//  lab3att3
//
//  Created by McCormack on 10/2/17.
//  Copyright © 2017 McCormack. All rights reserved.
//

import UIKit

class LineView: UIView {
    var theLine:Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lines:[Line] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //var lineStart = CGPoint.zero
    //var endPoint = CGPoint.zero
    var linePoints = [CGPoint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        for line in lines {
            drawLine(line)
        }
        if(theLine != nil){
            drawLine(theLine!)
        }
    }
    
    
    func drawLine(_ line: Line) {
        
        //UIColor.black.setFill()
        var path = UIBezierPath()
        //draw line
        path=createQuadPath(points: line.points)
        path.lineWidth = line.lineThickness
        line.lineColor.setStroke()
        path.stroke()
        
         //draw dot
            let circlePath = UIBezierPath()
            line.lineColor.setFill()
            circlePath.lineWidth = line.lineThickness
        
            let radiusDots = CGFloat (line.lineThickness)
        
            circlePath.addArc(withCenter: line.points[0], radius: (radiusDots/2), startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)


            circlePath.addArc(withCenter: line.points.last!, radius: (radiusDots/2) , startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        
            circlePath.fill()

        
        
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here
        let xVal = (second.x+first.x)/2
        let yVal = (second.y+first.y)/2
        
        return CGPoint(x: xVal, y: yVal)
        

    }
    
//    //code below from Lab Assignment document

    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }

    func updateLine(points: [CGPoint]){
        linePoints = points
        //print("update point: \(line)")
        
        setNeedsDisplay()
        
    }
    
}
