//
//  WikipediaSearchResultDecodableTests.swift
//  Wiki-PracTests
//
//  Created by 佐藤賢 on 2019/06/09.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import XCTest
@testable import Wiki_Prac

class WikipediaSearchResultDecodableTests: XCTestCase {

    func testWikipediaAPIレスポンスのJSONデコードを確認する() {
        let json = """
        {
            "query": {
                "search": [
                    {"pageid": 499755, "title": "スイフト" }
                ]
            }
        }
        """

        let data = json.data(using: .utf8)!
        let response = try! JSONDecoder().decode(WikipediaSearchResponse.self, from: data)

        XCTAssertEqual(response.query.search.first!.id, "499755")
        XCTAssertEqual(response.query.search.first!.title, "スイフト")
        XCTAssertEqual(response.query.search.first!.url.absoluteString, "https://ja.wikipedia.org/w/index.php?curid=499755")
    }

}
