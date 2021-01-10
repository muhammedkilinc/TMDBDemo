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
  
  override func awakeFromNib() {

  }
  
  func bind(_ viewModel: ContentCellViewModel) {
    self.titleLabel.text = viewModel.title
  }
  
}
