//
//  SongLibrary.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//

import Foundation
import SwiftUI

class SongLibrary: ObservableObject {
    @Published var songs: [Song] = []

    init() {
        loadDefaultSongs()
//        loadUserSongs() // If you still want user uploads
    }

    private func loadDefaultSongs() {
        // Assume you know the filenames or have a predefined list
        let karaokeFilenames = ["Pompeii", "Light Switch", "Sara Perche Ti Amo"]
        
        for filename in karaokeFilenames {
            if let url = Bundle.main.url(forResource: filename, withExtension: "mp3") {
                let song = Song(title: filename.capitalized, fileURL: url, isDefault: true)
                songs.append(song)
            } else {
                print("Could not find \(filename).mp3 in KaraokeSongs folder.")
            }
        }
    }

    private func loadUserSongs() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let libraryURL = documentsURL.appendingPathComponent("UserSongs.json")
        
        guard fileManager.fileExists(atPath: libraryURL.path) else { return }
        
        do {
            let data = try Data(contentsOf: libraryURL)
            let userSongs = try JSONDecoder().decode([Song].self, from: data)
            songs.append(contentsOf: userSongs)
        } catch {
            print("Error loading user songs: \(error)")
        }
    }

    func saveUserSongs() {
        let userSongs = songs.filter { !$0.isDefault }
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let libraryURL = documentsURL.appendingPathComponent("UserSongs.json")
        do {
            let data = try JSONEncoder().encode(userSongs)
            try data.write(to: libraryURL)
        } catch {
            print("Error saving user songs: \(error)")
        }
    }
}
