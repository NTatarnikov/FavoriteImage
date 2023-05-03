//
//  FavoritesViewController.swift
//  FavoriteImages
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import Foundation
import UIKit

final class FavoritesViewController: UIViewController {
    
    private lazy var tableView: UITableView = makeTableView()
    
    private var favoriteImages: [ImageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        
        view.backgroundColor = .white
        self.favoriteImages = FavoritesService.shared.getAll()
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesDidUpdate), name: .favoritesDidUpdate, object: nil)
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(FavoriteImageCell.self, forCellReuseIdentifier: FavoriteImageCell.identifier)
        view.addSubview(tableView)
        return tableView
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    func handleFavoritesDidUpdate(_ notification: Notification) {
        self.favoriteImages = FavoritesService.shared.getAll()
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteImageCell.identifier, for: indexPath) as! FavoriteImageCell
        let imageForIndexPath = favoriteImages[indexPath.row]
        cell.configure(with: imageForIndexPath.request, image: imageForIndexPath.image, buttonTag: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension FavoritesViewController: FavoriteImageCellDelegate {
    
    func didTapRemoveButton(atIndex index: Int) {
        FavoritesService.shared.remove(at: index)
        tableView.reloadData()
    }
    
}



