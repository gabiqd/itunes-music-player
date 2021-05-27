//
//  LastSearchCollectionViewCell.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

class LastSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
