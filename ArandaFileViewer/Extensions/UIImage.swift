//
//  UIImage.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 22/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit

extension UIImage {
/*
    var uncompressedPNGData: NSData      { return self.pngData()! as NSData        }
    var highestQualityJPEGNSData: NSData { return self.jpegData(compressionQuality: 1.0)! as NSData  }
    var highQualityJPEGNSData: NSData    { return self.jpegData(compressionQuality: 0.75)! as NSData }
    var mediumQualityJPEGNSData: NSData  { return self.jpegData(compressionQuality: 0.5)! as NSData  }
    var lowQualityJPEGNSData: NSData     { return self.jpegData(compressionQuality: 0.25)! as NSData }
    var lowestQualityJPEGNSData:NSData   { return self.jpegData(compressionQuality: 0.0)! as NSData  }
   
    
    func addLabel(drawText: NSString, atPoint: CGPoint, textColor: UIColor?) -> UIImage{
        
        print("original -> \(self.jpegData(compressionQuality: 1.0)!.count)")
        
        let image = UIImage(data:self.lowQualityJPEGNSData as Data,scale:1.0)
        let size = image!.size
        print("original_NEW -> \(image!.jpegData(compressionQuality: 1.0)!.count)")
        let imageView = UIImageView(image: image)
        
        
        imageView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let sizeFont = size.height * 0.04
        let _textFont = UIFont.systemFont(ofSize: sizeFont)
        let _textColor: UIColor
        
        if textColor == nil {
            _textColor = UIColor.white
        } else {
            _textColor = textColor!
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: size.height - (size.height * 0.09), width: size.width, height: (size.height * 0.09)))
        
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        label.textAlignment = .center
        
        let myAttribute : [NSAttributedString.Key:Any] = [ NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): _textFont, NSAttributedString.Key.foregroundColor: _textColor ]
        let myAttrString = NSAttributedString(string: drawText as String, attributes: myAttribute)
        
        label.attributedText = myAttrString
        //label.text = drawText as String
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        imageView.addSubview(label)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        //label.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }
    
    func addText(drawText: NSString, atPoint: CGPoint, textColor: UIColor?) -> UIImage{
        
       // Setup the font specific variables
        var _textColor: UIColor
        if textColor == nil {
            _textColor = UIColor.white
        } else {
            _textColor = textColor!
        }
        
        var _textFont: UIFont
        
        let sizeFont = size.height * 0.03
        _textFont = UIFont.systemFont(ofSize: sizeFont)
        
        
        // Setup the image context using the passed image
        // Configurar el contexto de la imagen utilizando la imagen pasada
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        // Configurar los atributos de fuente que se usarán más adelante para dictar cómo el texto
        let textFontAttributes : [NSAttributedString.Key:Any]  = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): _textFont,
            NSAttributedString.Key.foregroundColor: _textColor,
            ]
        
        // Put the image into a rectangle as large as the original image
        // Coloca la imagen en un rectángulo tan grande como la imagen original
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Create a point within the space that is as bit as the image
        // Crea un punto dentro del espacio que es tan bit como la imagen
        //size.height - atPoint.y
        let rect = CGRect(x: atPoint.x, y: size.height - (atPoint.y + size.height * 0.03), width: size.width, height: size.height)
        
        // Draw the text into an image
        // Dibuja el texto en una imagen
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        // Crear una nueva imagen de las imágenes que hemos creado
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        // Terminar el contexto ahora que tenemos la imagen que necesitamos
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        // Pasar la imagen de nuevo a la persona que llama
 
        return newImage!
        
    }
*/
    
    func imageWithColor(_ color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
