//
//  StringtoPlainText.swift
//  The Talon
//
//  Created by Yanay Rosen on 12/31/15.
//  Copyright © 2015 Yanay Rosen. All rights reserved.
//


import Foundation
import UIKit
import WebKit
extension String{
    func decodeEnt() -> String{
        let encodedData = self.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        let attributedString = NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil, error: nil)!
        
        return attributedString.string
    }
}


