import XCTest
@testable import FastBike

class TrentinoBikeStationServiceTest: XCTestCase {
    
    func testDelegateGetStationsToUnderlyingServices() {
        let firstService = MockBikeStationService()
        let secondService = MockBikeStationService()
        let service = TrentinoBikeStationService(services: firstService, secondService)

        service.getStations()

        XCTAssert(firstService.getStationsCalled)
        XCTAssert(secondService.getStationsCalled)
    }

    class MockBikeStationService: BikeStationService {

        var delegate: BikeStationServiceDelegate?
        var getStationsCalled = false

        func getStations() {
            getStationsCalled = true
        }

    }
}

class TrentinoBikeStationService: BikeStationService {

    let services: [BikeStationService]
    weak var delegate: BikeStationServiceDelegate?
    
    init(services: BikeStationService...) {
        self.services = services
    }

    func getStations() {
        services.forEach { $0.getStations() }
    }
}