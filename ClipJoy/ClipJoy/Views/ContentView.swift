struct ContentView: View {
    @StateObject var library = SongLibrary()
    @State private var showingImporter = false

    var body: some View {
        NavigationView {
            List(library.songs) { song in
                Text(song.title)
            }
            .navigationTitle("My Songs")
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
                // Same SongImporter as before
                SongImporter { selectedURL in
                    if let url = selectedURL {
                        addUserSong(from: url, to: library)
                    }
                }
            }
        }
    }

    func addUserSong(from sourceURL: URL, to library: SongLibrary) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let newFileURL = documentsURL.appendingPathComponent(sourceURL.lastPathComponent)

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