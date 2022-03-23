//
//  SelectBucketViewModel.swift
//  Water Jug
//
//  Created by Gabriel on 23/03/2022.
//

enum Jug {
    case x
    case y
    case z
}

class SelectBucketViewModel {
    private(set) var x: Int = 0
    private(set) var y: Int = 0
    private(set) var z: Int = 0
    
    func updateValue(jug: Jug, value: Int) {
        switch jug {
        case .x:
            x = value
        case .y:
            y = value
        case .z:
            z = value
        }
    }
    
    var hasRequiredValues: Bool {
        return x > 0 && y > 0 && z > 0
    }
    
    func makeWaterJugViewModel() -> WaterJugViewModel {
        return WaterJugViewModel(x: x, y: y, z: z)
    }
}

