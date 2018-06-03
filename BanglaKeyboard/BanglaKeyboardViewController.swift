//
//  BanglaKeyboardViewController.swift
//  BanglaKeyboard
//
//  Created by Nawfil Afif Nibir on 2/23/17.
//  Copyright © 2017 Nawfil Afif Nibir. All rights reserved.
//

import UIKit

class BanglaKeyboardViewController: KeyboardViewController {
    static let avro = AvroKeyboardController.init()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    override func keyPressed(_ key: Key) {
        let textDocumentProxy = self.textDocumentProxy
        
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        BanglaKeyboardViewController.avro.inputText(keyOutput, client: self)
        textDocumentProxy.insertText(keyOutput)
    }
}
