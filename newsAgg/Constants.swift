//
//  ViewController.swift
//  newsAgg
//
//  Created by Cyril Kardash on 28.10.2024.
//

import UIKit

struct K {
    //Для обработки ошибок
    static let invalidURL = "Invalid URL"
    static let noData = "No data received"
    static let decodingError = "Failed to decode data:"
    static let networkError = "Network error:"
    static let serverError = "Failed to download image from server"
    
    //Ключ api
    static let urlAPI = "https://newsdata.io/api/1/latest?apikey=pub_577507f2eb56063c4df972908e94bb20673ea&language=ru"
    static let page = "&page="
    
    //Идентификаторы
    static let newsCell = "NewsCell"
    static let favoritesUpdated = "favoritesUpdated"
    
    //Названия для UI элементов
    static let error = "Ошибка"
    static let ok = "Ок"
    static let unknownCreator = "Неизвестный автор"
    static let noDescription = "Нет описания"
    static let news = "Новости"
    static let favorites = "Избранные"
    static let deleteAction = "Удалить"
 
    //Картинки
    static let bookmark = "bookmark"
    static let bookmarkFill = "bookmark.fill"
    static let back = "chevron.backward"
    static let newspaperFill = "newspaper.fill"
    
    //Имя для сохранения файла
    static let favoriteArcitlesJson = "favorites.json"
}

