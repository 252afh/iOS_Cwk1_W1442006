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
    @IBOutlet weak var metresPerSecondTextField: UITextField!
    @IBOutlet weak var knotsTextField: UITextField!
    @IBOutlet weak var milesPerHourTextField: UITextField!
    @IBOutlet weak var kilometresPerHourTextField: UITextField!
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
        metresPerSecondTextField.delegate = self
        metresPerSecondTextField.inputView = keyboardView
        
        knotsTextField.delegate = self
        knotsTextField.inputView = keyboardView
        
        milesPerHourTextField.delegate = self
        milesPerHourTextField.inputView = keyboardView
        
        kilometresPerHourTextField.delegate = self
        kilometresPerHourTextField.inputView = keyboardView
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
        
        if (self.activeField.text?.count ?? 0 > 0 && self.activeField.text != "."){
            switch self.activeField{
            case metresPerSecondTextField:
                let ms = Double(metresPerSecondTextField.text!)
                let kph = ms!*3.6
                let mph = ms!*2.237
                let knots = ms!*1.944
                
                kilometresPerHourTextField.text = String(format: "%.4f", kph)
                milesPerHourTextField.text = String(format: "%.4f", mph)
                knotsTextField.text = String(format: "%.4f", knots)
                break
            case kilometresPerHourTextField:
                let kph = Double(kilometresPerHourTextField.text!)
                let ms = kph!/3.6
                let mph = kph!/1.609
                let knots = kph!/1.852
                
                metresPerSecondTextField.text = String(format: "%.4f", ms)
                milesPerHourTextField.text = String(format: "%.4f", mph)
                knotsTextField.text = String(format: "%.4f", knots)
                break
            case milesPerHourTextField:
                let mph = Double(milesPerHourTextField.text!)
                let kph = mph!*1.609
                let ms = mph!/2.237
                let knots = mph!/1.151
                
                kilometresPerHourTextField.text = String(format: "%.4f", kph)
                metresPerSecondTextField.text = String(format: "%.4f", ms)
                knotsTextField.text = String(format: "%.4f", knots)
                break
            case knotsTextField:
                let knots = Double(knotsTextField.text!)
                let kph = knots!*1.852
                let mph = knots!*1.151
                let ms = knots!/1.944
                
                kilometresPerHourTextField.text = String(format: "%.4f", kph)
                milesPerHourTextField.text = String(format: "%.4f", mph)
                metresPerSecondTextField.text = String(format: "%.4f", ms)
                break
            default:
                setToDefaults()
            }
        }
    }
    
    func setToDefaults(){
        metresPerSecondTextField.text? = ""
        kilometresPerHourTextField.text? = ""
        milesPerHourTextField.text? = ""
        knotsTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
}
