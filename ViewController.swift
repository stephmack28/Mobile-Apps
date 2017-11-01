//
//  ViewController.swift
//  lab2
//
//  Created by McCormack on 9/25/17.
//  Copyright © 2017 McCormack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pet: petInfo! {
        didSet{
            updateView()
        }
        
    }
    
    var foodVals: [String: Int] = ["dog": 5, "cat": 5, "bird": 5, "bunny": 5, "fish": 5]
    var happyVals: [String: Int] = ["dog": 5, "cat": 5, "bird": 5, "bunny": 5, "fish": 5]
    var animal: String = ""
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var happiness: DisplayView!
    @IBOutlet weak var nourishment: DisplayView!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var happyNum: UILabel!
    @IBOutlet weak var hungerNum: UILabel!
    
    @IBOutlet weak var speechText: UILabel!

    @IBAction func playButton(_ sender: UIButton) {
        pet.play()
        updateView()
    }
    @IBAction func foodButton(_ sender: UIButton) {
        pet.feed()
        updateView()
        
    }
    
    @IBAction func dogButton(_ sender: UIButton) {
        pet = petInfo(name: "dog", hValue: happyVals["dog"]!, fValue: foodVals["dog"]!, sound: "Woof!")
        //print(pet.hValue)
        //self.speechText.image=UIImage(named:"speech")
        self.speechText.text = pet.sound
        self.background.backgroundColor = UIColor.blue
        self.animalImage.image = UIImage(named: "dog")
        happiness.color = UIColor.blue
        nourishment.color = UIColor.blue
        self.happyNum.text="Happiness: "+String(pet.hValue)
        self.hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        //print(happyBar)
        happiness.animateValue(to: CGFloat(happyBar))
        nourishment.animateValue(to: CGFloat(hungerBar))

    }
    @IBAction func catButton(_ sender: UIButton) {
        pet = petInfo(name: "cat", hValue: happyVals["cat"]!, fValue: foodVals["cat"]!, sound: "Meow!")
        background.backgroundColor = UIColor.red
        self.animalImage.image = UIImage(named: "cat")
        self.speechText.text = pet.sound
        happiness.color = UIColor.red
        nourishment.color = UIColor.red
        happyNum.text="Happiness: "+String(pet.hValue)
        hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        happiness.animateValue(to: CGFloat(happyBar))
        nourishment.animateValue(to: CGFloat(hungerBar))

    }
    @IBAction func birdButton(_ sender: UIButton) {
        pet = petInfo(name: "bird", hValue: happyVals["bird"]!, fValue: foodVals["bird"]!, sound: "Chirp!")
        background.backgroundColor = UIColor.green
        self.animalImage.image = UIImage(named: "bird")
        self.speechText.text = pet.sound
        happiness.color = UIColor.green
        nourishment.color = UIColor.green
        happyNum.text="Happiness: "+String(pet.hValue)
        hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        happiness.animateValue(to: CGFloat(happyBar))
        nourishment.animateValue(to: CGFloat(hungerBar))

    }
    @IBAction func bunnyButton(_ sender: UIButton) {
        pet = petInfo(name: "bunny", hValue: happyVals["bunny"]!, fValue: foodVals["bunny"]!, sound: "Hop!")
        background.backgroundColor = UIColor.brown
        self.animalImage.image = UIImage(named: "bunny")
        self.speechText.text = pet.sound
        happiness.color = UIColor.brown
        nourishment.color = UIColor.brown
        happyNum.text="Happiness: "+String(pet.hValue)
        hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        happiness.animateValue(to: CGFloat(happyBar))
        nourishment.animateValue(to: CGFloat(hungerBar))

    }
    @IBAction func fishButton(_ sender: UIButton) {
        pet = petInfo(name: "fish", hValue: happyVals["fish"]!, fValue: foodVals["fish"]!, sound: "Bloop!")
        background.backgroundColor = UIColor.yellow
        self.animalImage.image = UIImage(named: "fish")
        self.speechText.text = pet.sound
        happiness.color = UIColor.brown
        nourishment.color = UIColor.brown
        happyNum.text="Happiness: "+String(pet.hValue)
        hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        happiness.animateValue(to: CGFloat(happyBar))
        nourishment.animateValue(to: CGFloat(hungerBar))

    }
    
    private func updateView(){
        //update happiness & food label/bar
        animal = pet.name
        self.speechText.text = pet.sound
        happyNum.text="Happiness: "+String(pet.hValue)
        hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        
        foodVals[animal] = pet.fValue
        happyVals[animal] = pet.hValue
        //print(happiness.value)
        happiness.animateValue(to: CGFloat(happyBar))
        //print(happiness.value)
        nourishment.animateValue(to: CGFloat(hungerBar))
        
        
        
    }
    private func setupDog(){
        pet = petInfo(name: "dog", hValue: happyVals["dog"]!, fValue: foodVals["dog"]!, sound: "Woof!")
        //print(pet.hValue)
        //self.speech.image=UIImage(named:"speech")
        self.speechText.text = pet.sound
        self.background.backgroundColor = UIColor.blue
        self.animalImage.image = UIImage(named: "dog")
        happiness.color = UIColor.blue
        nourishment.color = UIColor.blue
        self.happyNum.text="Happiness: "+String(pet.hValue)
        self.hungerNum.text="Nourishment: "+String(pet.fValue)
        let happyBar = Double(pet.hValue)/10.0
        let hungerBar = Double(pet.fValue)/10.0
        //print(happyBar)
        happiness.animateValue(to: CGFloat(happyBar))
        nourishment.animateValue(to: CGFloat(hungerBar))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDog()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

