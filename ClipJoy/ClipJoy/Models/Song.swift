//
//  Song.swift
//  ClipJoy
//
//  Created by Muhammad Sabihul Hasan on 17/12/24.
//

import Foundation
import SwiftUI

struct Song: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var fileURL: URL
    var isDefault: Bool = false

    init(id: UUID = UUID(), title: String, fileURL: URL, isDefault: Bool = false) {
        self.id = id
        self.title = title
        self.fileURL = fileURL
        self.isDefault = isDefault
    }
}
