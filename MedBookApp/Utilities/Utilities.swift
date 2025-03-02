//
//  Utilities.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let img = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        img.image = image
        view.addSubview(img)
        img.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                  paddingLeft: 8, paddingBottom: 8)
        img.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: img.rightAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                           right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
    func attributedButton(withText text: String,
                          andImageName imageName: String,
                          backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: text)
        // Adding space between text and arrow
        attributedTitle.append(NSAttributedString(string: " "))
        // Adding right arrow icon with background color
        if let image = UIImage(systemName: imageName)?.withTintColor(backgroundColor) {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image
            let imageString = NSAttributedString(attachment: imageAttachment)
            let boldImageString = NSMutableAttributedString(attributedString: imageString)
            boldImageString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: boldImageString.length))
            attributedTitle.append(boldImageString)
        }
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(backgroundColor, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }
    
}
