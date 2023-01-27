//
//  FFmpegBuilder.swift
//  SubtitleMerge
//
//  Created by Joseph Pecoraro on 1/26/23.
//

import Foundation

enum FFmpegValidationError: Error {
    case invalidURL(String)
}

class FFmpegBuilder {
    private var inputFile : URL?
    private var subtitleFile : URL?
    private var outputFilePath : URL?
    
    func inputFile(url: URL?) -> FFmpegBuilder {
        inputFile = url
        return self
    }
    
    func subtitleFile(url: URL?) -> FFmpegBuilder {
        subtitleFile = url
        return self
    }
    
    func outputFilePath(url: URL?) -> FFmpegBuilder {
        outputFilePath = url
        return self
    }
    
    func build() throws -> Process {
        guard let inputFile = self.inputFile else {
            throw FFmpegValidationError.invalidURL("Input file must be provided")
        }
        
        guard let subtitleFile = self.subtitleFile else {
            throw FFmpegValidationError.invalidURL("Subtitle file must be provided")
        }
        
        guard let outputFilePath = self.outputFilePath else {
            throw FFmpegValidationError.invalidURL("A valid output file path must be provided")
        }
        
        // TODO: If this doesn't work, try checking here https://gist.github.com/kurlov/32cbe841ea9d2b299e15297e54ae8971
        let process = Process()
        process.executableURL = ffmpegPath()
        process.arguments = ["-i", inputFile.path,
                             "-i", subtitleFile.path,
                             "-c", "copy",
                             outputFilePath.path]
        
        return process
    }
    
    // TODO: Add a way to set the ffmpeg path, or pick up path variables from local
    // TODO: Find ffmpeg at startup, and if we can't yell at the user
    func ffmpegPath() -> URL {
        do {
            return try URL(resolvingAliasFileAt: URL(fileURLWithPath: "/opt/homebrew/bin/ffmpeg"))
        } catch {
            print(error.localizedDescription)
        }
        
        return URL(fileURLWithPath: "/opt/homebrew/bin/ffmpeg")
    }
    
}
