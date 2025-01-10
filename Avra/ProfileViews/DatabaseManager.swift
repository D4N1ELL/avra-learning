//
//  DatabaseManager.swift
//  Avra
//
//  Created by Daniel Istrati on 09.01.2025.
//
import Foundation
import SQLite
import CryptoKit


class DatabaseManager {
    static let shared = DatabaseManager()
    private let db: Connection

    private let usersTable = Table("users")
    private let id = Expression<Int64>(value: "id")
    private let email = Expression<String>(value: "email")
    private let hashedPassword = Expression<String>(value: "hashedPassword")

    private init() {
        _ = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        do {
            db = try Connection("/Users/danielistrati/Documents/UNIWA/Avra/Avra/db.sqlite3")
            createUsersTable()
        } catch {
            fatalError("Unable to initialize database: \(error)")
        }
    }

    private func createUsersTable() {
        let createTable = usersTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)  // Correctly define an Int64 column as the primary key
                table.column(email, unique: true)
                table.column(hashedPassword)
        }

        do {
            try db.run(createTable)
            print("Created table")
        } catch {
            print("Table already exists: \(error)")
        }
    }

    func addUser(email: String, password: String) throws {
        let insert = usersTable.insert(self.email <- email, hashedPassword <- password)
        do {
            let _ = try db.run(insert)
            print("User successfully added.")
        } catch {
            print("Insert failed: \(error)")
            throw error  // Rethrowing the error to be handled in the signUp function
        }
    }



    // Add more functions as needed for handling users
}
