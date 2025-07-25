//
//  AppearanceView.swift
//  App (Generated by SwiftyLaunch 2.0)
//  https://docs.swiftylaun.ch/module/app/views/app-settings#appearance-settings
//

import SharedKit
import SwiftUI

///Used an example on how to lock specific SwiftUI Views behind a paywall via InAppPurchaseKit (If enabled)
struct AppearanceView: View {

	let popBackToRoot: () -> Void

	@AppStorage("active_app_icon") var activeAppIcon: String = "AppIcon"
	private let appIcons = ["AppIcon", "AppIcon-Alt-1", "AppIcon-Alt-2"]

	var body: some View {
		List {
			Section(header: Text("App Icon")) {
				HStack {
					ForEach(appIcons, id: \.self) { iconName in
						Spacer()

						Button {
							activeAppIcon = iconName
							UIApplication.shared.setAlternateIconName(
								iconName == "AppIcon" ? nil : iconName)
						} label: {
							VStack {
								Image(uiImage: UIImage(named: iconName + "-Preview")!)
									.resizable()
									.squircle(width: 80)

								CheckmarkToggle(checked: activeAppIcon == iconName) {
									activeAppIcon = iconName
								}
							}
						}
						.buttonStyle(.plain)  //Dont remove this, otherwise it will click all buttons at once.
						Spacer()
					}
				}
				.padding(.vertical, 10)

			}
		}
		.navigationTitle("App Appearance")

	}
}

#Preview {
	NavigationStack {
		AppearanceView(popBackToRoot: {})
	}
}
