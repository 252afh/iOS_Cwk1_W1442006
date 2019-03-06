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
    @IBOutlet weak var kilogramTextField: UITextField!
    @IBOutlet weak var stonePoundTextField: UITextField!
    @IBOutlet weak var poundTextField: UITextField!
    @IBOutlet weak var stoneTextField: UITextField!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var ounceTextField: UITextField!
    var activeField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
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
    
    func keyWasTapped(character: String) {
        let keyVal = character
        
        if (keyVal == "del"){
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
        
        if (activeField.text?.count ?? 0 > 0 && activeField.text?.last != "."){
            switch activeField {
            case kilogramTextField:
                let kilograms = Double(kilogramTextField.text!)
                let grams = kilograms!*1000.0
                let ounce = kilograms!*35.274
                let pound = kilograms!*2.20462
                let stone = String(format: "%.4f", pound/14)
                let stoneString = stone.split(separator: ".")[0]
                let stoneDecimalString = "0." + stone.split(separator: ".")[1]
                let stonePound = String(format: "%.4f",(Double(stoneDecimalString)!*14))
                
                gramTextField.text = String(format: "%.4f", grams)
                ounceTextField.text = String(format: "%.4f", ounce)
                poundTextField.text = String(format: "%.4f", pound)
                stoneTextField.text = String(stoneString)
                stonePoundTextField.text = stonePound
                break
            case gramTextField:
                let grams = Double(gramTextField.text!)
                let kilograms = grams!/1000
                let ounce = grams!/28.35
                let pound = grams!/453.592
                let stone = String(format: "%.4f", pound/14)
                let stoneString = stone.split(separator: ".")[0]
                let stoneDecimalString = "0." + stone.split(separator: ".")[1]
                let stonePound = String(format: "%.4f",(Double(stoneDecimalString)!*14))
                
                kilogramTextField.text = String(format: "%.4f", kilograms)
                ounceTextField.text = String(format: "%.4f", ounce)
                poundTextField.text = String(format: "%.4f", pound)
                stoneTextField.text = String(stoneString)
                stonePoundTextField.text = stonePound
                break
            case ounceTextField:
                let ounces = Double(ounceTextField.text!)
                let kilograms = ounces!/35.274
                let grams = ounces!*28.3495
                let pound = ounces!/16
                let stone = String(format: "%.4f", pound/14)
                let stoneString = stone.split(separator: ".")[0]
                let stoneDecimalString = "0." + stone.split(separator: ".")[1]
                let stonePound = String(format: "%.4f",(Double(stoneDecimalString)!*14))
                
                kilogramTextField.text = String(format: "%.4f", kilograms)
                gramTextField.text = String(format: "%.4f", grams)
                poundTextField.text = String(format: "%.4f", pound)
                stoneTextField.text = String(stoneString)
                stonePoundTextField.text = stonePound
                break
            case poundTextField:
                let pounds = Double(poundTextField.text!)
                let kilograms = pounds!/2.205
                let grams = pounds!*453.592
                let ounces = pounds!*16
                let stone = String(format: "%.4f", pounds!/14)
                let stoneString = stone.split(separator: ".")[0]
                let stoneDecimalString = "0." + stone.split(separator: ".")[1]
                let stonePound = String(format: "%.4f",(Double(stoneDecimalString)!*14))
                
                kilogramTextField.text = String(format: "%.4f", kilograms)
                gramTextField.text = String(format: "%.4f", grams)
                ounceTextField.text = String(format: "%.4f", ounces)
                stoneTextField.text = String(stoneString)
                stonePoundTextField.text = stonePound
                break
            case stoneTextField:
                let stones = Double(stoneTextField.text!)! + (Double(stonePoundTextField.text!)!/14)
                let kilograms = stones*6.35
                let grams = stones*6350.293
                let ounces = stones*224
                let pounds = stones*14
                
                kilogramTextField.text = String(format: "%.4f", kilograms)
                gramTextField.text = String(format: "%.4f", grams)
                ounceTextField.text = String(format: "%.4f", ounces)
                poundTextField.text = String(format: "%.4f", pounds)
                break
            case stonePoundTextField:
                let stones = Double(stoneTextField.text!)! + (Double(stonePoundTextField.text!)!/14)
                let kilograms = stones*6.35
                let grams = stones*6350.293
                let ounces = stones*224
                let pounds = stones*14
                
                kilogramTextField.text = String(format: "%.4f", kilograms)
                gramTextField.text = String(format: "%.4f", grams)
                ounceTextField.text = String(format: "%.4f", ounces)
                poundTextField.text = String(format: "%.4f", pounds)
                break
            default:
                setToDefaults()
            }
        }
    }
    
    func setToDefaults(){
        kilogramTextField.text? = ""
        gramTextField.text? = ""
        ounceTextField.text? = ""
        poundTextField.text? = ""
        stoneTextField.text? = ""
        stonePoundTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
}
