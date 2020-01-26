//
//  dateHelper.swift
//  TumblrLab
//
//  Created by Derek Chang on 1/25/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//
import Foundation

class dateHelper {
    
    let debug: Bool = true
    
    //example func call
    //getSimpleDate(rawDateString: "2020-01-23 18:29:06 GMT", format: "yyyy-MM-dd HH:mm:ss ZZZZ")
    //**return: "3 days ago"
    func getSimpleDate(rawDateString: String, format: String) -> String {
        
        //convert rawDateString -> DateFormater Object
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        
        if let acceptedDate = dateFormatterGet.date(from: rawDateString){
            
            if debug {
                print("seconds since input: ", Int(acceptedDate.timeIntervalSinceNow) * -1)
                
            }
            let secondsPassed = acceptedDate.timeIntervalSinceNow * -1
            if (secondsPassed < 86400){
                let hoursPassed = Int(secondsPassed / 3600)
                return (String(hoursPassed) + " hours ago")
            }
            else{
                let daysPassed = Int(secondsPassed / 24 / 3600)
                return (String(daysPassed) + " days ago")
            }
            
        } else {
            print("error decoding date. Check format string!")
        }
        return ""
    }
}
