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
    @IBOutlet weak var gallonTextField: UITextField!
    @IBOutlet weak var millilitreTextField: UITextField!
    @IBOutlet weak var fluidOunceTextField: UITextField!
    @IBOutlet weak var pintTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
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
    
    func keyWasTapped(character: String) {
        let keyVal = character
        
        if (keyVal == "del" && self.activeField.text!.count > 0){
            self.activeField.text = String(self.activeField.text?.dropLast() ?? "")
        }
        else if (keyVal == "."){
            if (self.activeField.text?.count ?? 0 > 0 &&
                self.activeField.text?.contains(".") == false){
                self.activeField.text? += "."
            }
        }
        else{
            self.activeField.text? += keyVal
        }
        
        switch activeField{
        case gallonTextField:
            let gallons = Double(gallonTextField.text!)
            let litres = gallons!*4.546
            let pints = gallons!*8
            let ounces = gallons!*160
            let millilitres = gallons!*4546.09
            
            litreTextField.text = String(format: "%.4f", litres)
            pintTextField.text = String(format: "%.4f", pints)
            fluidOunceTextField.text = String(format: "%.4f", ounces)
            millilitreTextField.text = String(format: "%.4f", millilitres)
            break
        case litreTextField:
            let litres = Double(litreTextField.text!)
            let gallons = litres!/4.546
            let pints = litres!*1.76
            let ounces = litres!*35.195
            let millilitres = litres!*1000
            
            gallonTextField.text = String(format: "%.4f", gallons)
            pintTextField.text = String(format: "%.4f", pints)
            fluidOunceTextField.text = String(format: "%.4f", ounces)
            millilitreTextField.text = String(format: "%.4f", millilitres)
            break
        case pintTextField:
            let pints = Double(pintTextField.text!)
            let litres = pints!/1.76
            let gallons = pints!/8
            let ounces = pints!*20
            let millilitres = pints!*568.261
            
            litreTextField.text = String(format: "%.4f", litres)
            gallonTextField.text = String(format: "%.4f", gallons)
            fluidOunceTextField.text = String(format: "%.4f", ounces)
            millilitreTextField.text = String(format: "%.4f", millilitres)
            break
        case fluidOunceTextField:
            let ounces = Double(fluidOunceTextField.text!)
            let litres = ounces!/35.195
            let pints = ounces!/20
            let gallons = ounces!/160
            let millilitres = ounces!*28.413
            
            litreTextField.text = String(format: "%.4f", litres)
            pintTextField.text = String(format: "%.4f", pints)
            gallonTextField.text = String(format: "%.4f", gallons)
            millilitreTextField.text = String(format: "%.4f", millilitres)
            break
        case millilitreTextField:
            let millilitres = Double(millilitreTextField.text!)
            let litres = millilitres!/1000
            let pints = millilitres!/568.261
            let ounces = millilitres!/28.413
            let gallons = millilitres!/4546.09
            
            litreTextField.text = String(format: "%.4f", litres)
            pintTextField.text = String(format: "%.4f", pints)
            fluidOunceTextField.text = String(format: "%.4f", ounces)
            gallonTextField.text = String(format: "%.4f", gallons)
            break
        default:
            setToDefaults()
        }
    }
    
    func setToDefaults(){
        gallonTextField.text? = ""
        litreTextField.text? = ""
        pintTextField.text? = ""
        fluidOunceTextField.text? = ""
        millilitreTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }    
}
