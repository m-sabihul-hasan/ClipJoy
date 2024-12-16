//
//  ReelPlayerView.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 09/12/24.
//

import SwiftUI
import AVKit

struct ReelPlayerView: View {
    let reel: Reel
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if let player = player {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                        player.actionAtItemEnd = .none
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { _ in
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
                    .onDisappear {
                        player.pause()
                    }
            } else {
                Color.black
            }

            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(reel.username)
                            .font(.headline)
                            .foregroundColor(.white)

                        Text(reel.caption)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            player = AVPlayer(url: reel.videoURL)
        }
        .onDisappear {
            player = nil
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ReelPlayerView(reel: Reel(
        videoURL: URL(string: "https://example.com/sample-video.mp4")!, // Replace with a valid URL
        caption: "Sample Caption",
        username: "@just.sabih"
    ))
}
