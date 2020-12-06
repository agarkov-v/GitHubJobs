//
//  DateFormatterUtil.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation

protocol DateFormatterUtil {
    
    func convertDateFormatToString(dateString: String, fromFormat: String, toFotmat: String) -> String
    func convertDateFormatToDate(dateString: String, fromFormat: String, toFotmat: String) -> Date
    func convertDateToString(date: Date, format: String) -> String
}

class DateFormatUtilImp: DateFormatterUtil {
    
    private let customFormatter: DateFormatter = DateFormatter()
    
    func convertDateFormatToString(dateString: String, fromFormat: String, toFotmat: String) -> String {
        let dateWithoutUTC = dateString.replacingOccurrences(of: " UTC", with: "")
        let fromDateFormat = DateFormatter()
        fromDateFormat.dateFormat = fromFormat
        fromDateFormat.timeZone = TimeZone(abbreviation: "UTC")
        
        let toDateFormat = DateFormatter()
        toDateFormat.dateFormat = toFotmat
        toDateFormat.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = fromDateFormat.date(from: dateWithoutUTC) {
            return toDateFormat.string(from: date)
        } else {
            debugPrint("convertDateFormat: there was an error decoding the string")
            return ""
        }
    }
    
    func convertDateFormatToDate(dateString: String, fromFormat: String, toFotmat: String) -> Date {
        let dateWithoutUTC = dateString.replacingOccurrences(of: " UTC", with: "")
        let fromDateFormat = DateFormatter()
        fromDateFormat.dateFormat = fromFormat
        fromDateFormat.timeZone = TimeZone(abbreviation: "UTC")
        
        let toDateFormat = DateFormatter()
        toDateFormat.dateFormat = toFotmat
        toDateFormat.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = fromDateFormat.date(from: dateWithoutUTC) {
            let formattedString = toDateFormat.string(from: date)
            return toDateFormat.date(from: formattedString)!
        } else {
            debugPrint("convertDateFormat: there was an error decoding the string")
            return Date()
        }
    }
    
    func convertDateToString(date: Date, format: String) -> String {
        customFormatter.dateFormat = format
        let dateString = customFormatter.string(from: date)
        return dateString
    }
}

