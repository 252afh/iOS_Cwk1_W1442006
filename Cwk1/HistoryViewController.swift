//
//  HistoryViewController.swift
//  Cwk1
//
//  Created by user149138 on 3/6/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController {
    
    // Lists to hold values taken from UserDefault
    var liquids:[Liquid] = []
    var weights:[Weight] = []
    var temperatures:[Temperature] = []
    var speeds:[Speed] = []
    
    // All 5 labels used to display the history
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    // Buttons used to switch between measurement history
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var liquidButton: UIButton!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var speedButton: UIButton!
    
    // Label and button lists
    var labels:[UILabel] = []
    var buttons:[UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate lists with history information
        populateSpeed()
        populateLiquids()
        populateweights()
        populateTemperatures()
        
        labels = [label1, label2, label3, label4, label5]
        
        // Adds a border to each label
        for label in labels {
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.darkGray.cgColor
        }
        
        buttons = [weightButton, liquidButton, temperatureButton, speedButton]
        
        // Sets weight as the selected item when loading the view
        weightButton.sendActions(for: .touchUpInside)
    }
    
    func populateLiquids(){
        // Populate liquid list with Liquid objects from UserDefaults
        for index in 1...5{
            guard let data = UserDefaults.standard.object(forKey: ("liquid" + String(index))) as? Data else {
                return
            }
            
            guard let liquid = try? PropertyListDecoder().decode(Liquid.self, from: data) else {
                return
            }
            
            liquids.insert(liquid, at: index-1)
        }
    }
    
    func populateweights(){
        // Populate weights list with Weight objects from UserDefaults
        for index in 1...5{
            guard let data = UserDefaults.standard.object(forKey: ("weight" + String(index))) as? Data else {
                return
            }
            
            guard let weight = try? PropertyListDecoder().decode(Weight.self, from: data) else {
                return
            }
            
            weights.insert(weight, at: index-1)
        }
    }
    
    func populateSpeed(){
        // Populate speed list with Speed objects from UserDefaults
        for index in 1...5{
            guard let data = UserDefaults.standard.object(forKey: ("speed" + String(index))) as? Data else {
                return
            }
            
            guard let speed = try? PropertyListDecoder().decode(Speed.self, from: data) else {
                return
            }
            
            speeds.insert(speed, at: index-1)
        }
    }
    
    func populateTemperatures(){
        // Populate temperature list with Temperature objects from UserDefaults
        for index in 1...5{
            guard let data = UserDefaults.standard.object(forKey: ("temp" + String(index))) as? Data else {
                return
            }
            
            guard let temperature = try? PropertyListDecoder().decode(Temperature.self, from: data) else {
                return
            }
            
            temperatures.insert(temperature, at: index-1)
        }
    }
    
    @IBAction func speedButtonTapped(_ sender: UIButton) {
        // Handle speed button pressed
        clearLabels()
        resetButtonColors(tappedButton: sender)
        
        if (speeds.isEmpty){
            return
        }
        
        for speedIndex in 0...speeds.count-1 {
            labels[speedIndex].text = speeds[speedIndex].kmh + "kmh = " + speeds[speedIndex].mph + "mph = " + speeds[speedIndex].ms + "ms  = " + speeds[speedIndex].knots + "knots"
        }
    }
    
    @IBAction func temperatureButtonTapped(_ sender: UIButton) {
        // Handle temperature button pressed
        clearLabels()
        resetButtonColors(tappedButton: sender)
        
        if (temperatures.isEmpty){
            return
        }
        
        for tempsIndex in 0...temperatures.count-1 {
            labels[tempsIndex].text = temperatures[tempsIndex].celsius + "c = " + temperatures[tempsIndex].fahrenheit + "f = " + temperatures[tempsIndex].kelvin + "k"
        }
    }
    
    @IBAction func liquidButtonTapped(_ sender: UIButton) {
        // Handle liquid button pressed
        clearLabels()
        resetButtonColors(tappedButton: sender)
        
        if (liquids.isEmpty){
            return
        }
        
        for liquidIndex in 0...liquids.count-1 {
            labels[liquidIndex].text = liquids[liquidIndex].gallons + "gal = " + liquids[liquidIndex].litres + "l = " + liquids[liquidIndex].pints + "pt  = " + liquids[liquidIndex].ounces + "ounces = " + liquids[liquidIndex].millilitres + "ml"
        }
    }
    
    @IBAction func weightButtonTapped(_ sender: UIButton) {
        // Handle weight button pressed
        clearLabels()
        resetButtonColors(tappedButton: sender)
        
        if (weights.isEmpty){
            return
        }
        
        for weightIndex in 0...weights.count-1 {
            labels[weightIndex].text = weights[weightIndex].grams + "grams = " + weights[weightIndex].kilograms + "kg = " + weights[weightIndex].ounces + "oz  = " + weights[weightIndex].pounds + "fl lb = " + weights[weightIndex].stonePounds
        }
    }
    
    func resetButtonColors(tappedButton:UIButton){
        // Resets the buttons to default colors
        for button in buttons {
            button.backgroundColor = #colorLiteral(red: 0.8700000048, green: 0.8700000048, blue: 0.8700000048, alpha: 1)
        }
        tappedButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    func clearLabels(){
    // Clears history shown in the labels
        for label in labels {
            label.text = ""
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Returns to the previous screen
        dismiss(animated: true, completion: nil)
    }
}
