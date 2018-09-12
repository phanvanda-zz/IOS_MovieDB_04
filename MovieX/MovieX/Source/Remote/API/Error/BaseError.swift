//
//  BaseError.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

enum BaseError: Error {
    
    private struct Constants {
        static let error = "Error"
        static let networkError = "Network Error"
        static let unexpectedError = "Unexpected Error"
        static let redirectionError = "It was transferred to a different URL. I'm sorry for causing you trouble"
        static let clientError = "An error occurred on the application side. Please try again later!"
        static let serverError = "A server error occurred. Please try again later!"
        static let unofficalError = "An error occurred. Please try again later!"
    }
    
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case apiFailure(error: ErrorResponse?)
    
    public var errorMessage: String? {
        switch self {
        case .networkError:
            return "Network Error"
        case .httpError(let code):
            return getHttpErrorMessage(httpCode: code)
        case .apiFailure(let error):
            if let error = error {
                return error.message
            }
            return "Error"
        default:
                return Constants.unexpectedError
        }
    }
    
    private func getHttpErrorMessage(httpCode: Int) -> String? {
        if (httpCode >= 300 && httpCode <= 308) {
            return "It was transferred to a different URL. I'm sorry for causing you trouble";
        }
        
        if (httpCode >= 400 && httpCode <= 451) {
            return "An error occurred on the application side. Please try again later!";
        }
        
        if (httpCode >= 500 && httpCode <= 511) {
            return "A server error occurred. Please try again later!";
        }
        
        return "An error occurred. Please try again later!";
    }
}

