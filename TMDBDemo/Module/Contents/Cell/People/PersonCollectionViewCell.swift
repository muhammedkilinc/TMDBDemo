//
//  PersonCollectionViewCell.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import UIKit
import Kingfisher

class PersonCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var popularityLabel: UILabel!
  
  override func awakeFromNib() {
  }
  
  func bind(_ viewModel: PersonCellViewModel) {
    self.nameLabel.text = viewModel.name
    self.popularityLabel.text = viewModel.popularity

    self.imageView.kf.setImage(with: viewModel.imageURL)
  }
  
}
