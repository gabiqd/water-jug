//
//  WaterJugViewModel.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

class WaterJugViewModel {
    struct Node {
        var direction: Int
        var current: Int
        var total: Int
    }
    
    var emoji: String {
        if hasFoundSolution {
            return "🎉"
        }
        return "😔"
    }
    var resultTitle: String {
        if hasFoundSolution {
            return "Success"
        }
        return "Failure"
    }
    
    var resultDescription: String {
        if hasFoundSolution {
            return "There is a solution! Congrats!"
        }
        return "Unfortunetly there is no solution"
    }
    
    var hasFoundSolution: Bool {
        return steps.count > 0
    }
    
    var target: Int {
        return waterJugModel.z
    }
    
    private var waterJugModel: WaterJugModel
    
    private var steps = [Step]()
    private var currentIndex = -1
    
    init(x: Int, y: Int, z: Int) {
        waterJugModel = WaterJugModel(x: x, y: y, z: z)
        
        findSolution()
    }
    
    func getWaterProgress(step: Step) -> (x: Float, y: Float)? {
        return (x: Float(step.x) / Float(waterJugModel.x), y: Float(step.y) / Float(waterJugModel.y))
    }
    
    private func findSolution() {
        if waterJugModel.x + waterJugModel.y < waterJugModel.z { return }//false }
        
        let directions = [waterJugModel.x, -waterJugModel.x, waterJugModel.y, -waterJugModel.y]
        var queue = [Int]()
        queue.append(0)
        
        var visited = Set<Int>()
        visited.insert(0)
        
        var seen = [Node]()
        
        repeat {
            let cur = queue.removeFirst()
            if cur == waterJugModel.z { return }
            for direction in directions {
                let total = direction + cur
                if total == waterJugModel.z {
                    seen.append(Node(direction: direction, current: cur, total: total))
                    visited.insert(total)
                    
                    updateSteps(nodes: seen)
                    
                    return
                }
                if total < 0 || total > waterJugModel.x + waterJugModel.y { continue }
                if !visited.contains(total) {
                    
                    seen.append(Node(direction: direction, current: cur, total: total))
                    
                    visited.insert(total)
                    queue.append(total)
                }
            }
        } while !queue.isEmpty
    }

    private func updateSteps(nodes: [Node]) {
        var auxX = 0
        var auxY = 0
        var finalNodes = [Node]()
        
        finalNodes.append(nodes.last!)
        
        var auxNode = nodes.last?.current
        
        for node in nodes.reversed() {
            if auxNode == node.total {
                auxNode = node.current
                finalNodes.append(node)
            }
        }
        
        for step in finalNodes.reversed() {
            switch step.total {
            case waterJugModel.x:
                if step.current == 0 {
                    auxX = waterJugModel.x
                    steps.append(Step(x: auxX, y: auxY, action: .fillX))
                }
            case waterJugModel.y:
                if step.current == 0 {
                    auxY = waterJugModel.y
                    steps.append(Step(x: auxX, y: auxY, action: .fillY))
                }
            case step.current + waterJugModel.x:
                if step.current == 0 || step.current == waterJugModel.y {
                    auxX = waterJugModel.x
                    steps.append(Step(x: auxX, y: auxY, action: .fillX))
                } else {
                    if auxY == 0 {
                        auxY = auxX > waterJugModel.y ? waterJugModel.y : auxX
                        auxX = auxX - auxY
                    } else {
                        let resto = waterJugModel.y - auxY
                        auxY = waterJugModel.y
                        auxX -= resto
                    }
                    
                    steps.append(Step(x: auxX, y: auxY, action: .transferXintoY))
                    
                    auxX = waterJugModel.x
                    steps.append(Step(x: auxX, y: auxY, action: .fillX))
                }
            case step.current + waterJugModel.y:
                if step.current == 0 || step.current == waterJugModel.x {
                    auxY = waterJugModel.y
                    steps.append(Step(x: auxX, y: auxY, action: .fillY))
                } else {
                    if auxX == 0 {
                        auxX = auxY > waterJugModel.x ? waterJugModel.x : auxY
                        auxY = auxY - auxX
                    } else {
                        let resto = waterJugModel.x - auxX
                        auxX = waterJugModel.x
                        auxY -= resto
                    }

                    steps.append(Step(x: auxX, y: auxY, action: .transferYintoX))
                    
                    auxY = waterJugModel.y
                    steps.append(Step(x: auxX, y: auxY, action: .fillY))
                }
            case step.current - waterJugModel.x:
                if step.current == waterJugModel.y || step.total == step.current + waterJugModel.y {
                    auxX = 0
                    steps.append(Step(x: auxX, y: auxY, action: .emptyX))
                } else {
                    let resto = waterJugModel.x - auxX
                    auxX = waterJugModel.x
                    auxY -= resto
                    steps.append(Step(x: auxX, y: auxY, action: .transferYintoX))
                    
                    auxX = 0
                    steps.append(Step(x: auxX, y: auxY, action: .emptyX))
                }
            case step.current - waterJugModel.y:
                if step.current == waterJugModel.y || step.total == step.current + waterJugModel.y {
                    auxY = 0
                    steps.append(Step(x: auxX, y: auxY, action: .emptyY))
                } else {
                    let resto = waterJugModel.y - auxY
                    auxY = waterJugModel.y
                    auxX -= resto
                    steps.append(Step(x: auxX, y: auxY, action: .transferYintoX))
                    
                    auxY = 0
                    steps.append(Step(x: auxX, y: auxY, action: .emptyY))
                }
            default: break
            }
        }
    }
    
    func getNextStep() -> Step? {
        let auxIndex = currentIndex + 1
        if auxIndex < steps.count && auxIndex >= 0 {
            currentIndex = auxIndex
            return steps[currentIndex]
        }
        return nil
    }
    
    var currentStepdescription: String {
        return "Step \(currentIndex + 1): \(steps[currentIndex].action.description)"
    }
    
    func getPreviousStep() -> Step? {
        let auxIndex = currentIndex - 1
        if auxIndex < steps.count && auxIndex >= 0 {
            currentIndex = auxIndex
            return steps[currentIndex]
        }
        return nil
    }
    
    func resetIndex() {
        currentIndex = -1
    }
}
