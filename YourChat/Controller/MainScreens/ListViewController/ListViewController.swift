//
//  ListViewController.swift
//  YourChat
//
//  Created by Kirill Sytkov on 26.07.2022.
//

import UIKit
import FirebaseFirestore

class ListViewController: UIViewController {
   
   //MARK: - Properties
   private var activeChats = [MChat]()
   private var waitingChats = [MChat]()
   private let currentUser: MUser
   private var waitingChatsListener: ListenerRegistration?
   private var activeChatsListener: ListenerRegistration?
   
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
   
   init(currentUser: MUser) {
      self.currentUser = currentUser
      super.init(nibName: nil, bundle: nil)
      self.title = currentUser.username
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   deinit {
      waitingChatsListener?.remove()
      activeChatsListener?.remove()
   }
   
   
   //MARK: - Lyfecycles
   override func viewDidLoad() {
      super.viewDidLoad()
      setup()
      setupSearchBar()
      setupCollectionView()
      setupDataSource()
      addWaitingChatsListener()
      addActiveChatsListener()
   }
   
   
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
      collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
      collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.reuseId)
      collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
      collectionView.delegate = self
      collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      collectionView.backgroundColor = .systemBackground
      
      view.addSubview(collectionView)
   }
   
   private func addWaitingChatsListener() {
      waitingChatsListener = ListenerService.shared.waitingChatsObserve(chats: waitingChats, completion: { result in
         switch result {
         case .success(let chats):
            if self.waitingChats != [], self.waitingChats.count <= chats.count {
               let chatRequestVC = ChatRequestViewController(chat: chats.last!)
               chatRequestVC.delegate = self
               self.present(chatRequestVC, animated: true)
            }
            self.waitingChats = chats
            self.reloadData(with: nil)
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      })
   }
   
   private func addActiveChatsListener() {
      activeChatsListener = ListenerService.shared.activeChatsObserve(chats: activeChats, completion: { result in
         switch result {
         case .success(let chats):
            self.activeChats = chats
            self.reloadData(with: nil)
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      })
   }
}


//MARK: - Extensions
//MARK: - Data source layout
extension ListViewController {
   
   private func setupDataSource() {
      
      dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { collectionView, indexPath, chat in
         
         guard let section = Section(rawValue: indexPath.section) else { return  UICollectionViewCell() }
         
         switch section {
         case .activeChats:
            return self.configure(collectionView: collectionView, cellType: ActiveChatCell.self, with: chat, for: indexPath)
         case .waitingChats:
            return self.configure(collectionView: collectionView, cellType: WaitingChatCell.self, with: chat, for: indexPath)
         }
      })
      
      dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
         guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil }
         guard let section = Section(rawValue: indexPath.section) else  { return nil }
         
         sectionHeader.configure(text: section.description(), font: .laoSangamMN20(), textColor: .systemGray)
         return sectionHeader
      }
   }
   
   private func reloadData(with searchText: String?) {
      let filtered = activeChats.filter { chat in
         chat.contains(filter: searchText)
      }
      
      var snapshot  = NSDiffableDataSourceSnapshot<Section, MChat>()
      snapshot.appendSections([.waitingChats, .activeChats])
      snapshot.appendItems(waitingChats, toSection: .waitingChats)
      snapshot.appendItems(filtered, toSection: .activeChats)
      
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
      reloadData(with: searchText)
   }
}

//MARK: - UICollectiovVIew delegate
extension ListViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard let chat = self.dataSource?.itemIdentifier(for: indexPath) else { return }
      guard let section = Section(rawValue: indexPath.section) else { return }
      
      switch section {
      case .waitingChats:
         let chatRequestVC = ChatRequestViewController(chat: chat)
         chatRequestVC.delegate = self
         self.present(chatRequestVC, animated: true)
      case .activeChats:
         let chatsVC = ChatsViewController(user: currentUser, chat: chat)
         navigationController?.pushViewController(chatsVC, animated: true)
      }
   }
}

//MARK: - WaitingChatNavigationDelegate
extension ListViewController:  WaitingChatsNavigationDelegate {
   func removeWaitingChat(chat: MChat) {
      FirestoreService.shared.deleteWaitingChat(chat: chat) { result in
         switch result {
         case .success():
            self.showAlert(with: "Success", message: "Chat with \(chat.friendUsername) has been deleted")
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      }
   }
   
   func chatToActive(chat: MChat) {
      FirestoreService.shared.changeToActive(chat: chat) { result in
         switch result {
         case .success():
            debugPrint("change to active chat - success")
         case .failure(let error):
            self.showAlert(with: "Error", message: error.localizedDescription)
         }
      }
   }
}
