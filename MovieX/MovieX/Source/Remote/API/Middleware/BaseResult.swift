//
//  BaseResult.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

enum BaseResult<T: Mappable> {
    case success(T?)
    case failure(error: BaseError?)
}
