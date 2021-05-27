//
//  QueryResultViewModel.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit
import CoreData

class QueryResultViewModel: NSObject {
    private let queryResult: QueryResult
    
    init(queryResult: QueryResult) {
        self.queryResult = queryResult
    }
    
    var queryString: String {
        return queryResult.queryString
    }
    
    var results: [MusicVideoViewModel] {
        return queryResult.musicVideoViewModels
    }
}

class QueryResulListtViewModel: NSObject {
    let persistanceService: QueryResultService
    private(set) var queryResultViewModels: [QueryResultViewModel] = []
    
    init(persistanceService: PersistenceService) {
        self.persistanceService = persistanceService
        super.init()
    }
    
    func fetch(completition: @escaping () -> ()) {
        
        persistanceService.fetchQueryResults{ [weak self] (result) in
            guard let sself = self else { return }
            
            switch result {
            case .success(let response):
                sself.queryResultViewModels = response
                completition()
            case .failure(let error):
                print(error.message)
            }
        }
    }
    
    
}
