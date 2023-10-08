//
//  APIErrors.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/07.
//

import Foundation

enum CommonErrors: Error {
    case invalidURL
    case notVerifiedStatusCode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "error_description_commonErrors_invalidURL".localized
        case .notVerifiedStatusCode:
            return "error_description_commonErrors_notVerifiedStatusCode".localized
        }
    }
}

enum StatusCodeErrors: Int, Error {
    case invalidRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalServerError = 500
    
    var errorDescription: String {
        switch self {
        case .invalidRequest:
            return "error_description_statusCodeErrors_invalidRequest".localized
        case .unauthorized:
            return "error_description_statusCodeErrors_unauthorized".localized
        case .forbidden:
            return "error_description_statusCodeErrors_forbidden".localized
        case .notFound:
            return "error_description_statusCodeErrors_notFound".localized
        case .conflict:
            return "error_description_statusCodeErrors_conflict".localized
        case .internalServerError:
            return "error_description_statusCodeErrors_internalServerError".localized
        }
    }
}
