//
//  MovieDetailViewController.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class MovieDetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var castCollectionView: UICollectionView!

  var viewModel: MovieDetailViewModel!
  private let disposeBag = DisposeBag()
  
  private let viewWillAppearRelay: PublishRelay<Void> = PublishRelay()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    bindViewModel()
  }
  
  fileprivate func setupCollectionView() {
    castCollectionView.register(type: CastCollectionViewCell.self)
    castCollectionView.showsHorizontalScrollIndicator = false
    
    let w = Constants.Screen.CastCollectionCellWidth
    let h = Constants.Screen.CastCollectionCellHeight

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: w, height: h)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)    
    castCollectionView.collectionViewLayout = layout
  }
  
  private func bindViewModel() {
    assert(viewModel != nil)
    

    rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { _ in }
      .bind(to: viewWillAppearRelay)
      .disposed(by: disposeBag)
    
    let input = MovieDetailViewModel.Input(refresh: viewWillAppearRelay.asObservable())
    
    let output = viewModel.transform(input: input)

    output.movie
      .bind(to: postBinding)
      .disposed(by: disposeBag)

    output.casts.bind(to: castCollectionView.rx.items(cellIdentifier: CastCollectionViewCell.reuseID, cellType: CastCollectionViewCell.self)) { row, viewModel, cell in
      cell.bind(viewModel)
    }.disposed(by: disposeBag)
    
    
  }
  
  var postBinding: Binder<MovieDetail> {
    return Binder(self, binding: { (vc, movie) in
      vc.titleLabel.text = movie.title
      vc.descriptionLabel.text = movie.overview
      vc.dateLabel.text = movie.releaseDate
      vc.imageView.kf.setImage(with: movie.posterImageURL)
    })
  }
  
}
