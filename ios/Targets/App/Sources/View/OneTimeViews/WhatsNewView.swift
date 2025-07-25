//
//  WhatsNewView.swift
//  App (Generated by SwiftyLaunch 2.0)
//  https://docs.swiftylaun.ch/module/app/views/whats-new-view
//
//  The WhatsNewView is shown if the user opens the app and it has a different
//  version compared to the last time it was opened. (So it's shown after the user updates).
//  Use it to show what you have added in the new update by replacing the items in the `features` array
//  and by changing the 'new-features' image asset.
//

import SharedKit
import SwiftUI

/// Is attached to the root ContentView in App.swift, and shown when the app version saved in UserDefaults
/// doesn't match the actual version (except if the saved app verison is nil, which means the user is shown the app
/// for the first time ever, then we don't show this view, but rather the OnboardingView)
struct ShowFeatureSheetOnNewAppVersionModifier: ViewModifier {
	@AppStorage(Constants.UserDefaults.General.lastAppVersionAppWasOpenedAt)
	private var lastAppVersionAppWasOpenedAt: String = "NONE"

	@State private var showSheet: Bool = false

	func body(content: Content) -> some View {
		content
			.sheet(isPresented: $showSheet) {
				WhatsNewView {
					showSheet = false
				}
			}
			.onAppear {
				if isPreview {
					showSheet = true
				} else {
					Task {
						try? await Task.sleep(for: .seconds(1))
						showSheet = lastAppVersionAppWasOpenedAt != Constants.AppData.appVersion
						self.lastAppVersionAppWasOpenedAt = Constants.AppData.appVersion
					}
				}
			}
	}

	struct WhatsNewView: View {

		/// Called when the user pressed on the dismiss button
		let onDismiss: () -> Void

		/// Image that is shown in the top of the WhatsNewView
		/// Make it pop ;)
		private let featuresImageName = "new-features"

		/// Set this to show the users the main features and changes of the current version
		/// This view is shown when the user opens the app for the first time on the current app version.
		private let features: [Feature] = [
			Feature(
				sfSymbol: "star.fill", symbolColor: .green, title: "New Feature 1",
				description: "This is a new feature"),
			Feature(
				sfSymbol: "lasso.badge.sparkles", symbolColor: .indigo, title: "New Feature 2",
				description:
					"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
			),
			Feature(
				sfSymbol: "wrench.and.screwdriver", symbolColor: .gray, title: "Bug Fixes",
				description:
					"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
			),
		]

		var body: some View {
			ScrollView {
				VStack {
					VStack(alignment: .leading) {
						Text("Version \(Constants.AppData.appVersion)")
							.fontWeight(.semibold)
							.foregroundStyle(Color.accent.gradient)

						Text("What's new")
							.font(.largeTitle)
							.fontWeight(.bold)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
					.padding(.top, 10)

					Image(featuresImageName)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.padding(.horizontal, -40)

					VStack {
						ForEach(features, id: \.id) { feature in
							FeatureRow(feature: feature)
								.padding(.vertical, 7.5)
								.padding(.bottom, features.last == feature ? 15 : 0)
								.padding(.top, features[0] == feature ? 15 : 0)

							if features.last != feature {
								Divider().padding(.leading, 50)
							}
						}
					}
					.frame(maxWidth: .infinity)
					.background(Color(uiColor: .systemBackground))
					.clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
					.overlay(
						RoundedRectangle(cornerRadius: 25, style: .continuous)
							.strokeBorder(Color(uiColor: .quaternaryLabel), lineWidth: 1)
					)
					.shadow(color: .black.opacity(0.1), radius: 50)
					.padding(.horizontal)
					.padding(.top, -85)
					.padding(.bottom, 75)
				}
			}
			.accentBackground()
			.overlay(alignment: .bottom) {
				Button("Continue to App") {
					onDismiss()
				}
				.buttonStyle(.cta())
				.padding(.horizontal)
				.padding(.bottom)
			}
		}

		private struct Feature: Hashable {
			let id = UUID()
			let sfSymbol: String
			let symbolColor: Color
			let title: LocalizedStringKey
			let description: LocalizedStringKey

			//to conform to hashable
			public func hash(into myhasher: inout Hasher) {
				myhasher.combine(id)
			}
		}

		private struct FeatureRow: View {
			let feature: Feature

			var body: some View {
				HStack(spacing: 12.5) {
					Image(systemName: feature.sfSymbol)
						.foregroundStyle(.white)
						.font(.title3)
						.frame(width: 40, height: 40)
						.background(feature.symbolColor.gradient)
						.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

					VStack(alignment: .leading) {
						Text(feature.title)
							.font(.body)
							.fontWeight(.bold)

						Text(feature.description)
							.font(.footnote)
							.foregroundColor(.secondary)
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.horizontal, 20)
			}
		}
	}
}

#Preview {
	Text("Hello")
		.modifier(ShowFeatureSheetOnNewAppVersionModifier())
}
