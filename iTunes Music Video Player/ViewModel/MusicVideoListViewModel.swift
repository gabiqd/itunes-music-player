//
//  MusicVideoListViewModel.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

class MusicVideoListViewModel: NSObject {
    let persistenceService: QueryResultService
    let networkService: MusicVideoService
    let imageService: ImageService
    private(set) var musicVideoViewModels: [MusicVideoViewModel] = []
    var onMusicVideoListUpdated: ((MusicVideoListViewModel) -> Void)? = nil
    
    init(persistenceService: PersistenceService, networkService: MusicVideoService, imageService: ImageService) {
        self.persistenceService = persistenceService
        self.networkService = networkService
        self.imageService = imageService
        super.init()
    }
    
    func fetch(with searchTerm: String, completition: @escaping () -> ()) {
        networkService.fetchMusicVideos(of: searchTerm) { [weak self] (result) in
            guard let sself = self else { return }
            
            switch result {
            case .success(let response):
                let musicVideoViewModels = response.results.map {
                    MusicVideoViewModel(musicVideo: $0, imageService: sself.imageService)}
                sself.musicVideoViewModels = musicVideoViewModels
                sself.persistenceService.saveQueryResult(searchTerm: searchTerm, musicVideosViewModel: musicVideoViewModels)
                completition()
            case .failure(let error):
                print(error.message)
            }
        }
    }
}
