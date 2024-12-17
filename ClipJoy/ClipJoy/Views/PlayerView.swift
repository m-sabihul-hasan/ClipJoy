//
//  PlayerView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//


import SwiftUI
import AVFoundation

struct PlayerView: View {
    let song: Song
    @StateObject var audioPlayer = AudioPlayer()

    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var isSeeking = false
    @State private var timeObserverToken: Any?
    @State private var isReady = false

    @State private var statusObservation: NSKeyValueObservation?

    var body: some View {
        VStack(spacing: 20) {
            Text(song.title)
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: {
                    audioPlayer.play()
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
            
            Slider(value: $currentTime, in: 0...max(duration, 0.1), onEditingChanged: { editing in
                if !editing {
                    guard let player = audioPlayer.player else { return }
                    let seekTime = CMTime(seconds: currentTime, preferredTimescale: 600)
                    player.seek(to: seekTime) { _ in
                        // Resume playing after seeking
                        player.play()
                    }
                }
                isSeeking = editing
            })
            .disabled(!isReady || duration == 0)

            HStack {
                Text(formatTime(currentTime))
                Spacer()
                Text(formatTime(duration))
            }
            .font(.subheadline)
            .padding(.horizontal)

        }
        .offset(y: -40)
        .padding()
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            // Stop playback and clean up when leaving this view
            audioPlayer.pause()
            audioPlayer.player = nil
            removePeriodicTimeObserver()
        }
    }

    private func setupPlayer() {
        audioPlayer.load(url: song.fileURL)
        guard let playerItem = audioPlayer.player?.currentItem else {
            print("No player item found.")
            return
        }

        statusObservation = playerItem.observe(\.status, options: [.new, .initial]) { item, _ in
            DispatchQueue.main.async {
                if item.status == .readyToPlay {
                    self.isReady = true
                    let totalSeconds = CMTimeGetSeconds(item.duration)
                    if totalSeconds.isFinite && totalSeconds > 0 {
                        self.duration = totalSeconds
                    }
                    self.addPeriodicTimeObserver()
                } else if item.status == .failed {
                    print("Failed to load the player item. Error: \(String(describing: playerItem.error))")
                }
            }
        }
    }

    func addPeriodicTimeObserver() {
        guard let player = audioPlayer.player else { return }

        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            if !isSeeking {
                self.currentTime = CMTimeGetSeconds(time)
            }
        }
    }

    func removePeriodicTimeObserver() {
        if let token = timeObserverToken, let player = audioPlayer.player {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }

    func formatTime(_ time: Double) -> String {
        guard !time.isNaN else { return "0:00" }
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    let placeholderSong = Song(
        title: "Preview Song",
        fileURL: URL(fileURLWithPath: "/dev/null") // Dummy URL for preview
    )
    PlayerView(song: placeholderSong)
}
