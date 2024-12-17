//
//  ContentView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var library = SongLibrary()
    @State private var showingImporter = false

    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading){
                List(library.songs) { song in
                    NavigationLink(destination: PlayerView(song: song)) {
                        Text(song.title)
                    }
                }
                //            .navigationTitle("Songs Available")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingImporter = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingImporter) {
                    SongImporter { selectedURL in
                        if let url = selectedURL {
                            DispatchQueue.main.async {
                                addUserSong(from: url, to: library)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "music.note.list")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("My Songs")
                            .font(.largeTitle.bold())
                    }
                    .padding()
                    .offset(x: 10 ,y: -35)
                }
            }
        }
    }

    func addUserSong(from sourceURL: URL, to library: SongLibrary) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let newFileURL = documentsURL.appendingPathComponent(sourceURL.lastPathComponent)

        // Start accessing the security-scoped resource
        guard sourceURL.startAccessingSecurityScopedResource() else {
            print("Failed to start accessing security scoped resource.")
            return
        }

        defer {
            // Make sure to stop accessing after the operation is complete
            sourceURL.stopAccessingSecurityScopedResource()
        }

        do {
            if fileManager.fileExists(atPath: newFileURL.path) {
                try fileManager.removeItem(at: newFileURL)
            }
            try fileManager.copyItem(at: sourceURL, to: newFileURL)

            let title = sourceURL.deletingPathExtension().lastPathComponent.capitalized
            let newSong = Song(title: title, fileURL: newFileURL)
            library.songs.append(newSong)
            library.saveUserSongs()
        } catch {
            print("Error adding user song: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SongLibrary())
}
