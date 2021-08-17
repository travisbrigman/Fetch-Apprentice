//
//  ErrorMessage.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/13/21.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidData = "Sorry. Something went wrong, try again"
    case invalidResponse = "Error. Please modify your search and try again"
}
