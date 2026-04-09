//
//  ResearchFrameworksSheet.swift
//  Social IQ
//

import SwiftUI

struct ResearchFrameworksSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let frameworks: [(icon: String, name: String, description: String, citation: String)] = [
        (
            "🧠",
            "Ekman's Facial Action Coding",
            "Reading micro-expressions and emotional states from facial cues.",
            "Dr. Paul Ekman - UCSF"
        ),
        (
            "🏷️",
            "Emotional Labeling",
            "Naming someone's emotion out loud reduces its intensity and builds trust.",
            "Dr. Matthew Lieberman - UCLA"
        ),
        (
            "👂",
            "Active Listening",
            "Reflecting, paraphrasing, and asking follow-up questions to demonstrate understanding.",
            "Carl Rogers - founder of person-centered therapy"
        ),
        (
            "🪞",
            "Mirroring and Labeling",
            "Repeating back what someone said builds rapport and makes them feel heard.",
            "Chris Voss - former FBI lead hostage negotiator"
        ),
        (
            "🤝",
            "Gottman's Bids for Connection",
            "Responding to people's emotional bids (turning toward vs. turning away) predicts relationship success.",
            "Dr. John Gottman - University of Washington"
        ),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Our answers are grounded in peer-reviewed social psychology research and proven negotiation frameworks.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(Theme.Opacity.subtle))
                        .padding(.bottom, 4)

                    ForEach(frameworks, id: \.name) { framework in
                        HStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.blue.opacity(Theme.Opacity.muted))
                                .frame(width: 3)

                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 8) {
                                    Text(framework.icon)
                                        .font(.title3)
                                    Text(framework.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                }
                                Text(framework.description)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))
                                    .lineSpacing(3)
                                Text(framework.citation)
                                    .font(.caption2)
                                    .italic()
                                    .foregroundStyle(.white.opacity(0.45))
                            }
                            .padding(.leading, 12)
                            .padding(.vertical, 14)
                            .padding(.trailing, 14)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.06))
                        )
                    }
                }
                .padding(20)
            }
            .background(Color.black)
            .navigationTitle("The Science Behind Social IQ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}
