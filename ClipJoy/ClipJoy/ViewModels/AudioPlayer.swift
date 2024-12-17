//
//  AudioPlayer.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//

import AVFoundation

class AudioPlayer: ObservableObject {
    var player: AVPlayer?
    private var currentURL: URL?

    func load(url: URL) {
        if currentURL != url {
            player = AVPlayer(url: url)
            currentURL = url
        }
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }
}
