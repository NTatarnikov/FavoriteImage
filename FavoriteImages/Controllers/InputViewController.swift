//
//  InputViewController.swift
//  FavoriteImages
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import UIKit

final class InputViewController: UIViewController {
    
    private lazy var containerView = makeContainerView()
    private lazy var inputTextField  = makeInputTextField()
    private lazy var generateButton = makeGenerateButton()
    private lazy var imageView = makeImageView()
    private lazy var addToFavoritesButton = makeAddToFavoritesButton()
    private lazy var activityIndicator = makeActivityIndicator()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        
        view.backgroundColor = .white
    }
    
    private func makeContainerView() -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        return containerView
    }

    private func makeInputTextField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "InputTextField"
        containerView.addSubview(textField)
        return textField
    }

    private func makeGenerateButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Generate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
        button.accessibilityIdentifier = "GenerateButton"
        containerView.addSubview(button)
        return button
    }

    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "ImageView"
        containerView.addSubview(imageView)
        return imageView
    }

    private func makeAddToFavoritesButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Add to Favorites", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToFavoritesButtonTapped), for: .touchUpInside)
        containerView.addSubview(button)
        return button
    }
    
    private func makeActivityIndicator() -> UIActivityIndicatorView  {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        return activityIndicator
    }
    

    // Компактее и красивее выглядело бы, если можно было бы использовать SnapKit/PinKit
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            inputTextField.topAnchor.constraint(equalTo: containerView.topAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            generateButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 10),
            generateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            imageView.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            addToFavoritesButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            addToFavoritesButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            addToFavoritesButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

private extension InputViewController {
    
    @objc
    func generateButtonTapped() {
        guard let text = inputTextField.text, !text.isEmpty else { return }
        activityIndicator.startAnimating()
        ImageService.shared.fetchImage(text: text) { [weak self] image in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.imageView.image = image
            }
        }
    }
    
    @objc
    func addToFavoritesButtonTapped() {
        guard let image = imageView.image else { return }
        let imageModel = ImageModel(request: inputTextField.text ?? "", image: image)
        FavoritesService.shared.add(imageModel)
    }
    
}

