//
//  AppPersonalization.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

extension UIColor {
    static let waterColor = UIColor(named: "waterColorScheme") ?? blue
    static let primaryColor = UIColor(named: "primaryColorScheme") ?? blue
    static let secondaryColor = UIColor(named: "secondaryColorScheme") ?? brown
    static let textColor = UIColor(named: "textColorScheme") ?? black
    static let backgroundColor = UIColor(named: "backgroundColorScheme") ?? white
    static let lightGrayColor = UIColor(named: "lightGrayColorScheme") ?? lightGray
}

extension UIFont {
    static let titleFont = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.bold)
    static let countFont = UIFont.systemFont(ofSize: 64, weight: UIFont.Weight.bold)
    static let subTitleFont = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
    static let descriptionFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)

}
