//
//  Reusable.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit

protocol Reusable {
  static var reuseID: String {get}
}

extension Reusable {
  static var reuseID: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}

extension UICollectionViewCell: Reusable {}

extension UIViewController: Reusable {}

extension UITableView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UITableViewCell {
    register(UINib(nibName: T.reuseID, bundle: Bundle.main), forCellReuseIdentifier: T.reuseID)
  }
}

extension UICollectionView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UICollectionViewCell {
    register(UINib(nibName: T.reuseID, bundle: Bundle.main), forCellWithReuseIdentifier: T.reuseID)
  }
}

extension UIStoryboard {
  func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
    guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
      fatalError()
    }
    return viewController
  }
}

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: T.reuseID, bundle: nil)
    }
    
    return instantiateFromNib()
  }
}
