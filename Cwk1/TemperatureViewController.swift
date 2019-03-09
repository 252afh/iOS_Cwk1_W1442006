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
    // Text fields used for user input
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    // The currently active text fields
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allows the keyboard to minimize when focus is lost
        self.hideKeyboard()
        
        // Creates an instance of a keyboard and settings
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
        // Enables use of the positive/negative button
        keyboardView.enableNegateButton()
        
        // Assigns the keyboard to each input field
        celsiusTextField.delegate = self
        celsiusTextField.inputView = keyboardView
        
        kelvinTextField.delegate = self
        kelvinTextField.inputView = keyboardView
        
        fahrenheitTextField.delegate = self
        fahrenheitTextField.inputView = keyboardView
    }
    
    func calcFromCelsius() {
        // Calculate field amounts from celsius
        let celsius = Double(celsiusTextField.text ?? "0.0")
        let fahrenheit = String(format: "%.4f", (((celsius ?? 0.0)*1.8)+32))
        let kelvin = String(format: "%.4f", ((celsius ?? 0.0)+273.15))
        
        setTextFields(kelvin: kelvin, fahrenheit: fahrenheit, celsius: (celsiusTextField.text ?? "0.0"))
    }
    
    func calcFromFahrenheit() {
        // Calculates field amounts from fahrenheit
        let fahrenheit = Double(fahrenheitTextField.text ?? "0.0")
        let celsius = String(format: "%.4f", (((fahrenheit ?? 0.0)-32)*0.555))
        let kelvin = String(format: "%.4f", ((((fahrenheit ?? 0.0)-32)*0.555)+273.15))
        
        setTextFields(kelvin: kelvin, fahrenheit: (fahrenheitTextField.text ?? "0.0"), celsius: celsius)
    }
    
    func calcFromKelvin() {
        // Calculate field amounts from kelvin
        let kelvin = Double(kelvinTextField.text ?? "0.0")
        let fahrenheit = String(format: "%.4f", ((((kelvin ?? 0.0)-273.15)*1.8)+32))
        let celsius = String(format: "%.4f", ((kelvin ?? 0.0)-273.15))
        
        setTextFields(kelvin: (kelvinTextField.text ?? "0.0"), fahrenheit: fahrenheit, celsius: celsius)
    }
    
    func setTextFields(kelvin:String, fahrenheit:String, celsius:String){
        // Sets values to corresponding text fields
        kelvinTextField.text = kelvin
        fahrenheitTextField.text = fahrenheit
        celsiusTextField.text = celsius
    }
    
    func keyWasTapped(character: String) {
        // Handles which key was tapped
        if (character == "del"){
            self.activeField.text = String(self.activeField.text?.dropLast() ?? "")
        }
        else if (character == "."){
            if (self.activeField.text?.count ?? 0 > 0 &&
                self.activeField.text?.contains(".") == false){
                self.activeField.text? += "."
            }
        }
        else if (character == "neg/pos"){
            if (self.activeField.text?.starts(with: "-") ?? false){
                self.activeField.text? = String(self.activeField.text?.dropFirst() ?? "")
            }
            else{
                self.activeField.text? = "-" + (self.activeField.text ?? "0.0")
            }
        }
        else{
            self.activeField.text? += keyVal
        }
        
        // Handles which field the value was entered in
        if (self.activeField.text?.count ?? 0 > 0 && self.activeField.text?.last != "."){
            if(self.activeField.text == "-" || self.activeField.text == "-."){
                return
            }
                switch self.activeField {
                case celsiusTextField:
                    calcFromCelsius()
                    break
                case fahrenheitTextField:
                    calcFromFahrenheit()
                    break
                case kelvinTextField:
                    calcFromKelvin()
                    break
                default:
                    setToDefaults()
                }
            
        }
    }
    
    func setToDefaults(){
        // Resets field values to default
        celsiusTextField.text? = ""
        fahrenheitTextField.text? = ""
        kelvinTextField.text? = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Sets the currently active field
        self.activeField = textField
    }  
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Handles saving the current field values to history
        let celsius = celsiusTextField.text
        let fahrenheit = fahrenheitTextField.text
        let kelvin = kelvinTextField.text
        
        if (celsius == "" || celsius?.last == "."){
            return
        }
        
        if (fahrenheit == "" || fahrenheit?.last == "."){
            return
        }
        
        if (kelvin == "" || kelvin?.last == "."){
            return
        }
        
        // Creates a temperature struct from the current field values
        let temperatureItem = Temperature(celsius: celsius ?? "0.0", fahrenheit: fahrenheit ?? "0.0", kelvin: kelvin ?? "0.0")
        
        // Checks the history for already stored values
        for index in 1...5 {
            if (UserDefaults.standard.object(forKey: ("temp" + String(index))) == nil){
                UserDefaults.standard.set(try? PropertyListEncoder().encode(temperatureItem), forKey: ("temp" + String(index)))
                return
            }
        }
        
        // Shuffles the history values and assigns a new value if they are full
        for index in 1...4 {
            guard let data = UserDefaults.standard.object(forKey: ("temp" + String(index+1))) as? Data else {
                return
            }
            
            guard let temperature = try? PropertyListDecoder().decode(Temperature.self, from: data) else {
                return
            }
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(temperature), forKey: ("temp" + String(index)))
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(temperatureItem), forKey: "temp5")
    }
}
