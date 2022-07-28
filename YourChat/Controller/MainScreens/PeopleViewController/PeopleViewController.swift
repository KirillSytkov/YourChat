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
   let users = Bundle.main.decode([MUser].self, from: "users.json")
   var collectionView: UICollectionView!
   var dataSource: UICollectionViewDiffableDataSource<Section,MUser>!
   
   enum Section: Int, CaseIterable {
      case users
      
      func description(usersCount: Int) -> String {
         switch self {
         case .users:
            return "\(usersCount) people nearby"
         }
      }
   }
   
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      setupSearchBar()
      setupCollectionView()
      setupDataSource()
      reloadData()
   }
   
   
   //MARK: - Actions
   
   
   
   //MARK: - Flow func
   private func setup() {
      view.backgroundColor = .systemGroupedBackground
   }
   
   private func setupSearchBar() {
      navigationController?.navigationBar.barTintColor = .systemBackground
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.delegate = self
   }
   
   private func setupCollectionView() {
      collectionView  = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
      collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
      
      collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
      
      collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      collectionView.backgroundColor = .systemBackground
      
      view.addSubview(collectionView)
      
   }
    
}


//MARK: - Extensions
//MARK: - Setup Compositional layout
extension PeopleViewController {
   private func createCompositionalLayout() -> UICollectionViewLayout {
      
      let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
         
         guard let section = Section(rawValue: sectionIndex) else { return nil}
         
         switch section {
         case .users:
            return self.createUsersSection()
         }
      }
      
      let config = UICollectionViewCompositionalLayoutConfiguration()
      config.interSectionSpacing = 20
      layout.configuration = config
      
      return layout
   }
   
   private func createUsersSection() -> NSCollectionLayoutSection{
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
      group.interItemSpacing = .fixed(15)
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 15
      
      let sectionHeader = createSectionHeader()
      section.boundarySupplementaryItems = [sectionHeader]
      section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 15, bottom: 0, trailing: 15)
      return section
   }
   
   private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
      let setionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: setionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      return sectionHeader
   }
   
}


//MARK: - Data source layout
extension PeopleViewController {
   private func configure<T: SelfConfigureCell>(cellType: T.Type, with value: MUser, for indexPath: IndexPath) -> T? {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { return nil }
      
      cell.configure(with: value)
      return cell
   }
   
   private func setupDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, MUser>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
         
         guard let section = Section(rawValue: indexPath.section) else { return  UICollectionViewCell() }
         
         switch section {
         case .users:
            return self.configure(cellType: UserCell.self, with: itemIdentifier, for: indexPath)
         }
      })
      
      dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
         guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil }
         guard let section = Section(rawValue: indexPath.section) else  { return nil }
         let items = self.dataSource.snapshot().itemIdentifiers(inSection: .users)
         
         sectionHeader.configure(text: section.description(usersCount: items.count), font: .systemFont(ofSize: 36,weight: .light), textColor: .systemGray)
         return sectionHeader
      }
   }
   
   private func reloadData() {
      var snapshot  = NSDiffableDataSourceSnapshot<Section, MUser>()
      snapshot.appendSections([.users])
      snapshot.appendItems(users, toSection: .users)
      
      dataSource?.apply(snapshot, animatingDifferences: true)
   }
}


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
