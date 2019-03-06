//
//  TemperatureViewController.swift
//  Cwk1
//
//  Created by user149138 on 3/5/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import Foundation
import UIKit

class TemperatureViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        let keyboardView = Keyboard(frame:  CGRect(x: 200, y: 200, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
        keyboardView.enableNegateButton()
        
        celsiusTextField.delegate = self
        celsiusTextField.inputView = keyboardView
        
        kelvinTextField.delegate = self
        kelvinTextField.inputView = keyboardView
        
        fahrenheitTextField.delegate = self
        fahrenheitTextField.inputView = keyboardView
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
        else if (keyVal == "neg/pos"){
            if (self.activeField.text?.starts(with: "-") ?? false){
                self.activeField.text? = String(self.activeField.text?.dropFirst() ?? "")
            }
            else{
                self.activeField.text? = "-" + self.activeField.text!
            }
        }
        else{
            self.activeField.text? += keyVal
        }
        if (self.activeField.text?.count ?? 0 > 0){
            if(self.activeField.text == "-" || self.activeField.text == "-."){
                return
            }
                print(self.activeField.text!)
                print(String(self.activeField.text != "-"))
                switch self.activeField {
                case celsiusTextField:
                    let celsius = Double(celsiusTextField.text!)
                    let fahrenheit = (celsius!*1.8)+32
                    let kelvin = celsius!+273.15
                    
                    fahrenheitTextField.text = String(format: "%.4f", fahrenheit)
                    kelvinTextField.text = String(format: "%.4f", kelvin)
                    break
                case fahrenheitTextField:
                    let fahrenheit = Double(fahrenheitTextField.text!)
                    let celsius = (fahrenheit!-32)*0.555
                    let kelvin = ((fahrenheit!-32)*0.555)+273.15
                    
                    celsiusTextField.text = String(format: "%.4f", celsius)
                    kelvinTextField.text = String(format: "%.4f", kelvin)
                    break
                case kelvinTextField:
                    let kelvin = Double(kelvinTextField.text!)
                    let fahrenheit = ((kelvin!-273.15)*1.8)+32
                    let celsius = kelvin!-273.15
                    
                    fahrenheitTextField.text = String(format: "%.4f", fahrenheit)
                    celsiusTextField.text = String(format: "%.4f", celsius)
                    break
                default:
                    setToDefaults()
                }
            
        }
    }
    
    func setToDefaults(){
        celsiusTextField.text? = ""
        fahrenheitTextField.text? = ""
        kelvinTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }  
}
