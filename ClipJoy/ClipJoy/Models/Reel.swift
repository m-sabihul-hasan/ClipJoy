//
//  Reel.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 09/12/24.
//

import Foundation

struct Reel: Identifiable {
    let id = UUID()
    let videoURL: URL
    let caption: String
    let username: String
}
