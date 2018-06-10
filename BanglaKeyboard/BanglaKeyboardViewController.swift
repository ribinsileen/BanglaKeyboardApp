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
	static var currentCount = 0

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
	
	override func createBanner() -> ExtraView? {
		let banner = SuggestionsBanner(globalColors: type(of: self).globalColors, darkMode: false, solidColorMode: self.solidColorMode())
		banner.keyboardViewController = self
		return banner
	}
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
	
	override func backspaceDown(_ sender: KeyboardKey) {
		super.backspaceDown(sender)
		BanglaKeyboardViewController.avro.deleteBackward(self)
	}
	
	fileprivate func resetAvro() {
		BanglaKeyboardViewController.avro.composedBuffer = ""
		BanglaKeyboardViewController.avro.currentCandidates = NSMutableArray()
		BanglaKeyboardViewController.currentCount = 0
	}
	
	override func keyPressed(_ key: Key) {
		//handle return later
		if key.type == .space {
			let textDocumentProxy = self.textDocumentProxy
			if textDocumentProxy.documentContextBeforeInput?.last == " " {
				textDocumentProxy.insertText(" ")
			}
			else {
				let replacementWord = BanglaKeyboardViewController.avro.currentCandidates[0] as? String
				for _ in 0...BanglaKeyboardViewController.currentCount {
					textDocumentProxy.deleteBackward()
				}
				if let replacementWord = replacementWord {
					textDocumentProxy.insertText(replacementWord + " ")
				}
				resetAvro()
			}
		}
		if key.type == .character || key.type == .period || key.type == .specialCharacter {
			let keyOutput = key.outputForCase(self.shiftState.uppercase())
			BanglaKeyboardViewController.avro.inputText(keyOutput, client: self)
			textDocumentProxy.insertText(keyOutput)
			BanglaKeyboardViewController.currentCount += 1
		}
		(bannerView as! SuggestionsBanner).updateSuggestions(array: BanglaKeyboardViewController.avro.currentCandidates as! [String])
    }
	
	func insert(suggestion: String) {
		textDocumentProxy.insertText(suggestion)
	}
}
