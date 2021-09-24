//
//  RealmStorage.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import RealmSwift

protocol RealmMigrationHandlerType {}

protocol RealmStorageType: AnyObject {
    var realm: Realm { get }
    
    func allObjects<StoredObject: Object>() -> [StoredObject]
    func store<StoredObject: Object>(object: StoredObject) throws
    func updateObject(_ block: () -> Void) throws
    func delete<StoredObject: Object>(object: StoredObject) throws
}

extension RealmStorageType {
    func allObjects<StoredObject: Object>() -> [StoredObject] {
        return Array(realm.objects(StoredObject.self))
    }
    
    func store<StoredObject: Object>(object: StoredObject) throws {
        try realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func delete<StoredObject: Object>(object: StoredObject) throws {
        try realm.write {
            realm.delete(object)
        }
    }
    
    func updateObject(_ block: () -> Void) throws {
        try realm.write {
            block()
        }
    }
}

final class RealmStorage: RealmStorageType {
    
    let realm: Realm
    private let migration: RealmMigrationHandlerType
    
    /// Returns a newly initialized storage with the migration handler and specified realm database.
    /// It's designated initializer of this class.
    ///
    /// - Parameters:
    ///   - migration: Object that is responsible for migration issues solving
    ///   - realm: A `Realm` database
    init(migration: RealmMigrationHandlerType, realm: Realm) {
        self.migration = migration
        self.realm = realm
    }
    
    /// Convenience initializer that uses `RealmMigrationHandler` instance as migration issues solver.
    convenience init() {
        let handler = RealmMigrationHandler()
        self.init(migration: handler, realm: handler.realm)
    }
}
