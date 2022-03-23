//
//  Water_JugTests.swift
//  Water JugTests
//
//  Created by Gabriel on 23/03/2022.
//

import XCTest
@testable import Water_Jug

class Water_JugTests: XCTestCase {

    func testFindSolution1() throws {
        let viewModel = WaterJugViewModel(x: 3, y: 5, z: 4)
        
        XCTAssertEqual(viewModel.hasFoundSolution, true)
    }
    
    func testFindSolution2() throws {
        let viewModel = WaterJugViewModel(x: 1, y: 2, z: 3)
        
        XCTAssertEqual(viewModel.hasFoundSolution, true)
    }
    
    func testFindSolution3() throws {
        let viewModel = WaterJugViewModel(x: 2, y: 10, z: 4)
        
        XCTAssertEqual(viewModel.hasFoundSolution, true)
    }

    func testFindSolution4() throws {
        let viewModel = WaterJugViewModel(x: 2, y: 6, z: 5)
        
        XCTAssertEqual(viewModel.hasFoundSolution, false)
    }

    func testStepsFindSolution() throws {
        let viewModel = WaterJugViewModel(x: 2, y: 10, z: 4)
        
        var steps = [Step]()
        steps.append(Step(x: 2, y: 0, action: .fillX))
        steps.append(Step(x: 0, y: 2, action: .transferXintoY))
        steps.append(Step(x: 2, y: 2, action: .fillX))
        
        XCTAssertEqual(viewModel.getNextStep(), steps[0])
        XCTAssertEqual(viewModel.getNextStep(), steps[1])
        XCTAssertEqual(viewModel.getNextStep(), steps[2])
    }
}
