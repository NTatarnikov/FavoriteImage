//
//  FavoritesService.swift
//  FavoriteImages
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import Foundation

// Расширение класса Notification.Name для создания уведомления о обновлении списка избранных
extension Notification.Name {
    static let favoritesDidUpdate = Notification.Name("favoritesDidUpdate")
}

class FavoritesService {
    static let shared = FavoritesService()
    
    private var favorites: [ImageModel] = []
    
    // Метод для добавления изображения в список избранных
    func add(_ imageModel: ImageModel) {
        // Если список избранных уже содержит 20 изображений, удаляем первое изображение
        if favorites.count >= 20 { // Limit favorites to 20 images
            favorites.removeFirst()
        }
        // Добавляем новое изображение в список
        favorites.append(imageModel)
        // Оповещаем об изменении списка избранных
        NotificationCenter.default.post(name: .favoritesDidUpdate, object: nil)
    }
    
    // Метод для удаления изображения из списка избранных по индексу
    func remove(at index: Int) {
        favorites.remove(at: index)
        // Оповещаем об изменении списка избранных
        NotificationCenter.default.post(name: .favoritesDidUpdate, object: nil)
    }
    
    // Метод для получения списка избранных изображений
    func getAll() -> [ImageModel] {
        return favorites
    }
}
