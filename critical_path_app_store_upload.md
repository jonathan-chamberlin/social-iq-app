Here's the full Apple response text with links included (in parentheses after each link text):

---

Hello,

Thank you for providing this information.

Upon further review, we've identified additional issues that require your attention:

Guideline 3.1.2(c) - Business - Payments - Subscriptions

Issue Description

The submission did not include all the required information for apps offering auto-renewable subscriptions.

The following information needs to be included within the app:

- A functional link to the Terms of Use (EULA)
- A functional link to the privacy policy

You can use SubscriptionStoreView (https://developer.apple.com/documentation/storekit/subscriptionstoreview) to easily include all of the required information in the app's purchase flow.

The following information needs to be included in the App Store metadata:

- A functional link to the Terms of Use (EULA). If you are using the standard Apple Terms of Use (EULA) (https://www.apple.com/legal/internet-services/itunes/dev/stdeula/), include a link to the Terms of Use in the App Description. If you are using a custom EULA, add it in App Store Connect (https://developer.apple.com/help/app-store-connect/manage-app-information/set-a-custom-end-user-license-agreement/).

Next Steps

Update the app and App Store metadata to include the information specified above.

Resources

Apps offering auto-renewable subscriptions must include all of the following required information in the app itself:

- Title of auto-renewing subscription (this may be the same as the In-App Purchase product name)
- Length of subscription
- Price of subscription, and price per unit if appropriate
- Functional links to the privacy policy and Terms of Use (EULA)

The app metadata must also include functional links to the privacy policy in the Privacy Policy field in App Store Connect and the Terms of Use (EULA) in the App Description or EULA field in App Store Connect.

Review Schedule 2 of the Apple Developer Program License Agreement (https://developer.apple.com/programs/apple-developer-program-license-agreement/#S2) to learn more.

Guideline 5.1.2(i) - Legal - Privacy - Data Use and Sharing

Issue Description

The app privacy information provided in App Store Connect indicates the app collects data in order to track the user, including Advertising Data. However, the app does not use App Tracking Transparency to request the user's permission before tracking their activity.

Apps need to receive the user's permission through the AppTrackingTransparency framework before collecting data used to track them. This requirement protects the privacy of users.

Next Steps

Here are three ways to resolve this issue:

- If the app does not currently track, update the app privacy information in App Store Connect (https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy-information/). You must have the Account Holder or Admin role (https://developer.apple.com/help/app-store-connect/reference/role-permissions/) to update app privacy information. If you are unable to change the privacy label, reply to this message in App Store Connect, and make sure your App Privacy Information in App Store Connect is up to date before submitting your next update for review.

- If this app does not track on the platform associated with this submission, but tracks on other platforms, notify App Review by replying to the rejection in App Store Connect. You should also reply if this app does not track on the platform associated with this submission but tracks on other Apple platforms this app is available on.

- If the app tracks users on all supported platforms, the app must use App Tracking Transparency (https://developer.apple.com/documentation/apptrackingtransparency) to request permission before collecting data used to track. When resubmitting, indicate in the Review Notes where the permission request is located.

Note that if the app behaves differently in different countries or regions, you should provide a way for App Review to review these variations in the app submission. Additionally, these differences should be documented in the Review Notes section of App Store Connect (https://developer.apple.com/help/app-store-connect/reference/app-review-information/).

Resources

- Tracking is linking data collected from the app with third-party data for advertising purposes, or sharing the collected data with a data broker. Learn more about tracking (https://developer.apple.com/app-store/app-privacy-details/#user-tracking).
- See Frequently Asked Questions about the requirements for apps that track users (https://developer.apple.com/app-store/user-privacy-and-data-use/#permission-to-track).
- Learn more about designing appropriate permission requests (https://developer.apple.com/design/human-interface-guidelines/patterns/accessing-private-data/).

We look forward to reviewing your resubmission.

Best regards,

App Review

---

All links are included in parentheses right after their corresponding link text. You can copy and paste the above directly.
