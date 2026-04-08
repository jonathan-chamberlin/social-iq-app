//
//  LessonAnswerSection.swift
//  Social IQ

import SwiftUI

struct LessonAnswerSection: View {
    let lessonTitle: String
    let step: LessonStep
    let scenarioText: String
    let selectedOptionIndex: Int?
    let showFeedback: Bool
    let isCorrectSelection: Bool
    let showOtherAnswers: Bool
    let onSelectOption: (Int) -> Void
    let onShowOtherAnswers: () -> Void
    let onTrackAnswer: (Int) -> Void

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text(lessonTitle)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    LessonStepIndicator(currentLabel: step.label)
                    LessonScenarioCard(scenarioText: scenarioText, isReadStep: step.label == "READ")
                    questionText
                    optionCards
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .onChange(of: showFeedback) { _, showing in
                if showing, let selected = selectedOptionIndex {
                    withAnimation {
                        proxy.scrollTo("option-\(selected)", anchor: .center)
                    }
                    onTrackAnswer(selected)
                }
            }
        }
    }

    // MARK: - Question

    private var questionText: some View {
        Text(step.question)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Option Cards

    private var optionCards: some View {
        VStack(spacing: 12) {
            ForEach(Array(step.options.enumerated()), id: \.element.id) { index, option in
                let shouldShowFeedback: Bool = {
                    if selectedOptionIndex == index && showFeedback {
                        return true
                    }
                    if !option.feedback.isCorrect && showOtherAnswers {
                        return true
                    }
                    return false
                }()

                LessonOptionCard(
                    index: index,
                    option: option,
                    isSelected: selectedOptionIndex == index,
                    showingFeedback: shouldShowFeedback,
                    onTap: { onSelectOption(index) },
                    onNext: {}
                )
            }

            if isCorrectSelection && showFeedback && !showOtherAnswers {
                Button {
                    withAnimation { onShowOtherAnswers() }
                } label: {
                    Text("See why the other answers were wrong")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.goldGradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 8)
            }
        }
    }
}
