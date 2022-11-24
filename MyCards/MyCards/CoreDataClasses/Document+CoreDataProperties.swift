//
//  Document+CoreDataProperties.swift
//  MyCards
//
//  Created by Valerio Mosca on 22/11/22.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }
    @NSManaged public var rearImage: Data?
    @NSManaged public var frontImage: Data?
    @NSManaged public var cardType: String?
    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
    @NSManaged public var expiryDate: Date?
    @NSManaged public var cardNumber: String?
    @NSManaged public var hasAProfile: Profile?

    public var wrappedCardTypo: String{
        cardType ?? "Unknown Card"
    }
}

extension Document : Identifiable {

}
