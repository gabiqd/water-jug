//
//  Step.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

struct Step: Equatable {
    var x: Int
    var y: Int
    var action: Action
    
    enum Action {
        case fillX
        case fillY
        case transferXintoY
        case transferYintoX
        case emptyX
        case emptyY

        var description: String {
            switch self {
            case .fillX:
                return "Fill bucket X"
            case .fillY:
                return "Fill bucket Y"
            case .transferXintoY:
                return "Transfer bucket X to bucket Y"
            case .transferYintoX:
                return "Transfer bucket Y to bucket X"
            case .emptyX:
                return "Dump bucket X"
            case .emptyY:
                return "Dump bucket Y"
            }
        }
    }
}


