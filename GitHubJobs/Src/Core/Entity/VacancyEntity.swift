//
//  VacancyEntity.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation

struct VacancyEntity: Codable {
    var id: String
    var createdAt: String
    var company: String
    //    var companyUrl: String
    var title: String
    var description: String
    var howToApply: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case company = "company"
        //            case companyUrl = "company_url"
        case title = "title"
        case description = "description"
        case howToApply = "how_to_apply"
    }
}
