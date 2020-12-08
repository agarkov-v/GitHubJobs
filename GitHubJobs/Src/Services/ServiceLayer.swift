//
//  ServiceLayer.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation

class ServiceLayer {

    //один из вариантов DI
    public static let shared = ServiceLayer()
    public lazy var vacancyApiService: VacancyApiService = VacancyApiServiceImp()
}
