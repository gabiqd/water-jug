//
//  StyledAlternativeButton.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

class StyledAlternativeButton: UIButton {
    private let nonClickColor = UIColor.primaryColor
    private let clickColor = UIColor.secondaryColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = nonClickColor.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        self.setTitleColor(nonClickColor, for: .normal)
        self.setTitleColor(clickColor, for: .highlighted)
        self.layer.cornerRadius = 8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.layer.borderColor = isHighlighted ? clickColor.cgColor : nonClickColor.cgColor
        }
    }
}
