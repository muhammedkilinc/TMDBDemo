//
//  ContentCollectionViewCell.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit
import Kingfisher

class ContentCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!

  override func awakeFromNib() {

  }
  
  func bind(_ viewModel: ContentCellViewModel) {
    self.titleLabel.text = viewModel.title
    self.overviewLabel.text = viewModel.overview
    self.subtitleLabel.text = viewModel.subtitle
    self.imageView.kf.setImage(with: viewModel.imageURL)
  }
  
}
