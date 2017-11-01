//
//  ViewController.swift
//  lab3att3
//
//  Created by McCormack on 10/2/17.
//  Copyright © 2017 McCormack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //var currStartPoint = CGPoint.zero
    var currLine: Line?
    var lineCanvas: LineView!
    var currColor: UIColor! = UIColor.black
    var thickness: CGFloat = 5
    var lastLine: [Line?] = []
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderText: UILabel!
    
    @IBAction func savePressed(_ sender: Any) {
        let toSave = saveImage(view: self.view)
        UIImageWriteToSavedPhotosAlbum(toSave!, nil, nil, nil)
        
        
    }
    @IBOutlet weak var colorDisplay: UIImageView!
    
    @IBAction func sliderSlid(_ sender: UISlider) {
        sliderText.text = "Current size: " + String(Int(slider.value) )
        thickness=CGFloat(Int(slider.value)*2)
    }
    
    @IBAction func redButton(_ sender: Any) {
        currColor=UIColor.red
        colorDisplay.image = UIImage(named: "red")
        //print("Color red")
    }
    @IBAction func orangeButton(_ sender: Any) {
        currColor=UIColor.orange
        colorDisplay.image = UIImage(named: "orange")
    }
    @IBAction func yellowButton(_ sender: Any) {
        currColor=UIColor.yellow
        colorDisplay.image = UIImage(named: "yellow")
    }
    @IBAction func greenButton(_ sender: Any) {
        currColor=UIColor.green
        colorDisplay.image = UIImage(named: "green")
    }
    @IBAction func blueButton(_ sender: Any) {
        currColor=UIColor.blue
        colorDisplay.image = UIImage(named: "blue")
    }
    @IBAction func purpleButton(_ sender: Any) {
        currColor=UIColor.purple
        colorDisplay.image = UIImage(named: "purple")
    }
    @IBAction func blackButton(_ sender: Any) {
        currColor=UIColor.black
        colorDisplay.image = UIImage(named: "black")
    }
    
    
    @IBAction func clearScreen(_ sender: Any) {
        lineCanvas.theLine = nil
        lineCanvas.lines = []
        lastLine = []
    }
    @IBAction func undoButton(_ sender: Any) {
        if lineCanvas.lines.count > 0{
            lineCanvas.theLine = nil
            lastLine.append(lineCanvas.lines.popLast())
        }
    }
    @IBAction func redoButton(_ sender: Any) {
        if lastLine.count > 0{
            //let l = lastLine.popLast()
            lineCanvas.theLine=lastLine.last!
            lineCanvas.lines.append(lastLine.popLast()!!)
        }
    }
    
    func saveImage(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: view.frame.size.width, height: view.frame.size.height))
        view.drawHierarchy(in: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height), afterScreenUpdates: true)
        let i = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return i
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lineCanvas = LineView(frame: self.view.frame)
        view.addSubview(lineCanvas)
        //self.currColor=UIColor.black
        sliderText.text = "Current Size: " + String( Int(slider.value) )
        colorDisplay.image = UIImage(named: "black")
        //slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        print("start point is \(touchPoint)")
        
        var pointsArr = [CGPoint]()
        //pointsArr.removeAll()
        pointsArr.append(touchPoint)
        currLine = Line(points: pointsArr, lineColor: currColor, lineThickness: thickness)
        
        lineCanvas.theLine = currLine
        //print(pointsArr)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        //let distance = Functions.distance(a: touchPoint, b: (currentCircle?.center)!)
        print("curr point is \(touchPoint)")
        
        currLine?.points.append(touchPoint)
        lineCanvas.theLine = currLine
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        if let newLine = currLine {
            lineCanvas.lines.append(newLine)
        }
    }

}

