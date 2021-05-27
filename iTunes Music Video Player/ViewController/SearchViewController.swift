//
//  SearchViewController.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 23/05/2021.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    private let loadingViewController = LoadingViewController()
    
    let viewModel: MusicVideoListViewModel = {
        let service = NetworkService()
        let persistenceService = PersistenceService()
        let viewModel = MusicVideoListViewModel(persistenceService: persistenceService, networkService: service, imageService: service)
        
        return viewModel
    }()
    
    let persistenceViewModel: QueryResulListtViewModel = {
        let service = PersistenceService()
        let viewModel = QueryResulListtViewModel(persistanceService: service)
        
        return viewModel
    }()
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let searchString = searchTextField.text else {
            return
        }
        
        add(loadingViewController)
        
        viewModel.fetch(with: searchString) { [weak self] in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                guard let sself = self else { return }
                sself.navigateToSearchResult(with: sself.viewModel)
            }
        }
    }
    
    @IBAction func lastSearchsButtonTapped(_ sender: Any) {
        add(loadingViewController)
        
        persistenceViewModel.fetch { [weak self] in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                guard let sself = self else { return }
                sself.navigateToLastSearchesResult(with: sself.persistenceViewModel)
            }
        }
    }
    
    func navigateToSearchResult(with viewModel: MusicVideoListViewModel) {
        let storyboard = UIStoryboard(name: StoryBoardEnum.parentStoryboard.identifier, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: StoryBoardEnum.resultList.identifier) as? ResultListViewController else { return }
        
        viewController.viewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToLastSearchesResult(with viewModel: QueryResulListtViewModel) {
        let storyboard = UIStoryboard(name: StoryBoardEnum.parentStoryboard.identifier, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: StoryBoardEnum.lastSearchesResultList.identifier) as? LastSearchesViewController else { return }
        
        viewController.queryResulListViewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
