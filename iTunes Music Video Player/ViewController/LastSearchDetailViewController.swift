//
//  LastSearchDetailViewController.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

class LastSearchDetailViewController: UITableViewController {
    private let cellID = "lastSearchDetailCellID"
    
    var viewModel: QueryResultViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = viewModel?.queryString
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: UITableViewDataSource
extension LastSearchDetailViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource
extension LastSearchDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LastSearchDetailTableViewCell else {
            fatalError()
        }
        
        guard let currentMusicVideoViewModel = viewModel?.results[indexPath.row] else {
            return cell
        }
        
        cell.titleLabel.text = currentMusicVideoViewModel.title
        cell.artistLabel.text = currentMusicVideoViewModel.artistName
        
        return cell
    }
}

