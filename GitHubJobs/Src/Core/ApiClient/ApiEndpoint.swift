//
//  ApiEndpoint.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation
import RxNetworkApiClient

extension ApiEndpoint {
    
    static let base = ApiEndpoint("https://jobs.github.com/positions.json")
    
    //    https://jobs.github.com/positions.json?utf8=%E2%9C%93&description=&location=
    //    "https://jobs.github.com/positions.json"
    //    https://jobs.github.com/positions/2315d8ae-9e9b-4b73-a98e-8c383cdf532e.json
    //    https://jobs.github.com/positions.json?page=1&search=code //по 50 с 0
    //    https://jobs.github.com/positions.json?page=3
    //
    //    markdown - Установите значение «true», чтобы получить поля description и how_to_apply как Markdown.
    //    https://jobs.github.com/positions/21516.json
    //    https://jobs.github.com/positions/21516.json?markdown=true
}
