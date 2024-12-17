//
//  SongLibrary.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//


class SongLibrary: ObservableObject {
    @Published var songs: [Song] = []

    init() {
        loadDefaultSongs()
        loadUserSongs() // If you still want user uploads
    }

    private func loadDefaultSongs() {
        // Suppose we know the filenames in advance
        let defaultFilenames = ["track1", "track2", "track3"]
        
        for filename in defaultFilenames {
            if let url = Bundle.main.url(forResource: filename, withExtension: "mp3") {
                let simpleTitle = filename.capitalized  // or any logic to produce a display name
                let song = Song(title: simpleTitle, fileURL: url, isDefault: true)
                songs.append(song)
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