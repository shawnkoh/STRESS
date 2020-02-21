//
//  Palette.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class Palette: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    var currentTool: Tool?

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 200).isActive = true

        let root = createRoot()

        let toolStack = createToolStack(root: root)
        let tools = [Tool(type: .create(type: .normal)), Tool(type: .create(type: .objective)), Tool(type: .delete)]
        tools.forEach { tool in
            toolStack.addArrangedSubview(tool)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTool(_:)))
            tool.addGestureRecognizer(gesture)
        }
        let spacer = Spacer(axis: .horizontal)
        toolStack.addArrangedSubview(spacer)

        let controlStack = createControlStack(root: root)
    }

    override func didMoveToSuperview() {
        superview?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        superview?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        superview?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func createRoot() -> UIStackView {
        let root = UIStackView()
        addSubview(root)
        root.axis = .vertical
        root.distribution = .equalSpacing
        root.alignment = .center
        root.translatesAutoresizingMaskIntoConstraints = false
        root.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        root.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        root.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        root.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
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
        toolStack.leadingAnchor.constraint(equalTo: root.leadingAnchor).isActive = true
        toolStack.trailingAnchor.constraint(equalTo: root.trailingAnchor).isActive = true
        toolStack.heightAnchor.constraint(equalToConstant: 76).isActive = true
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
        controlStack.leadingAnchor.constraint(equalTo: root.leadingAnchor).isActive = true
        controlStack.trailingAnchor.constraint(equalTo: root.trailingAnchor).isActive = true
        controlStack.heightAnchor.constraint(equalToConstant: 76).isActive = true
        return controlStack
    }

    @objc func selectTool(_ sender: UIGestureRecognizer) {
        guard let tool = sender.view as? Tool else {
            fatalError("Sender's view is not a Tool")
        }
        currentTool?.isSelected = false
        tool.isSelected = true
        currentTool = tool
    }
}
