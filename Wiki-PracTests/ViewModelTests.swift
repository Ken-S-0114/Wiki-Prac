//
//  ViewModelTests.swift
//  Wiki-PracTests
//
//  Created by 佐藤賢 on 2019/06/09.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest

@testable import Wiki_Prac

class ViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    var scheduler: TestScheduler!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
    }

    func testViewModelの正常系出力をモックで確認() {
        let searchWord = scheduler.createHotObservable([
                Recorded.next(1, "S"),
                Recorded.next(2, "Sw"),
                Recorded.next(3, "Swi")
            ])

        let json = "{\"pageid\": 499755, \"title\": \"スイフト\"}"

        let wikipediaPage = try! JSONDecoder().decode(
            WikipediaPage.self,
            from: json.data(using: .utf8)!
        )

        let viewModel = WikipediaSearchViewModel(
            searchWord: searchWord.asObservable(),
            wikipediaAPI: MockWikipediaAPI(results: Observable.of([wikipediaPage]))
        )

        let observer = scheduler.createObserver([WikipediaPage].self)
        viewModel.wikipediaPages
            .bind(to: observer)
            .disposed(by: disposeBag)

        let expectedEvents = [
                Recorded.next(3, [wikipediaPage])
            ]

        scheduler.start()
        XCTAssertEqual(observer.events, expectedEvents)
    }

    func testViewModelの異常系出力をテストする() {
        enum TestError: Error {
            case dummyError
            case dummyError1
        }

        let testError = Observable<[WikipediaPage]>.error(TestError.dummyError)

        let viewModel = WikipediaSearchViewModel(
            searchWord: Observable.just("Swift"), wikipediaAPI: MockWikipediaAPI(results: testError)
        )

        let error = try! viewModel.error.toBlocking().first()!


        XCTAssertEqual(Event<[WikipediaPage]>.error(error), Event<[WikipediaPage]>.error(TestError.dummyError))
        XCTAssertNotEqual(Event<[WikipediaPage]>.error(error), Event<[WikipediaPage]>.error(TestError.dummyError1))
    }
}
