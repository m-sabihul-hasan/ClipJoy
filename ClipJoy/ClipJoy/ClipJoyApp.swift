//
//  ClipJoyApp.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 09/12/24.
//

import SwiftUI
import AVFoundation

@main
struct ClipJoyApp: App {
    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
