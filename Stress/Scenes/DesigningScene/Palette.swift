//
//  Palette.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Palette: UIView {
    let selectToolAction: (ToolType?) -> Void
    let radiusStepper = UIStepper(frame: .zero)

    private weak var currentTool: Tool?
    private let radiusLabel = UILabel(frame: .zero)

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init(
        backAction: @escaping () -> Void,
        resetAction: @escaping () -> Void,
        loadAction: @escaping () -> Void,
        saveAction: @escaping () -> Void,
        playAction: @escaping () -> Void,
        selectToolAction: @escaping (ToolType?) -> Void
    ) {
        self.selectToolAction = selectToolAction
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 200).isActive = true

        let root = createRoot()

        let toolStack = createToolStack()
        root.addArrangedSubview(toolStack)

        let controlStack = createHStack()
        root.addArrangedSubview(controlStack)
        let stateStack = createHStack()
        controlStack.addArrangedSubview(stateStack)
        let sizeStack = createSizeStack()
        controlStack.addArrangedSubview(sizeStack)

        let backControl = Control(type: ControlType.back, action: backAction)
        let resetControl = Control(type: ControlType.reset, action: resetAction)
        let loadControl = Control(type: ControlType.load, action: loadAction)
        let saveControl = Control(type: ControlType.save, action: saveAction)
        let playControl = Control(type: ControlType.play, action: playAction)
        [backControl, resetControl, loadControl, saveControl, playControl]
            .forEach { stateStack.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            controlStack.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            controlStack.trailingAnchor.constraint(equalTo: root.trailingAnchor)
        ])
    }

    override func didMoveToSuperview() {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    private func createRoot() -> UIStackView {
        let root = UIStackView()
        addSubview(root)
        root.axis = .vertical
        root.distribution = .equalSpacing
        root.alignment = .center
        root.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            root.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            root.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            root.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            root.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
        return root
    }

    private func createToolStack() -> UIStackView {
        let toolStack = createHStack()
        NSLayoutConstraint.activate([
            toolStack.heightAnchor.constraint(equalToConstant: 76)
        ])
        let tools = [Tool(type: .create(type: .orange, shape: .circle)),
                     Tool(type: .create(type: .orange, shape: .triangle)),
                     Tool(type: .create(type: .blue, shape: .circle)),
                     Tool(type: .create(type: .blue, shape: .triangle)),
                     Tool(type: .create(type: .green, shape: .circle)),
                     Tool(type: .create(type: .green, shape: .triangle)),
                     Tool(type: .create(type: .red, shape: .circle)),
                     Tool(type: .create(type: .red, shape: .triangle)),
                     Tool(type: .delete)]
        tools.forEach { tool in
            toolStack.addArrangedSubview(tool)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTool(_:)))
            tool.addGestureRecognizer(gesture)
        }
        return toolStack
    }

    private func createHStack() -> UIStackView {
        let HStack = UIStackView()
        HStack.axis = .horizontal
        HStack.distribution = .fillEqually
        HStack.alignment = .center
        HStack.spacing = 8
        HStack.translatesAutoresizingMaskIntoConstraints = false
        return HStack
    }

    private func createSizeStack() -> UIStackView {
        let sizeStack = createHStack()

        radiusLabel.text = "Size: \(Int(Settings.Peg.radius))"
        sizeStack.addArrangedSubview(radiusLabel)

        radiusStepper.value = Double(Settings.Peg.radius)
        radiusStepper.addTarget(self, action: #selector(stepRadius), for: .touchUpInside)
        sizeStack.addArrangedSubview(radiusStepper)

        return sizeStack
    }

    @objc private func selectTool(_ sender: UIGestureRecognizer) {
        guard let tool = sender.view as? Tool else {
            fatalError("Sender's view is not a Tool")
        }
        currentTool?.isSelected = false
        if currentTool == sender.view {
            currentTool = nil
        } else {
            tool.isSelected = true
            currentTool = tool
        }
        selectToolAction(currentTool?.type)
    }

    @objc private func stepRadius() {
        radiusLabel.text = "Size: \(Int(radiusStepper.value))"
    }
}
