//
//  LengthViewController.swift
//  Cwk1
//
//  Created by user149138 on 3/5/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation
import UIKit

class LengthViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    // Text fields used for user input
    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var millimetreTextField: UITextField!
    @IBOutlet weak var centimetreTextField: UITextField!
    
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
        metreTextField.delegate = self
        metreTextField.inputView = keyboardView
        
        mileTextField.delegate = self
        mileTextField.inputView = keyboardView
        
        inchTextField.delegate = self
        inchTextField.inputView = keyboardView
        
        yardTextField.delegate = self
        yardTextField.inputView = keyboardView
        
        millimetreTextField.delegate = self
        millimetreTextField.inputView = keyboardView
        
        centimetreTextField.delegate = self
        centimetreTextField.inputView = keyboardView
        
    }
    
    func calcFromMetres() {
        // Calculate amounts from metres
        let metres = Double(metreTextField.text ?? "0.0")
        let miles = String(format: "%.4f", ((metres ?? 0.0)/1609.344))
        let inches = String(format: "%.4f", ((metres ?? 0.0)*39.37))
        let yards = String(format: "%.4f", ((metres ?? 0.0)*1.094))
        let millimetres = String(format: "%.4f", ((metres ?? 0.0)*1000))
        let centimetres = String(format: "%.4f", ((metres ?? 0.0)*100))
        
        setTextFields(metres: (metreTextField.text ?? "0.0"), miles: miles, centimetres: centimetres, yards: yards, millimetres: millimetres, inches: inches)
    }
    
    func calcFromMiles() {
        // Calculate amounts from miles
        let miles = Double(mileTextField.text ?? "0.0")
        let metres = String(format: "%.4f", ((miles ?? 0.0)*1609.344))
        let inches = String(format: "%.4f", ((miles ?? 0.0)*63360))
        let yards = String(format: "%.4f", ((miles ?? 0.0)*1760))
        let millimetres = String(format: "%.4f", ((miles ?? 0.0)*1609344))
        let centimetres = String(format: "%.4f", ((miles ?? 0.0)*160934.4))
        
        setTextFields(metres: metres, miles: (mileTextField.text ?? "0.0"), centimetres: centimetres, yards: yards, millimetres: millimetres, inches: inches)
    }
    
    func calcFromInches() {
        // Calculate amounts from inches
        let inches = Double(inchTextField.text ?? "0.0")
        let metres = String(format: "%.4f", ((inches ?? 0.0)/39.37))
        let miles = String(format: "%.4f", ((inches ?? 0.0)/63360))
        let yards = String(format: "%.4f", ((inches ?? 0.0)/36))
        let millimetres = String(format: "%.4f", ((inches ?? 0.0)*25.4))
        let centimetres = String(format: "%.4f", ((inches ?? 0.0)*2.54))
        
        setTextFields(metres: metres, miles: miles, centimetres: centimetres, yards: yards, millimetres: millimetres, inches: (inchTextField.text ?? "0.0"))
    }
    
    func calcFromYards() {
        // Calculate amounts from yards
        let yards = Double(yardTextField.text ?? "0.0")
        let metres = String(format: "%.4f", ((yards ?? 0.0)/1.094))
        let miles = String(format: "%.4f", ((yards ?? 0.0)/1760))
        let inches = String(format: "%.4f", ((yards ?? 0.0)*36))
        let millimetres = String(format: "%.4f", ((yards ?? 0.0)*914.4))
        let centimetres = String(format: "%.4f", ((yards ?? 0.0)*91.44))
        
        setTextFields(metres: metres, miles: miles, centimetres: centimetres, yards: (yardTextField.text ?? "0.0"), millimetres: millimetres, inches: inches)
    }
    
    func calcFromMillilitres() {
        // Calculate amounts from millimitres
        let millimetres = Double(millimetreTextField.text ?? "0.0")
        let metres = String(format: "%.4f", ((millimetres ?? 0.0)/1000))
        let miles = String(format: "%.4f", ((millimetres ?? 0.0)/1609344))
        let yards = String(format: "%.4f", ((millimetres ?? 0.0)/914.4))
        let inches = String(format: "%.4f", ((millimetres ?? 0.0)/25.4))
        let centimetres = String(format: "%.4f", ((millimetres ?? 0.0)/10))
        
        setTextFields(metres: metres, miles: miles, centimetres: centimetres, yards: yards, millimetres: (millimetreTextField.text ?? "0.0"), inches: inches)
    }
    
    func calcFromCentimetres() {
        // Calculate amounts from centimetres
        let centimetres = Double(centimetreTextField.text ?? "0.0")
        let metres = String(format: "%.4f", ((centimetres ?? 0.0)/100))
        let miles = String(format: "%.4f", ((centimetres ?? 0.0)/160934.4))
        let yards = String(format: "%.4f", ((centimetres ?? 0.0)/91.44))
        let millimetres = String(format: "%.4f", ((centimetres ?? 0.0)*10))
        let inches = String(format: "%.4f", ((centimetres ?? 0.0)/2.54))
        
        setTextFields(metres: metres, miles: miles, centimetres: (centimetreTextField.text ?? "0.0"), yards: yards, millimetres: millimetres, inches: inches)
    }
    
    func setTextFields(metres:String, miles:String, centimetres:String, yards:String, millimetres:String, inches:String){
        // Assigns values to corresponding text fields
        metreTextField.text = metres
        mileTextField.text = miles
        yardTextField.text = yards
        millimetreTextField.text = millimetres
        centimetreTextField.text = centimetres
        inchTextField.text = inches
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
        
        // Handles which field the value was entered into
        if (self.activeField.text?.count ?? 0 > 0 && self.activeField.text?.last != "."){
            switch self.activeField {
            case metreTextField:
                calcFromMetres()
                break
            case mileTextField:
                calcFromMiles()
                break
            case inchTextField:
                calcFromInches()
                break
            case yardTextField:
                calcFromYards()
                break
            case millimetreTextField:
                calcFromMillilitres()
                break
            case centimetreTextField:
                calcFromCentimetres()
                break
            default:
                setToDefaults()
            }
        }
    }
    
    func setToDefaults(){
        // Resets all text fields to default values
        metreTextField.text? = ""
        mileTextField.text? = ""
        inchTextField.text? = ""
        yardTextField.text? = ""
        millimetreTextField.text? = ""
        centimetreTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Handles which field is currently active
        self.activeField = textField
    }}
