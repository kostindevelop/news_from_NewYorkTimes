//
//  StorageService.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 10.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import Foundation
import CoreData

class StorageService {
    
    static let shared = StorageService()
    
    private let persistantContainerName = "developer_nytimes"
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistantContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("save successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }
    
    func addNewsToFavourites(with favouritesNews: Result) {
        let news = News(context: context)
        news.dataCreate = favouritesNews.publishedDate
        news.detailNewsUrl = favouritesNews.url
        news.imageUrl = favouritesNews.media?.first?.mediaMetadata?.first?.url
        news.subTitle = favouritesNews.abstract
        news.title = favouritesNews.title
        save()
    }
    
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    func getAllFavoritesNews() -> [News] {
        return fetch(News.self)
    }
}
