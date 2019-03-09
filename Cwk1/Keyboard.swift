//
//  Keyboard.swift
//  Cwk1
//
//  Created by stackoverflow user on 3/5/19.
//  Copyright © 2019 user149138. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
}

// This code was taken from a stackoverflow post about custom keyboards

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
class Keyboard: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // The view controller will adopt this protocol (delegate)
    // and thus must contain the keyWasTapped method
    
    
    // This variable will be set as the view controller so that
    // the keyboard can send messages to the view controller.
    weak var delegate: KeyboardDelegate?
    @IBOutlet weak var negateButton: UIButton!
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    func enableNegateButton() {
        // Enables the positive/negative button on the temperature view
        negateButton.isEnabled = true
        negateButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        negateButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    // MARK:- Button actions from .xib file
    
    @IBAction func tapped(_ sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        self.delegate?.keyWasTapped(character: sender.titleLabel!.text!) // could alternatively send a tag value
    }
}
