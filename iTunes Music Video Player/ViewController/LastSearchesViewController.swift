//
//  LastSearchesViewController.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

class LastSearchesViewController: UICollectionViewController {
    private let cellID = "lastSearchCellID"
    var queryResulListViewModel: QueryResulListtViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Last searches"
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func navigateToDetailLastSearchResult(with viewModel: QueryResultViewModel) {
        let storyboard = UIStoryboard(name: StoryBoardEnum.parentStoryboard.identifier, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: StoryBoardEnum.lastSearchesResultDetail.identifier) as? LastSearchDetailViewController else { return }
        
        viewController.viewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: UICollectionViewDelegate
extension LastSearchesViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let currentViewModel = queryResulListViewModel?.queryResultViewModels[indexPath.row] else { return }
        self.navigateToDetailLastSearchResult(with: currentViewModel)
    }
}

// MARK: UICollectionViewDataSource
extension LastSearchesViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queryResulListViewModel?.queryResultViewModels.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? LastSearchCollectionViewCell, let currentViewmodel = queryResulListViewModel?.queryResultViewModels[indexPath.row] else { fatalError() }
        
        cell.setTitle(currentViewmodel.queryString)
        
        return cell
    }
}
