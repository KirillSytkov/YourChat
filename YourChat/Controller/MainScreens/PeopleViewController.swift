//
//  PeopleViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit

class PeopleViewController: UIViewController {
   //MARK: - Properties
   private let searchController = UISearchController(searchResultsController: nil)
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemGroupedBackground
      
      setupSearchBar()
   }
   
   //MARK: - Actions
   
   
   
   //MARK: - Flow func
   private func setupSearchBar() {
      navigationController?.navigationBar.barTintColor = .systemBackground
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.delegate = self
   }
}


//MARK: - Extensions
//MARK: - SearchBar delegate
extension PeopleViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      print(searchText)
   }
}


//MARK: - SwiftUI Preview
import SwiftUI

struct PeopleViewControllerProvider: PreviewProvider {
   
   static var previews: some View {
      ContainerView()
         .edgesIgnoringSafeArea(.all)
   }
   
   struct ContainerView: UIViewControllerRepresentable {
      let viewController = MainTabBarController()
      
      func makeUIViewController(context: Context) -> some MainTabBarController {
         return viewController
      }
      
      func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
      }
   }
}
