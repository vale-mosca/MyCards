//
//  Profile+CoreDataProperties.swift
//  MyCards
//
//  Created by Valerio Mosca on 22/11/22.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var fiscalCode: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var hasDocuments: NSSet?
    
    public var wrappedName:String{
        name ?? "Unknown Name"
    }
    
    public var wrappedSurname:String{
        surname ?? "Unknown Surname"
    }
    
    public var documentsArray: [Document]{
        let set = hasDocuments as? Set<Document> ?? []
        return set.sorted{
            $0.wrappedCardTypo < $1.wrappedCardTypo
        }
    }
    
    public var numberOfCards: Int{
        return documentsArray.count
    }

}

// MARK: Generated accessors for hasDocuments
extension Profile {

    @objc(addHasDocumentsObject:)
    @NSManaged public func addToHasDocuments(_ value: Document)

    @objc(removeHasDocumentsObject:)
    @NSManaged public func removeFromHasDocuments(_ value: Document)

    @objc(addHasDocuments:)
    @NSManaged public func addToHasDocuments(_ values: NSSet)

    @objc(removeHasDocuments:)
    @NSManaged public func removeFromHasDocuments(_ values: NSSet)

}

extension Profile : Identifiable {

}
