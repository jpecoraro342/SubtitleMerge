//
//  ContentView.swift
//  SubtitleMerge
//
//  Created by Joseph Pecoraro on 1/26/23.
//

import SwiftUI

class FFmpegBuilder {
    var inputFile : URL?
    var subtitleFile : URL?
    var outputFilePath : URL?
    
    func build() -> Process {
        // TODO: Make this work
        return Process()
    }
}

struct ContentView: View {
    @State var videoInput : URL?
    @State var subtitleInput : URL?
    @State var isRunning = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                VStack (alignment: .leading, spacing: 15) {
                    Text(videoInput?.lastPathComponent ?? "Original Video File")
                    Text(subtitleInput?.lastPathComponent ?? "Subtitle File")
                }
                .padding()
                VStack (alignment: .trailing, spacing: 15) {
                    // TODO: Accept drag events https://developer.apple.com/documentation/appkit/documents_data_and_pasteboard/supporting_drag_and_drop_through_file_promises
                    Button("Select File") {
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = false
                        if panel.runModal() == .OK {
                            self.videoInput = panel.url
                        }
                    }
                    Button("Select File") {
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = false
                        if panel.runModal() == .OK {
                            self.subtitleInput = panel.url
                        }
                    }
                }
                .padding()
            }
            Button("Merge Subtitles") {
               print("TODO: run ffmpeg")
                isRunning = !isRunning
            }
            // TODO: Make this a progress bar
            if isRunning {
                ProgressView()
            }
            // TODO: done view
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
