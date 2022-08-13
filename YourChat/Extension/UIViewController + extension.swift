//
//  UIViewController + extension.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import UIKit

extension UIViewController {
   
   func configure<T: SelfConfigureCell, U: Hashable>(collectionView: UICollectionView ,cellType: T.Type, with value: U, for indexPath: IndexPath) -> T? {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { return nil }
      
      cell.configure(with: value)
      return cell
   }
   
   func showAlert(with title: String, message: String, completion: @escaping () -> Void) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
         completion()
      }
      
      alertController.addAction(okAction)
      present(alertController, animated: true)
   }
}
