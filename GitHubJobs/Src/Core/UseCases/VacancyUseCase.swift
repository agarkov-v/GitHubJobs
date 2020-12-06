//
//  VacancyUseCase.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation
import RxSwift

protocol VacancyUseCase {
    
    var source: PublishSubject<[VacancyEntity]> { get }
    var hasMorePage: Bool { get }
    func getCurrentPage() -> Int
    func loadNewData() -> Completable
    func reset()
}

class VacancyUseCaseImp: VacancyUseCase {
    
    private var currentPage = 0
    private var isLoadingInProcess = false
    private var items = [VacancyEntity]()
    
    let gateway: VacancyGateway
    var source = PublishSubject<[VacancyEntity]>()
    var isLastPage = false
    var hasMorePage: Bool {
        if self.isLoadingInProcess {
            return false
        }
        return !isLastPage
    }
    
    init (gateway: VacancyGateway) {
        self.gateway = gateway
    }
    
    func getCurrentPage() -> Int {
        return self.currentPage
    }
    
    func loadNewData() -> Completable {
        return .deferred {
            self.isLoadingInProcess = true
            
            return self.gateway.getVacancy(page: self.currentPage + 1)
                .do(onSuccess: { (result: [VacancyEntity]) in
                    self.currentPage += 1
                    if !result.isEmpty {
                        self.items.append(contentsOf: result)
                    } else {
                        self.isLastPage = true
                    }
                    self.isLoadingInProcess = false
                    self.source.onNext(self.items)
                }, onError: { error in
                    self.isLoadingInProcess = false
                    print("VacancyUseCase error: \(error) || \(error.localizedDescription)")
                })
                .asCompletable()
        }
    }
    
    func reset() {
        self.items.removeAll()
        self.currentPage = 0
        self.isLoadingInProcess = false
        self.isLastPage = false
    }  
}
