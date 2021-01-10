//
//  ContentsViewController.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ContentsViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  var viewModel: ContentsViewModel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var infoLabel: UILabel!

  private var refreshControl: UIRefreshControl = UIRefreshControl()
  private let cellRatio: CGFloat = 2 / 5
  
  private let queryRelay: PublishRelay<String> = PublishRelay()
  private let pullToRefreshRelay: PublishRelay<Void> = PublishRelay()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  func setupUI() {
    title = Constants.Screen.ContentsTitle

    infoLabel.text = Constants.Messages.SearchMulti
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
    collectionView.register(type: PersonCollectionViewCell.self)
    collectionView.registerSupplementaryViewFromNib(ContentHeaderReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)

    let w = (view.bounds.width - (2 * Constants.Screen.CellSpacing))
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = Constants.Screen.CellSpacing
    layout.minimumInteritemSpacing = Constants.Screen.CellSpacing
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: w, height: w * cellRatio)
    layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.Screen.CellSpacing, bottom: 0, right: Constants.Screen.CellSpacing)
    layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 48)

    collectionView.collectionViewLayout = layout
    
    
    refreshControl.tintColor = .blue
//    collectionView.refreshControl = refreshControl
    collectionView.addSubview(refreshControl)

    collectionView.backgroundColor = .white    
  }
  
  private func bindViewModel() {
    assert(viewModel != nil)
    
    searchBar.rx
      .text
      .orEmpty
      .bind(to: queryRelay)
      .disposed(by: disposeBag)
    
    refreshControl.rx
      .controlEvent(.valueChanged)
      .bind(to: pullToRefreshRelay)
      .disposed(by: disposeBag)
    
//    let selection = collectionView.rx.itemSelected.asObservable()
    let selection = collectionView.rx.modelSelected(Content.self)
    
    let input = ContentsViewModel.Input(query: queryRelay.asObservable(), pullToRefresh: pullToRefreshRelay.asObservable(), selection: selection.asObservable())
    
    let output = viewModel.transform(input: input)
    
    //Bind Contents to UICollectionView
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<ContentSection>(
      configureCell: { dataSource, collectionView, indexPath, item in
        if item.mediaType == .person {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.reuseID, for: indexPath) as! PersonCollectionViewCell
          cell.bind(PersonCellViewModel(with: item))
          return cell
        } else {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reuseID, for: indexPath) as! ContentCollectionViewCell
          cell.bind(ContentCellViewModel(with: item))
          return cell
        }
      })


    
    dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
      let header: ContentHeaderReusableView = collectionView.dequeueSupplementaryView(ofKind: kind, for: indexPath)
      header.titleLabel.text = dataSource[indexPath.section].header
      return header
    }
    
    
    output.contents.map {
      itemViewModels -> [ContentSection] in
      let movieSection = ContentSection(header: "Movies", items: itemViewModels.filter({ item -> Bool in
        return item.mediaType == .movie
      }))
      let peopleSection = ContentSection(header: "People", items: itemViewModels.filter({ item -> Bool in
        return item.mediaType == .person
      }))
      let tvSection = ContentSection(header: "TV", items: itemViewModels.filter({ item -> Bool in
        return item.mediaType == .tv
      }))
      var items: [ContentSection] = []
      if !movieSection.items.isEmpty {
        items.append(movieSection)
      }
      if !peopleSection.items.isEmpty {
        items.append(peopleSection)
      }
      if !tvSection.items.isEmpty {
        items.append(tvSection)
      }
      return items
    }.bind(to: collectionView.rx.items(dataSource: dataSource))
    .disposed(by: disposeBag)
    
    
//    output.contents.bind(to: collectionView.rx.items(cellIdentifier: ContentCollectionViewCell.reuseID, cellType: ContentCollectionViewCell.self)) { row, viewModel, cell in
//      cell.bind(viewModel)
//    }.disposed(by: disposeBag)
    
    output.loading
      .bind(to: refreshControl.rx.isRefreshing)
      .disposed(by: disposeBag)
    
    output.info.subscribe(onNext: { info in
      self.infoLabel.isHidden = (info == nil)
      self.infoLabel.text = info
    })
    .disposed(by: disposeBag)
    
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

struct ContentSection {
  var header: String
  var items: [Content]
}

extension ContentSection: SectionModelType {
  typealias Item = Content

  init(original: ContentSection, items: [Item]) {
    self = original
    self.items = items
  }
}
