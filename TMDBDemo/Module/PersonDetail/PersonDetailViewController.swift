//
//  PersonDetailViewController.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class PersonDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var knownLabel: UILabel!

  var viewModel: PersonDetailViewModel!
  private let disposeBag = DisposeBag()
  
  private let viewWillAppearRelay: PublishRelay<Void> = PublishRelay()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindViewModel()
  }
  
  private func bindViewModel() {
    assert(viewModel != nil)
    
    rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { _ in }
      .bind(to: viewWillAppearRelay)
      .disposed(by: disposeBag)
    
    let input = PersonDetailViewModel.Input(refresh: viewWillAppearRelay.asObservable())
    
    let output = viewModel.transform(input: input)
    
    output.person
      .bind(to: postBinding)
      .disposed(by: disposeBag)
    
  }
  
  var postBinding: Binder<PersonDetail> {
    return Binder(self, binding: { (vc, person) in
      vc.titleLabel.text = person.name
      vc.descriptionLabel.text = person.biography
      vc.dateLabel.text = person.birthday
      vc.knownLabel.text = person.alsoKnownAs?.joined(separator: " ,")
      vc.imageView.kf.setImage(with: person.profileImageURL)
    })
  }
  
}
