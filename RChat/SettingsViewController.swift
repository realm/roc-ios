//
//  SettingsViewController.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Eureka
import BRYXBanner

class SettingsViewController : FormViewController {

    lazy var profileRow : ProfileRow = {
        let row = ProfileRow()
        return row
    }()

    lazy var usernameRow : TextRow = {
        let row = TextRow() { row in
            row.title = "Username: "
        }
        row.disabled = Condition(booleanLiteral: true)
        return row
    }()

    lazy var displayNameRow : TextRow = {
        let row = TextRow() { row in
            row.title = "Display Name:"
        }
        return row
    }()

    lazy var saveButtonRow : ButtonRow = {
        let row = ButtonRow() { row in
            row.title = "Save Changes"
        }
        return row
    }()

    lazy var logoutButtonRow : ButtonRow = {
        let row = ButtonRow() { row in
            row.title = "Logout"
        }
        return row
    }()

    var viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"

        form +++ Section()
            <<< profileRow.onCellSelection({ [weak self] (cell, row) in
                guard let `self` = self else { return }
                row.deselect(animated: true)
                self.viewModel.profileRowDidTap()
            }).onChange({ (r) in
                self.viewModel.avatarImage = r.value
                r.reload()
            })
            <<< usernameRow
            <<< displayNameRow.onChange({ [weak self] (r) in
                guard let `self` = self else { return }
                self.viewModel.displayName = r.value
            })

        form +++ Section()
            <<< saveButtonRow.onCellSelection({ [weak self] (_, _) in
                guard let `self` = self else { return }
                self.viewModel.saveRowDidTap()
            })

        form +++ Section()
            <<< logoutButtonRow.onCellSelection({ [weak self] (_, _) in
                guard let `self` = self else { return }
                self.viewModel.logoutRowDidTap()
            })


        usernameRow.value = viewModel.username
        displayNameRow.value = viewModel.displayName
        profileRow.value = viewModel.avatarImage
        viewModel.presentProfileImageChangeAlert = { [weak self] in
            guard let `self` = self else { return }
            let alertController = UIAlertController(title: "Change Profile Image", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "From Camera", style: .default, handler: { (_) in
                self.presentCamera()
            }))
            alertController.addAction(UIAlertAction(title: "From Photo Library", style: .default, handler: { (_) in
                self.presentPhotoLibrary()
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

        viewModel.presentLogoutAlert = { [weak self] in
            guard let `self` = self else { return }
            let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Yes, Log me out", style: .destructive, handler: { (_) in
                self.viewModel.confirmLogoutDidTap()
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

        viewModel.returnToWelcomeViewController = { [weak self] in
            guard let `self` = self else { return }
            self.navigationController?.setViewControllers([WelcomeViewController()], animated: true)
        }

        viewModel.showSaveSuccessBanner = {
            let banner = Banner(title: "Settings Saved")
            banner.backgroundColor = RChatConstants.Colors.nephritis
            banner.dismissesOnTap = true
            banner.show(duration: 2.0)
        }
    }

}
