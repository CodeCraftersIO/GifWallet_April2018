//
//  Created by Pierluigi Cifani on 29/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import CoreData

extension ManagedGIF {
    var tags: Set<String> {
        guard let managedTags = self.managedTags as? Set<ManagedTag> else {
            return []
        }
        return Set(managedTags.flatMap { return $0.name })
    }
}

extension ManagedTag {
    var gifs: Set<ManagedGIF> {
        guard let managedGifs = self.managedGifs as? Set<ManagedGIF> else {
            return []
        }
        return managedGifs
    }
}
