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
    
    
    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var millimetreTextField: UITextField!
    @IBOutlet weak var centimetreTextField: UITextField!
    var activeField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        let keyboardView = Keyboard(frame:  CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self as KeyboardDelegate
        
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
        millimetreTextField.inputView = keyboardView
        
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
        
        switch self.activeField {
        case metreTextField:
            let metres = Double(metreTextField.text!)
            let miles = metres!/1609.344
            let inches = metres!*39.37
            let yards = metres!*1.094
            let millimetres = metres!*1000
            let centimetres = metres!*100
            
            mileTextField.text = String(format: "%.4f", miles)
            inchTextField.text = String(format: "%.4f", inches)
            yardTextField.text = String(format: "%.4f", yards)
            millimetreTextField.text = String(format: "%.4f", millimetres)
            centimetreTextField.text = String(format: "%.4f", centimetres)
            break
        case mileTextField:
            let miles = Double(mileTextField.text!)
            let metres = miles!*1609.344
            let inches = miles!*63360
            let yards = miles!*1760
            let millimetres = miles!*1609344
            let centimetres = miles!*160934.4
            
            metreTextField.text = String(format: "%.4f", metres)
            inchTextField.text = String(format: "%.4f", inches)
            yardTextField.text = String(format: "%.4f", yards)
            millimetreTextField.text = String(format: "%.4f", millimetres)
            centimetreTextField.text = String(format: "%.4f", centimetres)
            break
        case inchTextField:
            let inches = Double(inchTextField.text!)
            let metres = inches!/39.37
            let miles = inches!/63360
            let yards = inches!/36
            let millimetres = inches!*25.4
            let centimetres = inches!*2.54
            
            metreTextField.text = String(format: "%.4f", metres)
            mileTextField.text = String(format: "%.4f", miles)
            yardTextField.text = String(format: "%.4f", yards)
            millimetreTextField.text = String(format: "%.4f", millimetres)
            centimetreTextField.text = String(format: "%.4f", centimetres)
            break
        case yardTextField:
            let yards = Double(yardTextField.text!)
            let metres = yards!/1.094
            let miles = yards!/1760
            let inches = yards!*36
            let millimetres = yards!*914.4
            let centimetres = yards!*91.44
            
            metreTextField.text = String(format: "%.4f", metres)
            mileTextField.text = String(format: "%.4f", miles)
            inchTextField.text = String(format: "%.4f", inches)
            millimetreTextField.text = String(format: "%.4f", millimetres)
            centimetreTextField.text = String(format: "%.4f", centimetres)
            break
        case millimetreTextField:
            let millimetres = Double(millimetreTextField.text!)
            let metres = millimetres!/1000
            let miles = millimetres!/1609344
            let yards = millimetres!/914.4
            let inches = millimetres!/25.4
            let centimetres = millimetres!/10
            
            metreTextField.text = String(format: "%.4f", metres)
            mileTextField.text = String(format: "%.4f", miles)
            yardTextField.text = String(format: "%.4f", yards)
            inchTextField.text = String(format: "%.4f", inches)
            centimetreTextField.text = String(format: "%.4f", centimetres)
            break
        case centimetreTextField:
            let centimetres = Double(centimetreTextField.text!)
            let metres = centimetres!/100
            let miles = centimetres!/160934.4
            let yards = centimetres!/91.44
            let millimetres = centimetres!*10
            let inches = centimetres!/2.54
            
            metreTextField.text = String(format: "%.4f", metres)
            mileTextField.text = String(format: "%.4f", miles)
            yardTextField.text = String(format: "%.4f", yards)
            millimetreTextField.text = String(format: "%.4f", millimetres)
            inchTextField.text = String(format: "%.4f", inches)
            break
        default:
            setToDefaults()
        }
    }
    
    func setToDefaults(){
        metreTextField.text? = ""
        mileTextField.text? = ""
        inchTextField.text? = ""
        yardTextField.text? = ""
        millimetreTextField.text? = ""
        centimetreTextField.text? = ""
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let metres = metreTextField.text
        let miles = mileTextField.text
        let yards = yardTextField.text
        let millimetres = millimetreTextField.text
        let centimetres = centimetreTextField.text
        let inches = inchTextField.text
        
        if (metres == "" || metres?.last == "."){
            return
        }
        
        if (miles == "" || miles?.last == "."){
            return
        }
        
        if (yards == "" || yards?.last == "."){
            return
        }
        
        if (millimetres == "" || millimetres?.last == "."){
            return
        }
        
        if (centimetres == "" || centimetres?.last == "."){
            return
        }
        
        if (inches == "" || inches?.last == "."){
            return
        }
        
        let lengthItem = Length(metres: metres!, miles: miles!, centimetres: centimetres!, millimetres: millimetres!, yards: yards!, inches: inches!)
        if (UserDefaults.standard.object(forKey: "length1") == nil){
            UserDefaults.standard.set(try? PropertyListEncoder().encode(lengthItem), forKey: "length1")
        }
        else if (UserDefaults.standard.object(forKey: "length2") == nil){
            UserDefaults.standard.set(try? PropertyListEncoder().encode(lengthItem), forKey: "length2")
        }
        else if (UserDefaults.standard.object(forKey: "length3") == nil){
            UserDefaults.standard.set(try? PropertyListEncoder().encode(lengthItem), forKey: "length3")
        }
        else if (UserDefaults.standard.object(forKey: "length4") == nil){
            UserDefaults.standard.set(try? PropertyListEncoder().encode(lengthItem), forKey: "length4")
        }
        else if (UserDefaults.standard.object(forKey: "length5") == nil){
            UserDefaults.standard.set(try? PropertyListEncoder().encode(lengthItem), forKey: "length5")
        }
        else{
            guard var data2 = UserDefaults.standard.object(forKey: "length2") as? Data else {
                return
            }
            
            guard let length2 = try? PropertyListDecoder().decode(Length.self, from: data2) else {
                return
            }
            
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(length2), forKey: "length1")
            
            
            guard var data3 = UserDefaults.standard.object(forKey: "length3") as? Data else {
                return
            }
            
            guard let length3 = try? PropertyListDecoder().decode(Length.self, from: data3) else {
                return
            }
            
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(length3), forKey: "length2")
            
            
            guard var data4 = UserDefaults.standard.object(forKey: "length4") as? Data else {
                return
            }
            
            guard let length4 = try? PropertyListDecoder().decode(Length.self, from: data4) else {
                return
            }
            
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(length4), forKey: "length3")
            
            
            guard var data5 = UserDefaults.standard.object(forKey: "length5") as? Data else {
                return
            }
            
            guard let length5 = try? PropertyListDecoder().decode(Length.self, from: data5) else {
                return
            }
            
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(length5), forKey: "length4")
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(lengthItem), forKey: "length5")
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }}
