//
//  ResultListViewController.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit
import AVKit

class ResultListViewController: UITableViewController {
    private let cellID = "Cell"
    
    var viewModel: MusicVideoListViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Search results"
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}


// MARK: UITableViewDelegate
extension ResultListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let previewURL = viewModel?.musicVideoViewModels[indexPath.row].previewUrl else {
            return
        }
        
        let player = AVPlayer(url: previewURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}

// MARK: UITableViewDataSource
extension ResultListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.musicVideoViewModels.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? MusicVideoListTableViewCell else {
            fatalError()
        }
        
        guard let currentMusicVideoViewModel = viewModel?.musicVideoViewModels[indexPath.row] else {
            return cell
        }
        
        currentMusicVideoViewModel.onPosterUpdated = { (viewModel: MusicVideoViewModel) in
            DispatchQueue.main.async {
                if indexPath == viewModel.indexPath {
                    cell.updateImage(viewModel.imageStorage)
                } else {
                    cell.updateImage(nil)
                }
            }
        }
        
        currentMusicVideoViewModel.indexPath = indexPath
        currentMusicVideoViewModel.fetchImage()
        cell.setMusicVideoInfo(viewModel: currentMusicVideoViewModel)
        
        return cell
    }
    
    
}
