//
//  Utils.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 22/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    class func stringNamed(_ name: String) -> String {
        return NSLocalizedString(name, bundle: Utils.getBundle(), comment: "nil")
    }
    
    class func getPathFromFile(_ fileName: String) ->String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = URL(fileURLWithPath: paths).appendingPathComponent(fileName)
        return path.path
    }
    
    class func createNewPath(lastPath: String) -> URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let destination = URL(fileURLWithPath: String(format: "%@/%@", documentsDirectory,lastPath))
        return destination
    }
    
    class func removeView(view: UIView){
        for view in view.subviews {
            view.removeFromSuperview()
        }
    }
    
    class func getBundle() -> Bundle {
        return Bundle(for: Utils.self)
    }
    
    class  func setRoundedCornesButton(_ oUIView: UIView, color: UIColor, size: CGFloat) {
        //22.5px=16.875pt
        oUIView.layer.cornerRadius = size
        // oUIView.layer.masksToBounds = true
        oUIView.layer.borderWidth = 1
        oUIView.layer.borderColor = color.cgColor
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
