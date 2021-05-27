//
//  MusicVideoListTableViewCell.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

class MusicVideoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    func setMusicVideoInfo(viewModel: MusicVideoViewModel) {
        trackName?.text = viewModel.title
        artistName?.text = viewModel.artistName
        artworkImageView?.image = viewModel.imageStorage
    }
    
    func updateImage(_ image: UIImage?) {
        artworkImageView?.image = image
    }
}

