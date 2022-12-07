//
//  ChickenData.swift
//  laPoulette
//
//  Created by kevin fichou on 05/12/2022.
//

import Foundation
import UIKit

class ChickenData {
    
    let chickenOne = Chicken(isChicken: true, imgName: "poule01")
    let chickenTwo = Chicken(isChicken: true, imgName: "poule02")
    let chickenThree = Chicken(isChicken: true, imgName: "poule03")
    let chickenFour = Chicken(isChicken: true, imgName: "poule04")
    let chickenFive = Chicken(isChicken: false, imgName: "poule05")
    let chickenSix = Chicken(isChicken: true, imgName: "poule06")
    let chickenSeven = Chicken(isChicken: false, imgName: "pigeon")
    let chickenEight = Chicken(isChicken: false, imgName: "renard")
    
    var allChicken: [Chicken] {
        return [chickenOne, chickenTwo, chickenThree, chickenFour, chickenFive, chickenSix, chickenSeven, chickenEight]
    }
}
