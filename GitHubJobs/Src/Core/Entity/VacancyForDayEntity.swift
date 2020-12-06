//
//  VacancyForDayEntity.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 04.12.2020.
//

import Foundation

struct VacancyForDayEntity: Codable {
    
    var date: Date
    var vacancyes: [VacancyEntity]
}
