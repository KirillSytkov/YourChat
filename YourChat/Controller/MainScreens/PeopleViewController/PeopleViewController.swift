//
//  PeopleViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PeopleViewController: UIViewController {
   //MARK: - Properties
   private let searchController = UISearchController(searchResultsController: nil)
   private var users = [MUser]()
   private var usersListner: ListenerRegistration?
   private let currentUser: MUser
   private var collectionView: UICollectionView!
   private var dataSource: UICollectionViewDiffableDataSource<Section,MUser>!
   
   enum Section: Int, CaseIterable {
      case users
      
      func description(usersCount: Int) -> String {
         switch self {
         case .users:
            return "\(usersCount) people nearby"
         }
      }
   }
   
   init(currentUser: MUser) {
      self.currentUser = currentUser
      super.init(nibName: nil, bundle: nil)
      self.title = currentUser.username
   }
   
   deinit {
      usersListner?.remove()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      setupSearchBar()
      setupCollectionView()
      setupDataSource()
      addUsersListener()
   }
   
   
   //MARK: - Actions
   @objc func logoutButtonTapper(_ sender: UIButton) {
      let ac = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      ac.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { _ in
         do {
            try Auth.auth().signOut()
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            window?.rootViewController = AuthViewController()
            
         } catch {
            debugPrint(error.localizedDescription)
         }
            
      }))
      present(ac, animated: true, completion: nil)
   }
   
   
   
   //MARK: - Flow func
   private func setup() {
      view.backgroundColor = .systemGroupedBackground
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapper(_:)))
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
      collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
      collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
      collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
      
      collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      collectionView.backgroundColor = .systemBackground
      
      collectionView.delegate = self
      
      view.addSubview(collectionView)
      
   }
    
   private func addUsersListener() {
      usersListner = ListenerService.shared.usersObserve(users: users, completion: { result in
         switch result {
         case .success(let users):
            self.users = users
            self.reloadData(with: nil)
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription) {
               
            }
         }
      })
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
   
   private func reloadData(with searchText: String?) {
      let filtered = users.filter { user in
         user.contains(filter: searchText)
      }

      var snapshot  = NSDiffableDataSourceSnapshot<Section, MUser>()
      snapshot.appendSections([.users])
      snapshot.appendItems(filtered, toSection: .users)

      dataSource?.apply(snapshot, animatingDifferences: true)
   }
}


//MARK: - SearchBar delegate
extension PeopleViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      reloadData(with: searchText)
   }
}

//MARK: - CollectionViewDelegate
extension PeopleViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard let user = self.dataSource.itemIdentifier(for: indexPath) else { return }
      let profileVC = ProfileViewController(user: user)
      self.present(profileVC, animated: true)
   }
}
