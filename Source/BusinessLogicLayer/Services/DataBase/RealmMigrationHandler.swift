//
//  RealmMigrationHandler.swift
//

import Foundation
import RealmSwift

class RealmMigrationHandler: RealmMigrationHandlerType {
    let realm: Realm
    
    /// Returns a newly initialized migration handler
    init() {
        let currentSchemaVersion: UInt64 = 1
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: currentSchemaVersion
        )
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        do {
            realm = try Realm()
            print("Realm: \(config.fileURL?.absoluteString ?? "🆘 Unknown database location")")
        } catch {
            print(error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }
}
