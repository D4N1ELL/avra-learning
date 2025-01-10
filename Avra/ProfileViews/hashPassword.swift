//
//  hashPassword.swift
//  Avra
//
//  Created by Daniel Istrati on 09.01.2025.
//

import Foundation
import CryptoKit

func hashPassword(_ password: String) -> String {
    let data = Data(password.utf8)  // Convert string to Data type
    let hashed = SHA256.hash(data: data)  // Hash the password
    return hashed.compactMap { String(format: "%02x", $0) }.joined()
}


