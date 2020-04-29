//
//  Data.swift
//  VisionBoard
//
//  Created by Ángeles Vázquez Parra on 29/04/2020.
//  Copyright © 2020 Ángeles Vázquez Parra. All rights reserved.
//

import Foundation
import RealmSwift

class Goal: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var dificult: Int = 0
    var parentVisionBoard = LinkingObjects(fromType: VisionBoard.self, property: "goals")
}
