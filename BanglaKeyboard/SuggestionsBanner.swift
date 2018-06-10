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
	var leftButton = UIButton(type: UIButtonType.system)
	var middleButton = UIButton(type: .system)
	var rightButton = UIButton(type: .system)

	required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
		super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
		addSubview(leftButton)
		addSubview(middleButton)
		addSubview(rightButton)
		leftButton.tintColor = .white
		leftButton.backgroundColor = GlobalColors.lightModeSolidColorSpecialKey
		middleButton.tintColor = .white
		middleButton.backgroundColor = GlobalColors.lightModeSolidColorSpecialKey
		rightButton.tintColor = .white
		rightButton.backgroundColor = GlobalColors.lightModeSolidColorSpecialKey
		updateSuggestions(array: [])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setNeedsLayout() {
		super.setNeedsLayout()
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
			leftButton.isHidden = true
			middleButton.isHidden = true
			rightButton.isHidden = true
		case 1:
			leftButton.isHidden = true
			middleButton.isHidden = false
			middleButton.setTitle(array[0], for: .normal)
			rightButton.isHidden = true
		case 2:
			leftButton.isHidden = true
			middleButton.isHidden = false
			middleButton.setTitle(array[0], for: .normal)
			rightButton.isHidden = false
			rightButton.setTitle(array[1], for: .normal)
		default:
			leftButton.isHidden = false
			leftButton.setTitle(array[0], for: .normal)
			middleButton.isHidden = false
			middleButton.setTitle(array[0], for: .normal)
			rightButton.isHidden = false
			rightButton.setTitle(array[1], for: .normal)
		}
	}
	
	func didPress(_ sender: UIButton) {
		keyboardViewController?.keyPressed(<#T##key: Key##Key#>)
	}
}
