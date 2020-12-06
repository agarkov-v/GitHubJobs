//
//  DateFormatterUtil.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation

class DateFormatUtil {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM. yyyy, HH:mm"
        return formatter
    }()
     
    private static let hardDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    private static let customFormatter: DateFormatter = DateFormatter()
    
    static func customDateFormat(time: TimeInterval, format: String) -> String {
        customFormatter.dateFormat = format
        return customFormatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    static func customDateFormat(dateString: String, format: String) -> String? {
        if let date = hardDateFormatter.date(from: dateString) {
            return customDateFormat(time: date.timeIntervalSince1970, format: format)
        } else { return nil }
    }
    
    static func simpleDateFormat(time: TimeInterval) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    static func simpleDateFormat(dateString: String) -> String? {
        if let date = hardDateFormatter.date(from: dateString) {
            return simpleDateFormat(time: date.timeIntervalSince1970)
        } else { return nil }
    }
    
    static func convertDateFormatToString(dateString: String, fromFormat: String, toFotmat: String) -> String? {
        let fromDateFormat = DateFormatter()
        fromDateFormat.dateFormat = fromFormat
        fromDateFormat.timeZone = TimeZone(abbreviation: "UTC")

        let toDateFormat = DateFormatter()
        toDateFormat.dateFormat = toFotmat
        toDateFormat.timeZone = TimeZone(abbreviation: "UTC")

        if let date = fromDateFormat.date(from: dateString) {
//            debugPrint("convertDateFormat success: \(toDateFormat.string(from: date))")
            return toDateFormat.string(from: date)
        } else {
            debugPrint("convertDateFormat: there was an error decoding the string")
            return nil
        }
    }
    
    static func convertDateFormatToDate(dateString: String, fromFormat: String, toFotmat: String) -> Date? {
        let fromDateFormat = DateFormatter()
        fromDateFormat.dateFormat = fromFormat
        fromDateFormat.timeZone = TimeZone(abbreviation: "UTC")

        let toDateFormat = DateFormatter()
        toDateFormat.dateFormat = toFotmat
        toDateFormat.timeZone = TimeZone(abbreviation: "UTC")

        if let date = fromDateFormat.date(from: dateString) {
//            debugPrint("convertDateFormat success: \(toDateFormat.string(from: date))")
            let formattedString = toDateFormat.string(from: date)
            return toDateFormat.date(from: formattedString)
        } else {
            debugPrint("convertDateFormat: there was an error decoding the string")
            return nil
        }
    }
    
    static func convertToDate(dateString: String, format: String) -> Date {
        customFormatter.dateFormat = format
//        customFormatter.timeZone = TimeZone.current
        customFormatter.dateStyle = .short
        guard let date = (customFormatter.date(from: dateString)) else { return Date() }
        return date
    }
    
    static func convertDateToString(date: Date, format: String) -> String {
        customFormatter.dateFormat = format
        let dateString = customFormatter.string(from: date)
        return dateString
    }
}

