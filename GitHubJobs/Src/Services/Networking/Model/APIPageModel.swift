//
//  APIPageModel.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation

struct APIPageModel {

    let page: Int

    init(page: Int = 0) {
        self.page = page
    }
}
