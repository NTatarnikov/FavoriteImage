//
//  FavoriteImageCell.swift
//  FavoriteImages
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteImageCellDelegate: AnyObject {
    func didTapRemoveButton(atIndex index: Int)
}

class FavoriteImageCell: UITableViewCell {
    
    weak var delegate: FavoriteImageCellDelegate?
    
    static let identifier = "FavoriteImageTableViewCell"
    
    private lazy var containerView = makeContainerView()
    private lazy var favoriteImageView = makeFavoriteImageView()
    private lazy var removeButton = makeRemoveButton()
    private lazy var queryLabel = makeQueryLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            removeButton.widthAnchor.constraint(equalToConstant: 100),
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            removeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            removeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            
            favoriteImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            favoriteImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 40),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 40),
            
            queryLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 16),
            queryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    
    func configure(with query: String, image: UIImage, buttonTag: Int) {
        queryLabel.text = query
        favoriteImageView.image = image
        removeButton.tag = buttonTag
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    private func makeFavoriteImageView() -> UIImageView  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        return imageView
    }
    
    private func makeRemoveButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeButtonTapped(sender:)), for: .touchUpInside)
        containerView.addSubview(button)
        return button
    }
    
    private func makeQueryLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        containerView.addSubview(label)
        return label
    }
    
}

private extension FavoriteImageCell {
    
    @objc
    func removeButtonTapped(sender: UIButton) {
        let index = sender.tag
        delegate?.didTapRemoveButton(atIndex: index)
    }
    
}
