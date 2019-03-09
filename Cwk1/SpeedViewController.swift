//
//  SpeedViewController.swift
//  Cwk1
//
//  Created by user149138 on 3/5/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation
import UIKit

class SpeedViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    // Text fields used for user input
    @IBOutlet weak var metresPerSecondTextField: UITextField!
    @IBOutlet weak var knotsTextField: UITextField!
    @IBOutlet weak var milesPerHourTextField: UITextField!
    @IBOutlet weak var kilometresPerHourTextField: UITextField!
    
    // The currently active field
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows the keyboard to minimise when focus is tapped out
        self.hideKeyboard()
        
        // Creates an instance of a keyboard and settings
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
        // Assigns the keyboard to each text field
        metresPerSecondTextField.delegate = self
        metresPerSecondTextField.inputView = keyboardView
        
        knotsTextField.delegate = self
        knotsTextField.inputView = keyboardView
        
        milesPerHourTextField.delegate = self
        milesPerHourTextField.inputView = keyboardView
        
        kilometresPerHourTextField.delegate = self
        kilometresPerHourTextField.inputView = keyboardView
    }
    
    func calcFromMs() {
        // Calculates field amounts from ms
        let ms = Double(metresPerSecondTextField.text ?? "0.0")
        let kph = String(format: "%.4f", ((ms ?? 0.0)*3.6))
        let mph = String(format: "%.4f", ((ms ?? 0.0)*2.237))
        let knots = String(format: "%.4f", ((ms ?? 0.0)*1.944))
        
        setTextFields(kph: kph, ms: metresPerSecondTextField.text ?? "0.0", mph: mph, knots: knots)
    }
    
    func calcFromKph() {
        // Calculates field amount from kph
        let kph = Double(kilometresPerHourTextField.text ?? "0.0")
        let ms = String(format: "%.4f", ((kph ?? 0.0)/3.6))
        let mph = String(format: "%.4f", ((kph ?? 0.0)/1.609))
        let knots = String(format: "%.4f", ((kph ?? 0.0)/1.852))
        
        setTextFields(kph: kilometresPerHourTextField.text ?? "0.0", ms: ms, mph: mph, knots: knots)
    }
    
    func calcFromMph() {
        // Calculates field amounts from mph
        let mph = Double(milesPerHourTextField.text ?? "0.0")
        let kph = String(format: "%.4f", ((mph ?? 0.0)*1.609))
        let ms = String(format: "%.4f", ((mph ?? 0.0)/2.237))
        let knots = String(format: "%.4f", ((mph ?? 0.0)/1.151))
        
        setTextFields(kph: kph, ms: ms, mph: milesPerHourTextField.text ?? "0.0", knots: knots)
    }
    
    func calcFromKnots() {
        // Calculate field amounts from knots
        let knots = Double(knotsTextField.text ?? "0.0")
        let kph = String(format: "%.4f", ((knots ?? 0.0)*1.852))
        let mph = String(format: "%.4f", ((knots ?? 0.0)*1.151))
        let ms = String(format: "%.4f", ((knots ?? 0.0)/1.944))
        
        setTextFields(kph: kph, ms: ms, mph: mph, knots: knotsTextField.text ?? "0.0")
    }
    
    func setTextFields(kph:String, ms:String, mph:String, knots:String){
        // Assigns values to corresponding fields
        kilometresPerHourTextField.text = kph
        metresPerSecondTextField.text = ms
        milesPerHourTextField.text = mph
        knotsTextField.text = knots
    }
    
    func keyWasTapped(character: String) {
        // Handles which key was pressed
        if (character == "del"){
            self.activeField.text = String(self.activeField.text?.dropLast() ?? "")
        }
        else if (character == "."){
            if (self.activeField.text?.count ?? 0 > 0 &&
                self.activeField.text?.contains(".") == false){
                self.activeField.text? += "."
            }
        }
        else{
            self.activeField.text? += character
        }
        
        // Handles which text field the vlaues were inputted in
        if (self.activeField.text?.count ?? 0 > 0 && self.activeField.text != "."){
            switch self.activeField{
            case metresPerSecondTextField:
                calcFromMs()
                break
            case kilometresPerHourTextField:
                calcFromKph()
                break
            case milesPerHourTextField:
                calcFromMph()
                break
            case knotsTextField:
                calcFromKnots()
                break
            default:
                setToDefaults()
            }
        }
    }
    
    func setToDefaults(){
        // Resets text field to default value
        metresPerSecondTextField.text? = ""
        kilometresPerHourTextField.text? = ""
        milesPerHourTextField.text? = ""
        knotsTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Handles which text field is currently focused
        self.activeField = textField
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Handles saving current text field values to history
        let ms = metresPerSecondTextField.text
        let kmh = kilometresPerHourTextField.text
        let mph = milesPerHourTextField.text
        let knots = knotsTextField.text
        
        if (ms == "" || ms?.last == "."){
            return
        }
        
        if (kmh == "" || kmh?.last == "."){
            return
        }
        
        if (mph == "" || mph?.last == "."){
            return
        }
        
        if (knots == "" || knots?.last == "."){
            return
        }
        
        // Creates a speed struct to store in history
        let speedItem = Speed(ms: ms ?? "0.0", kmh: kmh ?? "0.0", mph: mph ?? "0.0", knots: knots ?? "0.0")
        
        // Checks the history for existing speed items
        for index in 1...5 {
            if (UserDefaults.standard.object(forKey: ("speed" + String(index))) == nil){
                UserDefaults.standard.set(try? PropertyListEncoder().encode(speedItem), forKey: ("speed" + String(index)))
                return
            }
        }
        
        // Shuffles the speed history and adds a new item if all 5 stored items are full
        for index in 1...4 {
            guard let data = UserDefaults.standard.object(forKey: ("speed" + String(index+1))) as? Data else {
                return
            }
            
            guard let speed = try? PropertyListDecoder().decode(Speed.self, from: data) else {
                return
            }
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(speed), forKey: ("speed" + String(index)))
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(speedItem), forKey: "speed5")
        }
    }
