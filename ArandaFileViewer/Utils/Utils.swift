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
        return NSLocalizedString(name, comment: "nil")
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
    
  
}
