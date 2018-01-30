//
//  GrammyArtist.swift
//  GrammyNominations
//
//  Created by Richard Crichlow on 1/30/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class GrammyArtist {
    var id: String?
    var name: String?
    var album: String?
    init(id: String?, name: String?, album: String?) {
        self.id = id
        self.name = name
        self.album = album
    }
}

