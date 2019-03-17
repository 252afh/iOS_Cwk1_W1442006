//
//  WeightViewController.swift
//  Cwk1
//
//  Created by user149138 on 3/5/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation
import UIKit

class WeightViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    // Text fields used for weight values
    @IBOutlet weak var kilogramTextField: UITextField!
    @IBOutlet weak var stonePoundTextField: UITextField!
    @IBOutlet weak var poundTextField: UITextField!
    @IBOutlet weak var stoneTextField: UITextField!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var ounceTextField: UITextField!
    
    // The currently active field
    var activeField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows the keyboard to be hidden when tapped out of focus
        self.hideKeyboard()
        
        // Creates a kayboard instance and settings
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
        // Assigns the custom keyboard to each text field
        kilogramTextField.delegate = self
        kilogramTextField.inputView = keyboardView

        stoneTextField.delegate = self
        stoneTextField.inputView = keyboardView

        stonePoundTextField.delegate = self
        stonePoundTextField.inputView = keyboardView

        poundTextField.delegate = self
        poundTextField.inputView = keyboardView

        gramTextField.delegate = self
        gramTextField.inputView = keyboardView

        ounceTextField.delegate = self
        ounceTextField.inputView = keyboardView
    }
    
    func calcFromKilograms() {
        // Calculate amounts from entered kilos
        let kilograms = Double(kilogramTextField.text ?? "0.0")
        let grams = String(format: "%.4f", ((kilograms ?? 0.0)*1000.0))
        let ounce = String(format: "%.4f", ((kilograms ?? 0.0)*35.274))
        let pound = (kilograms ?? 0.0)*2.20462
        let stone = String(format: "%.4f", pound/14)
        let poundString = String(format: "%.4f", (pound))
        let stoneString = stone.split(separator: ".")[0]
        let stoneDecimalString = "0." + stone.split(separator: ".")[1]
        let stonePound = String(format: "%.4f",((Double(stoneDecimalString) ?? 0.0)*14))
        
        setTextFields(stones: String(stoneString), kilograms: (kilogramTextField.text ?? "0.0"), grams: grams, ounces: ounce, pounds: poundString, stonePounds: stonePound)
    }
    
    func calcFromGrams() {
        // Calculate amounts from entered grams
        let grams = Double(gramTextField.text ?? "0.0")
        let kilograms = String(format: "%.4f", ((grams ?? 0.0)/1000))
        let ounce = String(format: "%.4f", ((grams ?? 0.0)/28.35))
        let pound = (grams ?? 0.0)/453.592
        let stone = String(format: "%.4f", pound/14)
        let poundString = String(format: "%.4f", (pound))
        let stoneString = stone.split(separator: ".")[0]
        let stoneDecimalString = "0." + stone.split(separator: ".")[1]
        let stonePound = String(format: "%.4f",((Double(stoneDecimalString) ?? 0.0)*14))
        
        setTextFields(stones: String(stoneString), kilograms: kilograms, grams: (gramTextField.text ?? "0.0"), ounces: ounce, pounds: poundString, stonePounds: stonePound)
    }
    
    func calcFromOunces() {
        // Calculate amounts from entered ounces
        let ounces = Double(ounceTextField.text ?? "0.0")
        let kilograms = String(format: "%.4f", ((ounces ?? 0.0)/35.274))
        let grams = String(format: "%.4f", ((ounces ?? 0.0)*28.3495))
        let pound = (ounces ?? 0.0)/16
        let stone = String(format: "%.4f", (pound/14))
        let poundString = String(format: "%.4f", (pound))
        let stoneString = stone.split(separator: ".")[0]
        let stoneDecimalString = "0." + stone.split(separator: ".")[1]
        let stonePound = String(format: "%.4f",((Double(stoneDecimalString) ?? 0.0)*14))
        
        setTextFields(stones: String(stoneString), kilograms: kilograms, grams: grams, ounces: (ounceTextField.text ?? "0.0"), pounds: poundString, stonePounds: stonePound)
    }
    
    func calcFromPounds() {
        // Calculate amounts from entered pounds
        let pounds = Double(poundTextField.text ?? "0.0")
        let kilograms = String(format: "%.4f", ((pounds ?? 0.0)/2.205))
        let grams = String(format: "%.4f", ((pounds ?? 0.0)*453.592))
        let ounces = String(format: "%.4f", ((pounds ?? 0.0)*16))
        let stone = String(format: "%.4f", (pounds ?? 0.0)/14)
        let stoneString = stone.split(separator: ".")[0]
        let stoneDecimalString = "0." + stone.split(separator: ".")[1]
        let stonePound = String(format: "%.4f",((Double(stoneDecimalString) ?? 0.0)*14))
        
        setTextFields(stones: String(stoneString), kilograms: kilograms, grams: grams, ounces: ounces, pounds: (poundTextField.text ?? "0.0"), stonePounds: stonePound)
    }
    
    func calcFromStonePounds() {
        // Calculate amounts from entered pounds or stones
        let stones = Double(stoneTextField.text ?? "0.0") ?? 0.0
        let stonesFromPounds = ((Double(stonePoundTextField.text ?? "0.0") ?? 0.0)/14)
        let stonesAndPounds = stones + stonesFromPounds
        let kilograms = String(format: "%.4f", (stonesAndPounds*6.35))
        let grams = String(format: "%.4f", (stonesAndPounds*6350.293))
        let ounces = String(format: "%.4f", (stonesAndPounds*224))
        let pounds = String(format: "%.4f", (stonesAndPounds*14))
        
        setTextFields(stones: (stoneTextField.text ?? "0.0"), kilograms: kilograms, grams: grams, ounces: ounces, pounds: pounds, stonePounds: (stonePoundTextField.text ?? "0.0"))
    }
    
    func setTextFields(stones:String, kilograms:String, grams:String, ounces:String, pounds:String, stonePounds:String){
        // Sets values to corresponding text fields
        
        if (stones.count == 0){
            stoneTextField.text = "0"
        }
        else{
            stoneTextField.text = stones
        }
        
        kilogramTextField.text = kilograms
        gramTextField.text = grams
        ounceTextField.text = ounces
        poundTextField.text = pounds
        stonePoundTextField.text = stonePounds
    }
    
    func keyWasTapped(character: String) {
        // Handles which key was entered
        
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
        
        // Handles which field the keys have been entered in
        if (self.activeField.text?.count ?? 0 > 0 && self.activeField.text?.last != "."){
            switch activeField {
            case kilogramTextField:
                calcFromKilograms()
                break
            case gramTextField:
                calcFromGrams()
                break
            case ounceTextField:
                calcFromOunces()
                break
            case poundTextField:
                calcFromPounds()
                break
            case stoneTextField, stonePoundTextField:
                calcFromStonePounds()
                break
            default:
                setToDefaults()
            }
        }
    }
    
    func setToDefaults(){
        // Returns the text field to default values
        kilogramTextField.text? = ""
        gramTextField.text? = ""
        ounceTextField.text? = ""
        poundTextField.text? = ""
        stoneTextField.text? = ""
        stonePoundTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Handles setting the currently active text field
        self.activeField = textField
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Handles saving the current text field values to history
        let kilograms = kilogramTextField.text
        let grams = gramTextField.text
        let ounces = ounceTextField.text
        let pounds = poundTextField.text
        let stonePounds = (stoneTextField.text ?? "0.0") + "st " + (stonePoundTextField.text ?? "0.0") + "lb"
        
        if (kilograms == "" || kilograms?.last == "."){
            return
        }
        
        if (grams == "" || grams?.last == "."){
            return
        }
        
        if (ounces == "" || ounces?.last == "."){
            return
        }
        
        if (pounds == "" || pounds?.last == "."){
            return
        }
        
        if (stonePounds == "" || stonePounds.last == "."){
            return
        }
        
        // Creates a struct for the weight item based on current field values
        let weightItem = Weight(kilograms: kilograms ?? "0.0", grams: grams ?? "0.0", ounces: ounces ?? "0.0", pounds: pounds ?? "0.0", stonePounds: stonePounds)
        
        // Handles checking if the 5 saved weights are full
        for index in 1...5 {
            if (UserDefaults.standard.object(forKey: ("weight" + String(index))) == nil){
                UserDefaults.standard.set(try? PropertyListEncoder().encode(weightItem), forKey: ("weight" + String(index)))
                return
            }
        }
        
        // Handles shuffling and assigning a new value if the history is full
        for index in 1...4 {
            guard let data = UserDefaults.standard.object(forKey: ("weight" + String(index+1))) as? Data else {
                return
            }
            
            guard let weight = try? PropertyListDecoder().decode(Weight.self, from: data) else {
                return
            }
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(weight), forKey: ("weight" + String(index)))
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(weightItem), forKey: "weight5")
        
    }
}
