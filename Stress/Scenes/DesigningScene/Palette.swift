//
//  Palette.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Palette: UIView {
    var currentToolType: ToolType?
    let backControl = Control(type: ControlType.back)
    let resetControl = Control(type: ControlType.reset)
    let loadControl = Control(type: ControlType.load)
    let saveControl = Control(type: ControlType.save)
    let playControl = Control(type: ControlType.play)

    private weak var currentTool: Tool?

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 200).isActive = true

        let root = createRoot()

        let toolStack = createToolStack(root: root)
        let tools = [Tool(type: .create(shape: .circle, isObjective: true)),
                     Tool(type: .create(shape: .circle, isObjective: false)),
                     Tool(type: .create(shape: .triangle, isObjective: true)),
                     Tool(type: .create(shape: .triangle, isObjective: false)),
                     Tool(type: .delete)]
        tools.forEach { tool in
            toolStack.addArrangedSubview(tool)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTool(_:)))
            tool.addGestureRecognizer(gesture)
        }
        let spacer = Spacer(axis: .horizontal)
        toolStack.addArrangedSubview(spacer)

        let controlStack = createControlStack(root: root)
        controlStack.addArrangedSubview(backControl)
        controlStack.addArrangedSubview(resetControl)
//        controlStack.addArrangedSubview(Spacer(axis: .horizontal))
        controlStack.addArrangedSubview(loadControl)
        controlStack.addArrangedSubview(saveControl)
//        controlStack.addArrangedSubview(Spacer(axis: .horizontal))
        controlStack.addArrangedSubview(playControl)
//        controlStack.setCustomSpacing(16, after: resetControl)
//        controlStack.setCustomSpacing(16, after: saveControl)
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

    private func createToolStack(root: UIStackView) -> UIStackView {
        let toolStack = UIStackView()
        root.addArrangedSubview(toolStack)
        toolStack.axis = .horizontal
        toolStack.distribution = .fill
        toolStack.alignment = .center
        toolStack.spacing = 8
        toolStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolStack.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            toolStack.trailingAnchor.constraint(equalTo: root.trailingAnchor),
            toolStack.heightAnchor.constraint(equalToConstant: 76)
        ])
        return toolStack
    }

    private func createControlStack(root: UIStackView) -> UIStackView {
        let controlStack = UIStackView()
        root.addArrangedSubview(controlStack)
        controlStack.axis = .horizontal
        controlStack.distribution = .fill
        controlStack.alignment = .center
        controlStack.spacing = 8
        controlStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controlStack.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            controlStack.trailingAnchor.constraint(equalTo: root.trailingAnchor),
            controlStack.heightAnchor.constraint(equalToConstant: 76)
        ])
        return controlStack
    }

    @objc func selectTool(_ sender: UIGestureRecognizer) {
        guard let tool = sender.view as? Tool else {
            fatalError("Sender's view is not a Tool")
        }
        currentTool?.isSelected = false
        if currentTool == sender.view {
            currentTool = nil
            currentToolType = nil
        } else {
            tool.isSelected = true
            currentTool = tool
            currentToolType = tool.type
        }
    }
}
