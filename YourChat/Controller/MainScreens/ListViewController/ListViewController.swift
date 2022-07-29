//
//  ListViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit

class ListViewController: UIViewController {
   //MARK: - Properties
   
   let activeChats = Bundle.main.decode([MChat].self, from: "activeChats.json")
   let waitingChats = Bundle.main.decode([MChat].self, from: "waitingChats.json")
   
   enum Section: Int, CaseIterable {
      case waitingChats
      case activeChats
      
      func  description() -> String {
         switch self {
            
         case .waitingChats:
            return "Waiting chats"
         case .activeChats:
            return "Active chats"
         }
      }
   }
   
   private var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
   private var collectionView: UICollectionView!
   
   private let searchController = UISearchController(searchResultsController: nil)
   
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemGroupedBackground
      
      setupSearchBar()
      setupCollectionView()
      setupDataSource()
      reloadData()
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
   
   private func setupCollectionView() {
      collectionView  = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
      collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
      
      collectionView.register(WaitingVhatCell.self, forCellWithReuseIdentifier: WaitingVhatCell.reuseId)
      collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
      
      collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      collectionView.backgroundColor = .systemBackground
      
      view.addSubview(collectionView)
      
   }
   
}

//MARK: - Data source layout
extension ListViewController {
   
   private func setupDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
         
         guard let section = Section(rawValue: indexPath.section) else { return  UICollectionViewCell() }
         
         switch section {
         case .activeChats:
            return self.configure(collectionView: collectionView, cellType: ActiveChatCell.self, with: itemIdentifier, for: indexPath)
         case .waitingChats:
            return self.configure(collectionView: collectionView, cellType: WaitingVhatCell.self, with: itemIdentifier, for: indexPath)
         }
      })
      
      dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
         guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil }
         guard let section = Section(rawValue: indexPath.section) else  { return nil }
         
         sectionHeader.configure(text: section.description(), font: .laoSangamMN20(), textColor: .systemGray)
         return sectionHeader
      }
   }
   
   private func reloadData() {
      var snapshot  = NSDiffableDataSourceSnapshot<Section, MChat>()
      snapshot.appendSections([.waitingChats, .activeChats])
      snapshot.appendItems(waitingChats, toSection: .waitingChats)
      snapshot.appendItems(activeChats, toSection: .activeChats)
      
      dataSource?.apply(snapshot, animatingDifferences: true)
   }
}

//MARK: - Setup Compositional layout
extension ListViewController {
   private func createCompositionalLayout() -> UICollectionViewLayout {
      
      let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
         
         guard let section = Section(rawValue: sectionIndex) else { return nil}
         
         switch section {
         case .activeChats:
            return self.createActiveChats()
         case .waitingChats:
            return self.createWaitingChats()
         }
      }
      
      let config = UICollectionViewCompositionalLayoutConfiguration()
      config.interSectionSpacing = 20
      layout.configuration = config
      
      return layout
   }
   
   private func createActiveChats() -> NSCollectionLayoutSection{
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 8
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
      
      let sectionHeader = createSectionHeader()
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
   }
   
   private func createWaitingChats() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.interGroupSpacing = 20
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
      
      let sectionHeader = createSectionHeader()
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
   }
   
   private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
      let setionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: setionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      return sectionHeader
   }
   
}


//MARK: - SearchBar delegate
extension ListViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
   }
}


//MARK: - SwiftUI Preview
import SwiftUI

struct ListViewControllerProvider: PreviewProvider {
   
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
