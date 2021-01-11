//
//  CastCollectionViewCell.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var characterLabel: UILabel!
  
  override func awakeFromNib() {
    imageView.backgroundColor = UIColor.systemGray
  }
  
  override func layoutSubviews() {
    imageView.layer.cornerRadius = imageView.layer.frame.size.width / 2.0
  }
  
  func bind(_ viewModel: CastCellViewModel) {
    self.nameLabel.text = viewModel.name
    self.characterLabel.text = viewModel.character
    
    self.imageView.kf.setImage(with: viewModel.imageURL)
  }
  
}
