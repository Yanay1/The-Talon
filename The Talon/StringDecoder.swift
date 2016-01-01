//
//  StringDecoder.swift
//  The Talon
//
//  Created by Yanay Rosen on 12/31/15.
//  Copyright © 2015 Yanay Rosen. All rights reserved.
//

import Foundation
import UIKit
import WebKit

extension String {
    init(htmlEncodedString: String) {
        let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        
        var attributedString:NSAttributedString?
        
        do{
            attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
        }catch{
            print(error)
        }
        
        self.init(attributedString!.string)
    }
}
