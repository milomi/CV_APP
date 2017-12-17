//
//  DateFormaterHelper.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.12.2017.
//

import Foundation

class DateFormatterHelper {
    
    fileprivate static let oneDay: TimeInterval = 24*60*60
    fileprivate static let dateFormatter = DateFormatter()
    
    class func getFormatedDateString(_ date: Date) -> String {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: date)
    }
    
    class func getDateFormString(dateString: String?) -> Date? {
        
        guard let dateString = dateString else {
            return nil
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: dateString)
    }
    
}
