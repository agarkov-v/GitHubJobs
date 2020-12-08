//
//  VacancyModel.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation

struct VacancyModel: Codable {
    
    var id: String
    var createdAt: String
    var company: String
    var title: String
    var description: String
    var howToApply: String
}
