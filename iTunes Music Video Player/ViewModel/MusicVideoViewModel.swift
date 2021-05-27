//
//  MusicVideoViewModel.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

class MusicVideoViewModel {
    private let musicVideo: MusicVideo
    private let imageService: ImageService?
    
    var imageStorage: UIImage? = nil
    
    var onPosterUpdated: ((MusicVideoViewModel) -> Void)? = nil
    var indexPath: IndexPath?
    
    init(musicVideo: MusicVideo, imageService: ImageService? = nil) {
        self.musicVideo = musicVideo
        self.imageService = imageService
    }
    
    var title: String {
        return musicVideo.trackCensoredName
    }
    
    var artistName: String {
        return musicVideo.artistName
    }
    
    private var thumbnailURL: URL? {
        return musicVideo.artworkUrl100
    }
    
    var previewUrl: URL? {
        return musicVideo.previewUrl
    }
    
    func fetchImage() {
        guard let url = thumbnailURL else { return }
        imageService?.fetchImage(imageURL: url) { [weak self] (result) in
            guard let sself = self else { return }
            switch result {
            case .success(let image):
                sself.imageStorage = image
            case .failure(let error):
                print(error.message)
            }
            
            sself.onPosterUpdated?(sself)
        }
    }
}

