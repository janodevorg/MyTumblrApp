import OAuth2
import XCTest

final class EntitlementTests: XCTestCase
{
    private func createStore() throws -> OAuth2Store {

        OAuth2Store(account: "Twitter", accessGroup: "PPSF6CNP8Q.dev.jano.tumblr")
    }

    override func tearDown() {
        try? createStore().write(nil)
    }

    func testStore() throws {
        let store = try createStore()

        let accessTokenWritten = AccessTokenResponse(
            accessToken: "cafebabe",
            tokenType: .bearer,
            expiresInSeconds: 3600,
            refreshToken: "https://refresh.com/token",
            scope: "email",
            additionalInfo: [
                "idToken": "mystery",
                "API" : "https://api.provider.com"
            ]
        )
        try store.write(accessTokenWritten)
        let accessTokenRead = try store.read()
        XCTAssertEqual(accessTokenWritten, accessTokenRead)
    }
}
