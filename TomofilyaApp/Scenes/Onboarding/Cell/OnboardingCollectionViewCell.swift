//
//  OnboardingCollectionViewCell.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.08.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var slidesImageView: UIImageView!
 
    // MARK: - SetCell
    
    func setCell(image: UIImage) {
        slidesImageView.image = image
    }
}
