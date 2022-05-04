//
//  Theme.swift
//  Cornerr
//
//  Created by Tony Chen on 5/1/22.
//

import UIKit

extension UIColor {
    
    static let lightBlue = UIColor.init(red: 0.64, green: 0.73, blue: 0.93, alpha: 1.0)
    static let skyBlue = UIColor.init(red: 0.64, green: 0.86, blue: 0.93, alpha: 1)
    static let darkBlue = UIColor.init(red: 0.27, green: 0.44, blue: 0.82, alpha: 1.0)
    static let blue = UIColor.init(red: 0.65, green: 0.85, blue: 1.0, alpha: 1.0)
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
            let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            var color: UInt32 = 0
            scanner.scanHexInt32(&color)
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            self.init(red:red, green:green, blue:blue, alpha:alpha)
        }
    
        func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return String(format:"#%06x", rgb)
        }
}

extension CGColor {
    
    static let lightBlue = CGColor.init(red: 0.64, green: 0.73, blue: 0.93, alpha: 1.0)
    static let skyBlue = CGColor.init(red: 0.64, green: 0.86, blue: 0.93, alpha: 1)
    static let darkBlue = CGColor.init(red: 0.27, green: 0.44, blue: 0.82, alpha: 1.0)
    static let blue = CGColor.init(red: 0.65, green: 0.85, blue: 1.0, alpha: 1.0)
}


extension UITextField {
    func addBottomBorder(){
        let borderView = UIView()
        borderView.backgroundColor = .lightBlue
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.widthAnchor.constraint(equalToConstant: 260),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
