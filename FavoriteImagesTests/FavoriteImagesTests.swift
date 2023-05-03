//
//  FavoriteImagesTests.swift
//  FavoriteImagesTests
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import XCTest
@testable import FavoriteImages

class FavoritesServiceTests: XCTestCase {
    var favoritesService: FavoritesService!

    override func setUp() {
        super.setUp()
        favoritesService = FavoritesService()
    }

    override func tearDown() {
        favoritesService = nil
        super.tearDown()
    }

    func testAdd() {
        let imageModel = ImageModel(request: "test", image: UIImage())
        favoritesService.add(imageModel)
        XCTAssertEqual(favoritesService.getAll().count, 1)
    }

    func testRemove() {
        let imageModel = ImageModel(request: "test", image: UIImage())
        favoritesService.add(imageModel)
        XCTAssertEqual(favoritesService.getAll().count, 1)
        favoritesService.remove(at: 0)
        XCTAssertEqual(favoritesService.getAll().count, 0)
    }

    func testGetAll() {
        let imageModel1 = ImageModel(request: "test1", image: UIImage())
        let imageModel2 = ImageModel(request: "test2", image: UIImage())
        favoritesService.add(imageModel1)
        favoritesService.add(imageModel2)
        let allFavorites = favoritesService.getAll()
        XCTAssertEqual(allFavorites.count, 2)
        XCTAssertEqual(allFavorites[0].request, "test1")
        XCTAssertEqual(allFavorites[1].request, "test2")
    }
}

