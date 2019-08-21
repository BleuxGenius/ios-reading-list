//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_167 on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//



import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(withTitle title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasbeenRead = !books[index].hasbeenRead
        
        saveToPersistentStore()
    }
    
    func update(book: Book, withTitle title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        
        var scratch = book
        
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.insert(scratch, at: index)
    }
    
    // MARK: - Private methods
    
    private func loadFromPersistentStore() {
        
        do {
            guard let fileURL = readingListURL else { return }
            
            let notebooksData = try Data(contentsOf: fileURL)
            
            let plistDecoder = PropertyListDecoder()
            
            self.books = try plistDecoder.decode([Book].self, from: notebooksData)
        } catch {
            NSLog("Error decoding memories from property list: \(error)")
        }
    }
    
    private func saveToPersistentStore() {
        
        let plistEncoder = PropertyListEncoder()
        
        do {
            let notebooksData = try plistEncoder.encode(books)
            
            guard let fileURL = readingListURL else { return }
            
            try notebooksData.write(to: fileURL)
        } catch {
            NSLog("Error encoding memories to property list: \(error)")
        }
    }
    
    // MARK: - Properties
    
    private var readingListURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "ReadingList.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }

    private(set) var books: [Book] = []
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasbeenRead == false })
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasbeenRead })
    }
}
