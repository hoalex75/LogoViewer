//
//  ViewController.swift
//  LogoViewer
//
//  Created by Alex on 02/03/2019.
//  Copyright © 2019 Alexandre Holet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var domainTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func search() {
        toggleActivityIndicator(shown: true)
        LogoService.shared.getLogo(domain: getDomain()) { (success, data) in
            if success, let data = data {
                self.logoImageView.image = UIImage(data: data)
            } else {
                self.presentAlert()
            }
            self.toggleActivityIndicator(shown: false)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        domainTextField.resignFirstResponder()
    }
    
    
    private func getDomain() -> String {
        let text = domainTextField.text
        if text == "" {
            return "openclassrooms.com"
        }
        return text!
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "La requête a échoué", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
