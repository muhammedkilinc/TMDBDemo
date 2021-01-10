//
//  ContentsViewController.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ContentsViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  var viewModel: ContentsViewModel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  private let cellRatio: CGFloat = 1 / 3
  private var refreshControl: UIRefreshControl = UIRefreshControl()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = Constants.Screen.ContentsTitle
    
    configureCollectionView()
    configureSearchBar()
    configureSegmentedControl()
    bindViewModel()
  }
  
  private func configureSegmentedControl() {
    
  }
  
  private func configureSearchBar() {
    searchBar.placeholder = Constants.Screen.SearchPlaceholder
    searchBar.returnKeyType = .search
  }
  
  private func configureCollectionView() {
    collectionView.register(type: ContentCollectionViewCell.self)
    
    let w = (view.bounds.width - (3 * Constants.Screen.CellSpacing)) / 2
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = Constants.Screen.CellSpacing
    layout.minimumInteritemSpacing = Constants.Screen.CellSpacing
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: w, height: w * cellRatio)
    layout.sectionInset = UIEdgeInsets(top: 64, left: Constants.Screen.CellSpacing, bottom: 20, right: Constants.Screen.CellSpacing)
    
    collectionView.collectionViewLayout = layout
    
    
    refreshControl.tintColor = .blue
    collectionView.refreshControl = refreshControl
    
    collectionView.backgroundColor = .white
    
  }
  
  private func bindViewModel() {
    assert(viewModel != nil)
    
    let pull = collectionView.refreshControl!.rx
      .controlEvent(.valueChanged)
      .asDriver()
    
    let query = searchBar.rx
      .text
      .orEmpty
      .asDriver()

    
    let input = ContentsViewModel.Input(query: query)
    
    let output = viewModel.transform(input: input)
    //Bind Contents to UICollectionView
    
//    output.contents.bind(to: collectionView.rx.items(cellIdentifier: ContentCollectionViewCell.reuseID, cellType: ContentCollectionViewCell.self)) { row, viewModel, cell in
//      cell.bind(viewModel)
//    }.disposed(by: disposeBag)
//
//
//    output.fetching
//      .drive(collectionView.refreshControl!.rx.isRefreshing)
//      .disposed(by: disposeBag)
//
//    output.selectedContent
//      .drive()
//      .disposed(by: disposeBag)
//
//    output.error
//      .asObservable()
//      .subscribe({ error in
//        //TODO: AlertView
//        print(error.error?.localizedDescription)
//      })
//      .disposed(by: disposeBag)
    
    searchBar
      .rx
      .searchButtonClicked
      .subscribe { _ in
        if self.searchBar.isFirstResponder {
          self.searchBar.resignFirstResponder()
        }
      }.disposed(by: disposeBag)
  }
}

