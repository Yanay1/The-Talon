//
//  XMLParserTwitter.swift
//  The Talon
//
//  Created by Yanay Rosen on 1/1/16.
//  Copyright © 2016 Yanay Rosen. All rights reserved.
//

import Foundation
//
//  XMLParser.swift
//  The Talon
//
//  Created by Yanay Rosen on 12/24/15.
//  Copyright © 2015 Yanay Rosen. All rights reserved.
//

import UIKit

@objc protocol XMLParserTwitterDelegate{
    
    func parsingWasFinished()
    
}

class XMLParserTwitter: NSObject, NSXMLParserDelegate {
    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var delegate : XMLParserDelegate?
    var isFirst = true
    let media: String = "media:content"
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        
        let parser = NSXMLParser(contentsOfURL: rssURL)
        
        parser!.delegate = self
        
        parser!.parse()
        
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        delegate?.parsingWasFinished()
        
    }
    var elements = NSMutableDictionary()
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        
        
        if elementName == "enclosure" {
            let attrsUrl = attributeDict as [String: String]
            var urlPic = attrsUrl["url"]
            
            
            print(String.self, urlPic)
            elements.setObject(urlPic!, forKey: "enclosure")
            
            currentDataDictionary[currentElement] = urlPic!
            arrParsedData.append(currentDataDictionary)
        }
        
        
        
        
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if !foundCharacters.isEmpty {
            if elementName == "link" || elementName == "description" {
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
            }
            
            
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
            
            if currentElement == "description" && !isFirst
                
            {
                arrParsedData.append(currentDataDictionary)
            }else {
                if currentElement == "urlPic" && isFirst {
                    isFirst = false
                }
                
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if currentElement == "title"
            || currentElement == "link" || currentElement == "description" //|| currentElement == "urlPic"
        {
            
            foundCharacters += string
            
        }
        
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        print(parseError.description)
        
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        
        print(validationError.description)
        
    }
    
}
