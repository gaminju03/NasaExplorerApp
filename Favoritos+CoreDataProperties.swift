//
//  Favoritos+CoreDataProperties.swift
//  NasaExplorerApp
//
//  Created by Juan on 29/04/20.
//  Copyright © 2020 usuario. All rights reserved.
//
//

import Foundation
import CoreData


extension Favoritos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favoritos> {
        return NSFetchRequest<Favoritos>(entityName: "Favoritos")
    }

    @NSManaged public var titulo: String
    @NSManaged public var imagen: String
    @NSManaged public var fecha: String
    @NSManaged public var id: String

}
