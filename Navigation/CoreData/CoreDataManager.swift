//
//  CoreDataManager.swift
//  Navigation
//
//  Created by TIS Developer on 07.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import CoreData

class DataBaseService {

    static let shared = DataBaseService()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let storeName = "DatabaseModel.sqlite"
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()

    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    func getPost(_ autor: String, _ discription: String, _ image: String, _ likes: Int16, _ views: Int16) {
        let fetch = PostModel.fetchRequest()
        do {
            let setings = try managedObjectContext.fetch(fetch)
            if let newLikedPost = NSEntityDescription.insertNewObject(forEntityName: "PostModel", into: managedObjectContext) as? PostModel {
                newLikedPost.autor = autor
                newLikedPost.discription = discription
                newLikedPost.image = image
                newLikedPost.likes = likes
                newLikedPost.views = views
            }
            try managedObjectContext.save()
            print(setings.count + 1)
        } catch let error {
            print(error)
        }
    }

    func setPost() -> [PostVK] {
        let fetch = PostModel.fetchRequest()
        do {
            var uPosts = [PostVK]()
            let posts = try managedObjectContext.fetch(fetch)
            for post in posts {
            guard let autor = post.autor, let discription = post.discription,
                  let image = post.image else {return []}
            let uPost = PostVK(author: autor, description: discription, image: image, likes: post.likes, views: post.views)
                uPosts.append(uPost)
            }
            return uPosts
        } catch {
            fatalError()
        }
    }

func deleteAll() {
    do {
            try managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "PostModel")))
        } catch let error {
            print(error)
        }
    }
}
