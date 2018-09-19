//
//  MoviesTonightTests.swift
//  MoviesTonightTests
//
//  Created by Pawan on 13/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import XCTest
@testable import MoviesTonight

class MoviesTonightTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMovieResultsSuccessCall() {
        guard let gitUrl = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1") else { return }
        let promise = expectation(description: "Success Request")
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    XCTAssertTrue(result["total_results"] as! Int > 0)
                    XCTAssertTrue((result["results"] as! [Any]).count > 0)

                    let results = result["results"] as! [Any]
                    if let firstResult = results.first as? [String:Any] {
                        XCTAssertTrue((firstResult["title"] as! String != ""))
                    }

                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMovieResultsEmptyResultsCall() {
        guard let gitUrl = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=23_sdffaf&page=1") else { return }
        let promise = expectation(description: "No Results Request")
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    XCTAssertTrue(result["total_results"] as! Int == 0)
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //To check whether the keys app is using are coming from backend.
    func testMovieResultsResponseVerification() {
        guard let gitUrl = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1") else { return }
        let promise = expectation(description: "Response Verification Request")
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    XCTAssertTrue(result["total_results"] as! Int > 0)
                    XCTAssertTrue((result["results"] as! [Any]).count > 0)
                    
                    let results = result["results"] as! [Any]
                    if let firstResult = results.first as? [String:Any] {
                        XCTAssertTrue((firstResult["title"] as! String != ""))
                        XCTAssertTrue((firstResult["poster_path"] as! String != ""))
                        XCTAssertTrue((firstResult["vote_average"] as! Double > -1.0))
                        XCTAssertTrue((firstResult["original_language"] as? String != ""))
                        XCTAssertTrue((firstResult["overview"] as! String != ""))
                        XCTAssertTrue((firstResult["release_date"] as! String != ""))
                        XCTAssertTrue((firstResult["adult"] as? Bool != nil))
                    }
                    
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }

}
