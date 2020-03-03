//
//  GalleryViewController.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    unowned let store: Store
    unowned let stateMachine: GameStateMachine

    private let reuseIdentifier = "LevelCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2

    init(store: Store, stateMachine: GameStateMachine) {
        self.store = store
        self.stateMachine = stateMachine
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        modalPresentationStyle = .fullScreen
        collectionView.register(GalleryViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func back(_ sender: UIButton) {
        stateMachine.enter(TitleScreenState.self)
    }

    @objc private func play(_ sender: LevelButton) {
        stateMachine.state(forClass: SelectingLevelState.self)?.selectedLevelData = sender.levelData
        stateMachine.enter(PlayingState.self)
    }

    @objc private func edit(_ sender: LevelButton) {
        stateMachine.state(forClass: SelectingLevelState.self)?.selectedLevelData = sender.levelData
        stateMachine.enter(DesigningState.self)
    }

    @objc private func deleteLevel(_ sender: LevelButton) {
        do {
            try store.removeLevelData(sender.levelData)
        } catch let error {
            // TODO: Add dialog
        }
//        sender.hStack.removeFromSuperview()
    }
}

private class LevelButton: UIButton {
    let levelData: LevelData

    init(levelData: LevelData) {
        self.levelData = levelData
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        store.levelDatas.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? GalleryViewCell else {
            fatalError("Dequeued cell is not a GalleryViewCell")
        }
        let levelData = store.levelDatas[indexPath.row]
        let level = Store.constructLevel(from: levelData)
        let stage = Stage(size: cell.frame.size)
        cell.contentView.addSubview(stage)
        stage.presentLevel(level)

        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = levelData.name
        nameLabel.backgroundColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.layer.cornerRadius = 8

        let playButton = LevelButton(levelData: levelData)
        playButton.setTitle("play", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)

        let editButton = LevelButton(levelData: levelData)
        editButton.setTitle("edit", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.backgroundColor = .white
        editButton.addTarget(self, action: #selector(edit(_:)), for: .touchUpInside)

        let deleteButton = LevelButton(levelData: levelData)
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.backgroundColor = .white
        deleteButton.addTarget(self, action: #selector(deleteLevel(_:)), for: .touchUpInside)

        cell.contentView.addSubview(nameLabel)
        cell.contentView.addSubview(playButton)
        cell.contentView.addSubview(editButton)
        cell.contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),

            playButton.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8),
            playButton.widthAnchor.constraint(equalToConstant: 160),

            editButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            editButton.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8),
            editButton.widthAnchor.constraint(equalToConstant: 100),

            deleteButton.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 8),
            deleteButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    sectionInsets.left
  }
}
