//
//  VacancyInteractor.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation
import RxSwift

enum VacancyState {
    case empty
    case loadingData
    case loadedSomeData
    case error
}

protocol VacancyInteractor {

    var vacansyItems: PublishSubject<[VacancyModel]> { get }
    var didChangeState: PublishSubject<VacancyState> { get }
    var error: Error? { get set }
    var hasMorePage: Bool { get }
    func loadPage()
    func reset()
}

class VacancyInteractorImp: VacancyInteractor {

    // MARK: - Private Properties
    private var currentPage = 0
    private var loadedVacancy = [VacancyModel]()
    private let queue = DispatchQueue(label: "VacancyInteractorQueue")
    private let apiService: VacancyApiService
    private var state: VacancyState = .empty {
        didSet {
            didChangeState.onNext(state)
        }
    }

    // MARK: - Public Properties
    var vacansyItems = PublishSubject<[VacancyModel]>()
    let didChangeState = PublishSubject<VacancyState>()
    var error: Error?
    var isLastPage = false
    var hasMorePage: Bool {
        if self.state == .loadingData {
            return false
        }
        return !isLastPage
    }

    // пример использования ServiceLayer
//    init(apiService: VacancyApiService = ServiceLayer.shared.vacancyApiService) {
//        self.apiService = apiService
//    }

    init(apiService: VacancyApiService = DI.resolve()) {
        self.apiService = apiService
    }

    // MARK: - Private Methods
    private func handleResult(_ result: Result<[VacancyModel], Error>) {
        switch result {
        case .success (let vacancy):
            self.error = nil
            if !vacancy.isEmpty {
                self.loadedVacancy.append(contentsOf: vacancy)
                self.vacansyItems.onNext(loadedVacancy)
            } else {
                self.isLastPage = true
            }
            self.state = .loadedSomeData
        case .failure (let error):
            debugPrint("handleResult error: \(error) || \(error.localizedDescription)")
            self.state = .error
            self.error = error
        }
    }

    // MARK: - Public Methods
    func loadPage() {
        queue.async { [weak self] in
            guard let self = self else { return }
            guard self.state == VacancyState.empty || self.state == VacancyState.loadedSomeData else { return }

            let semaphore = DispatchSemaphore(value: 0)

            self.state = .loadingData
            let page = APIPageModel(page: self.currentPage + 1)
            self.currentPage += 1

            self.apiService.getVacancy(page: page, completion: { [weak self] result in
                guard let self = self else { return }
                self.handleResult(result)
                semaphore.signal()
            })
            semaphore.wait()
        }
    }

    func reset() {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.loadedVacancy.removeAll()
            self.currentPage = 0
            self.isLastPage = false
            self.state = .empty
//            self.error = nil
        }
    }
}

