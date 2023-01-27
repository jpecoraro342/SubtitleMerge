//
//  FileButton.swift
//  SubtitleMerge
//
//  Created by Joseph Pecoraro on 1/26/23.
//

import SwiftUI

// TODO: Support multiselect
struct FileButton: View {
    var title = "Select File"
    var action: (URL?) -> Void
    @State var isTargeted: Bool = true
    
    var body: some View {
        Button(title) {
            let panel = NSOpenPanel()
            panel.allowsMultipleSelection = false
            panel.canChooseDirectories = false
            if panel.runModal() == .OK {
                action(panel.url)
            }
        }
        .onDrop(of: [.fileURL], isTargeted: $isTargeted) { providers in
            guard let item = providers.first else { return false }
            guard let identifier = item.registeredTypeIdentifiers.first else { return false }
            
            item.loadItem(forTypeIdentifier: identifier, options: nil) { (urlData, error) in
                if let urlData = urlData as? Data {
                    let fileUrl = URL(dataRepresentation: urlData, relativeTo: nil)
                    action(fileUrl)
                }
            }
            
            return true
        }
    }
}
