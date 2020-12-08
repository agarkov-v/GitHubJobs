//
//  VacancyForDayModel.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 04.12.2020.
//

import Foundation

struct VacancyForDayModel: Codable {
    
    var date: Date
    var vacancyes: [VacancyModel]
}
