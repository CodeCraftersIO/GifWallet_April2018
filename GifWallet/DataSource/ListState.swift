//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

/**
 Represents the different states that a list can be

 - Loading: The data is being remotely fetched.
 - Loaded:  The data is loaded and ready to be shown to the user
 - Failure: The data failed to load and an error is shown to the user
 */
public enum ListState<T> {
    case loading
    case loaded(data: [T])
    case failure(error: Error)
}
