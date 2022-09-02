//
//  StringTrimExtension.swift
//  ActiveLabel
//
//  Created by Pol Quintana on 04/09/16.
//  Copyright © 2016 Optonaut. All rights reserved.
//

import Foundation

extension String {
    
    func trim(to maximumCharacters: Int) -> String {
        return "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }
    
    func extractLinkMarkdown(url: String) -> (String, String)? {
        
        // use named captured group for clarity
        let pattern = #"(?<markdown>\[ ?\#(url) ?\]\((?<link>[^\)]+)\))"#
        
        guard let match = RegexParser.getElements(from: self,
                                                  with: pattern,
                                                  range: NSRange(location: 0, length: self.count)).first else {
            return nil
        }
                
        var mardown: String?
        var link: String?
        
        var matchRange = match.range(withName: "link")
        if let substringRange = Range(matchRange, in: self) {
            link = String(self[substringRange])
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        matchRange = match.range(withName: "markdown")
        if let substringRange = Range(matchRange, in: self) {
            mardown = String(self[substringRange])
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        if let mardown = mardown, let link = link {
            return (mardown, link)
        }
        return nil
    }
}
