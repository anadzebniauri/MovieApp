//
//  FavoritesCoreDataManager.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 18.08.23.
//

import Foundation

class MessageCoreDataManager: CoreDataManager<FavoritesEntity> {

    func saveMessage(image: String, movieName: String, movieYear: String, isFavorite: Bool) -> FavoritesEntity {
        let favoritesEntity = FavoritesEntity(context: viewContext)
        
        favoritesEntity.image = image
        favoritesEntity.movieName = movieName
        favoritesEntity.movieYear = movieYear
        favoritesEntity.isFavorite = isFavorite

        saveContext()
        return favoritesEntity
    }
    
    func fetchFavorites(withPredicate predicate: NSPredicate? = nil, completion: @escaping ([FavoritesEntity]) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: Constants.key, ascending: true)
        let result = fetch(entityName: Constants.entityName, predicate: predicate, sortDescriptors: [sortDescriptor])
        completion(result)
    }
}

private extension MessageCoreDataManager {
    enum Constants {
       static let entityName = "FavoritesEntity" 
       static let key = "date"
   }
}
