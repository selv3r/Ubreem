////
////  GenericTextField.swift
////  General Project
////
////  Created by Mina Shehata Gad on 5/4/18.
////  Copyright © 2018 Mina Shehata Gad. All rights reserved.
////
//
import UIKit
import Material

class MatrialTextField: ErrorTextField {

    func prepareCustomTextField(with placeholder: String = "", and detail: String = "", IsClearIconButtonEnabled: Bool = false, IsPlaceholderUppercasedWhenEditing: Bool = false, image: UIImage? = nil, PlaceholderAnimation: TextFieldPlaceholderAnimation = .default, PlaceholderNormalColor: UIColor = .clear, PlaceholderActiveColor: UIColor = .clear, DividerNormalColor: UIColor = .clear, DividerActiveColor: UIColor = .clear, TextInset: CGFloat = 0, IsVisibilityIconButtonEnabled: Bool = false, ClearButtonMode: UITextFieldViewMode = .whileEditing, visibilityIconButtonTintColor: UIColor = .clear, leftImage: UIImage? = nil) {
        self.placeholder = placeholder
        self.detail = detail
        self.isClearIconButtonEnabled = IsClearIconButtonEnabled
        self.isPlaceholderUppercasedWhenEditing = IsPlaceholderUppercasedWhenEditing
        self.placeholderAnimation = PlaceholderAnimation
        // Set the colors for the emailField, different from the defaults.
        self.placeholderNormalColor = PlaceholderNormalColor // for place holder normal
        self.placeholderActiveColor = PlaceholderActiveColor
        self.dividerNormalColor = DividerNormalColor
        self.dividerActiveColor = DividerActiveColor
        self.textAlignment = LanguageManager.shared.isRightToLeft ? .right : .left
        // aditional properties
        self.clearButtonMode = ClearButtonMode
        self.isVisibilityIconButtonEnabled = IsVisibilityIconButtonEnabled
        // Setting the visibilityIconButton color.
        self.visibilityIconButton?.tintColor = visibilityIconButtonTintColor

        // Set the text inset
        self.textInset = TextInset

        if leftImage != nil {
            let imageView = UIImageView()
            imageView.image = leftImage
            self.leftView = imageView
        }
    }
    
    override var textInputMode: UITextInputMode? {
        for tim  in UITextInputMode.activeInputModes {
            if tim.primaryLanguage!.contains("en") {
                return tim
            }
        }
        return super.textInputMode
    }
    
}
