struct Song: Identifiable, Codable {
    let id = UUID()
    var title: String
    var fileURL: URL
    var isDefault: Bool = false
}