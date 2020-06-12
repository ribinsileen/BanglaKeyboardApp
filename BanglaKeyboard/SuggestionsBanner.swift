//
//  SuggestionsBanner.swift
//  BanglaKeyboard
//
//  Created by Nawfil Afif Nibir on 9/6/18.
//  Copyright © 2018 Nawfil Afif Nibir. All rights reserved.
//

import UIKit

class SuggestionsBanner: ExtraView {
	weak var keyboardViewController: BanglaKeyboardViewController?
	override var darkMode: Bool {
		didSet {
			updateAppearance()
		}
	}
    var leftButton = UIButton(type: UIButton.ButtonType.system)
	var middleButton = UIButton(type: .system)
	var rightButton = UIButton(type: .system)
	
	required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
		super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
		addSubview(leftButton)
		addSubview(middleButton)
		addSubview(rightButton)
		updateAppearance()
		leftButton.addTarget(self, action: #selector(didPress(_:)), for: .touchUpInside)
		middleButton.addTarget(self, action: #selector(didPress(_:)), for: .touchUpInside)
		rightButton.addTarget(self, action: #selector(didPress(_:)), for: .touchUpInside)
		updateSuggestions(array: [])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setNeedsLayout() {
		super.setNeedsLayout()
	}
	
	func updateAppearance() {
		if darkMode {
			leftButton.tintColor = .white
			leftButton.backgroundColor = GlobalColors.darkModeSpecialKey
			middleButton.tintColor = .white
			middleButton.backgroundColor = GlobalColors.darkModeSpecialKey
			rightButton.tintColor = .white
			rightButton.backgroundColor = GlobalColors.darkModeSpecialKey
		}
		else {
			leftButton.tintColor = .white
			leftButton.backgroundColor = GlobalColors.lightModeSolidColorSpecialKey
			middleButton.tintColor = .white
			middleButton.backgroundColor = GlobalColors.lightModeSolidColorSpecialKey
			rightButton.tintColor = .white
			rightButton.backgroundColor = GlobalColors.lightModeSolidColorSpecialKey
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		leftButton.frame.size.width = frame.size.width/3 - 0.5
		leftButton.frame.size.height = frame.height
		leftButton.frame.origin = frame.origin
		middleButton.frame.origin.y = leftButton.frame.origin.y
		middleButton.frame.origin.x = leftButton.frame.size.width + 0.75
		middleButton.frame.size = leftButton.frame.size
		rightButton.frame.origin.y = leftButton.frame.origin.y
		rightButton.frame.origin.x = middleButton.frame.size.width * 2 + 1.5
		rightButton.frame.size = leftButton.frame.size
	}
	
	func updateSuggestions(array: [String]) {
		switch array.count {
		case 0:
			leftButton.setTitle("", for: .normal)
			leftButton.isEnabled = false
			middleButton.setTitle("", for: .normal)
			middleButton.isEnabled = false
			rightButton.setTitle("", for: .normal)
			rightButton.isEnabled = false
		case 1:
			leftButton.setTitle("", for: .normal)
			leftButton.isEnabled = false
			middleButton.setTitle(array[0], for: .normal)
			middleButton.isEnabled = true
			rightButton.setTitle("", for: .normal)
			rightButton.isEnabled = false
		case 2:
			leftButton.setTitle("", for: .normal)
			leftButton.isEnabled = false
			middleButton.setTitle(array[0], for: .normal)
			middleButton.isEnabled = true
			rightButton.setTitle(array[1], for: .normal)
			rightButton.isEnabled = true
		default:
			leftButton.setTitle(array[0], for: .normal)
			leftButton.isEnabled = true
			middleButton.setTitle(array[0], for: .normal)
			middleButton.isEnabled = true
			rightButton.setTitle(array[1], for: .normal)
			rightButton.isEnabled = true
		}
	}
	
    @objc func didPress(_ sender: UIButton) {
		if let suggestion = sender.titleLabel?.text {
			keyboardViewController?.insert(suggestion: suggestion)
			updateSuggestions(array: [])
		}
	}
}
