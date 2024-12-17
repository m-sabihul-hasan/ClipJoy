import SwiftUI
import AVFoundation

struct PlayerView: View {
    let song: Song
    @StateObject var audioPlayer = AudioPlayer()

    var body: some View {
        VStack {
            Text(song.title)
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: {
                    audioPlayer.play(url: song.fileURL)
                }) {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                }
                .padding()

                Button(action: {
                    audioPlayer.pause()
                }) {
                    Image(systemName: "pause.fill")
                        .font(.largeTitle)
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            // If you prefer to auto-play when the view appears, uncomment this line:
            // audioPlayer.play(url: song.fileURL)
        }
    }
}