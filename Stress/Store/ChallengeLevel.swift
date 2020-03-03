//
//  ChallengeLevel.swift
//  Stress
//
//  Created by Shawn Koh on 3/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics
import RealmSwift

enum ChallengeLevel {
    static let challenge: LevelData = {
        let circlePegs = List<CirclePegData>()
        circlePegs.append(objectsIn: challengeCircles)
        let trianglePegs = List<TrianglePegData>()
        trianglePegs.append(objectsIn: challengeTriangles)
        let levelData = LevelData(name: "Challenge",
                                  width: Double(Settings.Level.size.width),
                                  height: Double(Settings.Level.size.height),
                                  circlePegs: circlePegs,
                                  trianglePegs: trianglePegs)
        return levelData
    }()

    private static let challengeCircles = [
        CirclePegData(centerX: 140.5, centerY: 135, radius: 20, type: 2),
        CirclePegData(centerX: 413, centerY: 392.5, radius: 20, type: 1),
        CirclePegData(centerX: 348, centerY: 356.5, radius: 20, type: 0),
        CirclePegData(centerX: 396.5, centerY: 233, radius: 20, type: 3),
        CirclePegData(centerX: 370, centerY: 322.5, radius: 20, type: 0),
        CirclePegData(centerX: 441.5, centerY: 312, radius: 20, type: 0),
        CirclePegData(centerX: 402, centerY: 298.5, radius: 20, type: 0),
        CirclePegData(centerX: 661.5, centerY: 138, radius: 20, type: 2),
        CirclePegData(centerX: 469.5, centerY: 341, radius: 20, type: 0),
        CirclePegData(centerX: 419, centerY: 458, radius: 20, type: 0)
    ]

    private static let challengeTriangles = [
        TrianglePegData(vertexAX: 21.5,
                        vertexAY: 203.167,
                        vertexBX: 1.5,
                        vertexBY: 243.167,
                        vertexCX: 41.5,
                        vertexCY: 243.167,
                        type: 1),
        TrianglePegData(vertexAX: 772.0,
                        vertexAY: 200.5,
                        vertexBX: 752.0,
                        vertexBY: 240.5,
                        vertexCX: 792.0,
                        vertexCY: 240.5,
                        type: 1),
        TrianglePegData(vertexAX: 64.5,
                        vertexAY: 281.167,
                        vertexBX: 44.5,
                        vertexBY: 321.167,
                        vertexCX: 84.5,
                        vertexCY: 321.167,
                        type: 0),
        TrianglePegData(vertexAX: 43.0,
                        vertexAY: 241.667,
                        vertexBX: 23.0,
                        vertexBY: 281.667,
                        vertexCX: 63.0,
                        vertexCY: 281.667,
                        type: 0),
        TrianglePegData(vertexAX: 730,
                        vertexAY: 277.167,
                        vertexBX: 710,
                        vertexBY: 317.167,
                        vertexCX: 750,
                        vertexCY: 317.167,
                        type: 0),
        TrianglePegData(vertexAX: 750.5,
                        vertexAY: 238.333,
                        vertexBX: 730.5,
                        vertexBY: 278.333,
                        vertexCX: 770.5,
                        vertexCY: 278.333,
                        type: 0)
        ]
}
