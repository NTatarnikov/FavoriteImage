//
//  ImageService.swift
//  FavoriteImages
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import UIKit

// Класс ImageService является сервисом для загрузки изображений по заданному тексту
class ImageService {
    
    // Используем синглтон для обеспечения единственного экземпляра класса
    static let shared = ImageService()

    func fetchImage(text: String, completion: @escaping (UIImage?) -> Void) {
        // Создаем URL на основе текста
        guard let url = URL(string: "https://dummyimage.com/500x500&text=\(text)") else {
            // Если URL невалиден, вызываем блок завершения с пустым значением
            completion(nil)
            return
        }
        // Используем URLSession для получения данных из URL
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                // Если данные получены, конвертируем их в изображение UIImage и передаем в блок завершения
                let image = UIImage(data: data)
                completion(image)
            } else {
                // Если данные не получены, вызываем блок завершения с пустым значением
                completion(nil)
            }
        }
        // Запускаем задачу загрузки
        task.resume()
    }
}

