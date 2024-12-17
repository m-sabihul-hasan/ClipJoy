import AVFoundation

class AudioPlayer: ObservableObject {
    private var player: AVAudioPlayer?

    func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Could not play audio: \(error)")
        }
    }

    func stop() {
        player?.stop()
    }
}