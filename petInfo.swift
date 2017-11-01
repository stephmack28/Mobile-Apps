//
//  petInfo.swift
//  stephaniemccormack_lab2
//
//  Created by McCormack on 9/24/17.
//  Copyright © 2017 McCormack. All rights reserved.
//

import Foundation

class petInfo {
    
    var hValue: Int
    var fValue: Int
    var name: String
    var sound: String
    
    init(name: String, hValue: Int, fValue: Int, sound: String){
        self.name = name
        self.hValue = hValue
        self.fValue = fValue
        self.sound = sound
    }
    
    
    func play(){
        if (fValue == 0){
         //do nothing, cant play
            sound="I'm hungry!"
        }
        else if (hValue==10){
            //creative portion: have talk bubble pop up to indicate ..
            fValue-=1
            sound="That's enough!"
        }
        else{
            sound="This is fun!"
            fValue-=1
            hValue+=1
        }
    }
    
    func feed(){
        if (hValue==0){
            //do nothing, cant eat
            sound="I want to play!"
        }
        else if (fValue==10){
            hValue-=1
            sound="I'm full!"
        }
        else{
            fValue+=1
            hValue-=1
            sound="Yum!"
        }
    }
    
}
