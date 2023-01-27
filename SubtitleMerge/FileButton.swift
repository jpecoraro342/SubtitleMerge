//
//  FileButton.swift
//  SubtitleMerge
//
//  Created by Joseph Pecoraro on 1/26/23.
//

import SwiftUI

// TODO: Accept drag events https://developer.apple.com/documentation/appkit/documents_data_and_pasteboard/supporting_drag_and_drop_through_file_promises
// TODO: Support multiselect
struct FileButton: View {
    var title = "Select File"
    var action: (URL?) -> Void
    
    var body: some View {
        Button(title) {
            let panel = NSOpenPanel()
            panel.allowsMultipleSelection = false
            panel.canChooseDirectories = false
            if panel.runModal() == .OK {
                action(panel.url)
            }
        }
    }
}
