//
//  File.swift
//  VisionBoard
//
//  Created by Ángeles Vázquez Parra on 29/04/2020.
//  Copyright © 2020 Ángeles Vázquez Parra. All rights reserved.
//

import Foundation
import RealmSwift

class VisionBoard: Object{
    @objc dynamic var title: String = ""
    let goals = List<Goal>()
}
