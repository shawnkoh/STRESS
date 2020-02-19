//
//  Dialogs.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

enum Dialogs {
    // swiftlint:disable function_parameter_count

    /**
     Displays a dialog with a message.
     - Parameters:
        - in: The view controller used to present the prompt.
        - title: The text shown as the title of the prompt.
        - message: The text shown in the body of the prompt.
        - dismissActionLabel: The text shown in the dismiss action's label.
     */
    static func showAlert(in viewController: UIViewController,
                          title: String?,
                          message: String?,
                          dismissActionLabel: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissActionLabel, style: .default)
        alert.addAction(dismissAction)
        viewController.present(alert, animated: true)
    }

    /// Displays a dialog with a message prompting the user to input some text.
    /// - Parameters:
    ///     - in: The view controller used to present the prompt.
    ///     - title: The text shown as the title of the prompt.
    ///     - message: The text shown in the body of the prompt.
    ///     - confirmActionTitle: The text shown in the prompt's confirm action.
    ///     - placeholder: The placeholder shown in the prompt's text field.
    ///     - initialValue: The initial value of the prompt's text field.
    ///     - confirmHandler: The action to be performed when the user confirms the prompt.
    static func showPrompt(in viewController: UIViewController,
                           title: String?,
                           message: String?,
                           confirmActionTitle: String,
                           placeholder: String?,
                           initialValue: String,
                           confirmHandler: @escaping (String) -> Void) {
        let prompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var textFieldObserver: NSObjectProtocol?

        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default, handler: { _ in
            guard let input = prompt.textFields?[0].text else {
                fatalError("The prompt's text field cannot be accessed.")
            }
            guard let textFieldObserver = textFieldObserver else {
                fatalError("The prompt's textFieldObserver cannot be accessed.")
            }
            confirmHandler(input)
            NotificationCenter.default.removeObserver(textFieldObserver)
        })
        confirmAction.isEnabled = !initialValue.isEmpty
        prompt.addAction(confirmAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        prompt.addAction(cancelAction)

        prompt.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = initialValue
            // Disables the confirm button when the text field is empty.
            // Credit: https://gist.github.com/TheCodedSelf/c4f3984dd9fcc015b3ab2f9f60f8ad51
            textFieldObserver = NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: .main,
                using: { _ in
                    let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                    let textIsNotEmpty = textCount > 0
                    confirmAction.isEnabled = textIsNotEmpty
                }
            )
        }

        viewController.present(prompt, animated: true, completion: nil)
    }
}
