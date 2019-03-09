//
//  LiquidView.swift
//  Cwk1
//
//  Created by user149138 on 3/5/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation
import UIKit

class LiquidViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    
    // Text fields used for user input
    @IBOutlet weak var gallonTextField: UITextField!
    @IBOutlet weak var millilitreTextField: UITextField!
    @IBOutlet weak var fluidOunceTextField: UITextField!
    @IBOutlet weak var pintTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    
    // The currently active field
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows the keyboard to be hidden when tapping off it
        self.hideKeyboard()
        
        // Setting up the keyboard settings and instance
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
        // Assigning the keyboard to each text field
        gallonTextField.delegate = self
        gallonTextField.inputView = keyboardView
        
        millilitreTextField.delegate = self
        millilitreTextField.inputView = keyboardView
        
        fluidOunceTextField.delegate = self
        fluidOunceTextField.inputView = keyboardView
        
        pintTextField.delegate = self
        pintTextField.inputView = keyboardView
        
        litreTextField.delegate = self
        litreTextField.inputView = keyboardView
    }
    
    func calcFromGallons() {
        // Calculate amounts from entered gallons
        let gallons = Double(gallonTextField.text ?? "0.0")
        let litres = String(format: "%.4f", ((gallons ?? 0.0)*4.546))
        let pints = String(format: "%.4f", ((gallons ?? 0.0)*8))
        let ounces = String(format: "%.4f", ((gallons ?? 0.0)*160))
        let millilitres = String(format: "%.4f", ((gallons ?? 0.0)*4546.09))
        
        setTextFields(litres: litres, pints: pints, ounces: ounces, gallons: (gallonTextField.text ?? "0.0"), millilitres: millilitres)
    }
    
    func calcFromLitres() {
        // Calculate amounts from entered litres
        let litres = Double(litreTextField.text ?? "0.0")
        let gallons = String(format: "%.4f", ((litres ?? 0.0)/4.546))
        let pints = String(format: "%.4f", ((litres ?? 0.0)*1.76))
        let ounces = String(format: "%.4f", ((litres ?? 0.0)*35.195))
        let millilitres = String(format: "%.4f", ((litres ?? 0.0)*1000))
        
        setTextFields(litres: (litreTextField.text ?? "0.0"), pints: pints, ounces: ounces, gallons: gallons, millilitres: millilitres)
    }
    
    func calcFromPint() {
        // Calculate amounts from entered pints
        let pints = Double(pintTextField.text ?? "0.0")
        let litres = String(format: "%.4f", ((pints ?? 0.0)/1.76))
        let gallons = String(format: "%.4f", ((pints ?? 0.0)/8))
        let ounces = String(format: "%.4f", ((pints ?? 0.0)*20))
        let millilitres = String(format: "%.4f", ((pints ?? 0.0)*568.261))
        
        setTextFields(litres: litres, pints: (pintTextField.text ?? "0.0"), ounces: ounces, gallons: gallons, millilitres: millilitres)
    }
    
    func calcFromOunces() {
        // Calculate amounts from entered ounces
        let ounces = Double(fluidOunceTextField.text ?? "0.0")
        let litres = String(format: "%.4f", ((ounces ?? 0.0)/35.195))
        let pints = String(format: "%.4f", ((ounces ?? 0.0)/20))
        let gallons = String(format: "%.4f", ((ounces ?? 0.0)/160))
        let millilitres = String(format: "%.4f", ((ounces ?? 0.0)*28.413))
        
        setTextFields(litres: litres, pints: pints, ounces: (fluidOunceTextField.text ?? "0.0"), gallons: gallons, millilitres: millilitres)
    }
    
    func calcFromMillilitres() {
        // Calculate amounts from entered millimitres
        let millilitres = Double(millilitreTextField.text ?? "0.0")
        let litres = String(format: "%.4f", ((millilitres ?? 0.0)/1000))
        let pints = String(format: "%.4f", ((millilitres ?? 0.0)/568.261))
        let ounces = String(format: "%.4f", ((millilitres ?? 0.0)/28.413))
        let gallons = String(format: "%.4f", ((millilitres ?? 0.0)/4546.09))
        
        setTextFields(litres: litres, pints: pints, ounces: ounces, gallons: gallons, millilitres: (millilitreTextField.text ?? "0.0"))
    }
    
    func setTextFields(litres:String, pints:String, ounces:String, gallons:String, millilitres:String){
        // Assigns values to all text fields
        litreTextField.text = litres
        pintTextField.text = pints
        fluidOunceTextField.text = ounces
        gallonTextField.text = gallons
        millilitreTextField.text = millilitres
    }
    
    func keyWasTapped(character: String) {
        // Handles which key was pressed
        if (character == "del" && self.activeField.text!.count > 0){
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
        
        // Handles which field the key was pressed in
        if (self.activeField.text?.count ?? 0 > 0 && self.activeField.text?.last != "."){
            switch activeField{
            case gallonTextField:
                calcFromGallons()
                break
            case litreTextField:
                calcFromLitres()
                break
            case pintTextField:
                calcFromPint()
                break
            case fluidOunceTextField:
                calcFromOunces()
                break
            case millilitreTextField:
                calcFromMillilitres()
                break
            default:
                setToDefaults()
            }
        }
    }
    
    // Restores text fields to default values
    func setToDefaults(){
        gallonTextField.text? = ""
        litreTextField.text? = ""
        pintTextField.text? = ""
        fluidOunceTextField.text? = ""
        millilitreTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Event listener for text field being edited
        self.activeField = textField
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Handles saving field values to history
        let gallon = gallonTextField.text
        let litre = litreTextField.text
        let pint = pintTextField.text
        let ounce = fluidOunceTextField.text
        let millilitre = millilitreTextField.text
        
        if (gallon == "" || gallon?.last == "."){
            return
        }
        
        if (gallon == "" || gallon?.last == "."){
            return
        }
        
        if (pint == "" || pint?.last == "."){
            return
        }
        
        if (ounce == "" || ounce?.last == "."){
            return
        }
        
        if (millilitre == "" || millilitre?.last == "."){
            return
        }
        
        // Creates struct to store Liquid values
        let liquidItem = Liquid(gallons: gallon ?? "0.0", litres: litre ?? "0.0", pints: pint ?? "0.0", ounces: ounce ?? "0.0", millilitres: millilitre ?? "0.0")
        
        // Checks for space in initial 5 values
        for index in 1...5 {
            if (UserDefaults.standard.object(forKey: ("liquid" + String(index))) == nil){
                UserDefaults.standard.set(try? PropertyListEncoder().encode(liquidItem), forKey: ("liquid" + String(index)))
                return
            }
        }
        
        // Handles shuffling values and placing new value if the queue is full
        for index in 1...4 {
            guard let data = UserDefaults.standard.object(forKey: ("liquid" + String(index+1))) as? Data else {
                return
            }
            
            guard let liquid = try? PropertyListDecoder().decode(Liquid.self, from: data) else {
                return
            }
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(liquid), forKey: ("liquid" + String(index)))
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(liquidItem), forKey: "liquid5")
        
    }
}
