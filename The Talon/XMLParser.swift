//
//  XMLParser.swift
//  The Talon
//
//  Created by Yanay Rosen on 12/24/15.
//  Copyright © 2015 Yanay Rosen. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{
    
    func parsingWasFinished()
    
}

class XMLParser: NSObject, NSXMLParserDelegate {
    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var delegate : XMLParserDelegate?
    var isFirst = true
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        
        let parser = NSXMLParser(contentsOfURL: rssURL)
        
        parser!.delegate = self
        
        parser!.parse()
        
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        delegate?.parsingWasFinished()
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
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
                if currentElement == "description" && isFirst {
                    isFirst = false
                }
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if currentElement == "title"  || currentElement == "description"
            || currentElement == "link" || currentElement == "pubDate"
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
