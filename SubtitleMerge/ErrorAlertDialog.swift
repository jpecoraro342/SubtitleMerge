//
//  ErrorAlertDialog.swift
//  SubtitleMerge
//
//  Created by Joseph Pecoraro on 1/26/23.
//

import Cocoa

func displayAlert(_ error: Error) {
    displayAlert(title: "Oops!", error: error)
}

func displayAlert(title: String, error: Error) {
    let alert = NSAlert()
    alert.messageText = title
    alert.informativeText = error.localizedDescription
    alert.addButton(withTitle: "Ok")
    alert.alertStyle = .warning
    alert.runModal()
}
