//
//  PaginationEntity.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation

struct PaginationEntity<T: Codable>: Codable {
    
    let countOfPages: Int
    let data: [T]
}
