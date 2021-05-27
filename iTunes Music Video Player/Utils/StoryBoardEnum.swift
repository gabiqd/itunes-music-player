//
//  StoryBoardEnum.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 27/05/2021.
//

import Foundation

enum StoryBoardEnum {
    case parentStoryboard
    case search
    case resultList
    case lastSearchesResultList
    case lastSearchesResultDetail
    
    var identifier: String {
        switch self {
        case .parentStoryboard:
            return "Main"
        case .search:
            return "searchViewControllerID"
        case .resultList:
            return "resultListViewControllerID"
        case .lastSearchesResultList:
            return "lastSearchesListViewControllerID"
        case .lastSearchesResultDetail:
            return "lastSearchesResultDetailControllerID"
        }
    }
}
