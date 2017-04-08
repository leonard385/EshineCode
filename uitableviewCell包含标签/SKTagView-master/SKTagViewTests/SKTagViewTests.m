//
//  SKTagViewTests.m
//  SKTagViewTests
//
//  Created by Akram Hussein on 18/04/2015.
//  Copyright (c) 2015 shiweifu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "SKTagView.h"
#import "SKTag.h"

@interface SKTagViewTests : XCTestCase

@property (strong, nonatomic) SKTagView *tagView;

@end

@interface SKTagView ()

@property (nonatomic, strong) NSMutableArray *tags;

@end

@implementation SKTagViewTests

- (void)setUp {
    [super setUp];

    self.tagView = [[SKTagView alloc] initWithFrame: CGRectZero];
}

- (void)tearDown {
    [super tearDown];
}

// MARK: - Test Properties

- (void)testTagViewInitWithFrame {
    XCTAssertNotNil(self.tagView);
    XCTAssertTrue(CGRectEqualToRect(self.tagView.frame, CGRectZero));
}

- (void)testTagViewSetPadding {
    self.tagView.padding = UIEdgeInsetsMake(1, 1, 1, 1);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.tagView.padding, UIEdgeInsetsMake(1, 1, 1, 1)));
}

- (void)testTagViewSetLineSpace {
    self.tagView.lineSpacing = 10;
    XCTAssertEqual(self.tagView.lineSpacing, 10);
}

- (void)testTagViewSetInsets {
    
    self.tagView.interitemSpacing = 10;
    XCTAssertEqual(self.tagView.interitemSpacing, 10);
}

- (void)testTagViewPreferredMaxLayoutWidth {
    SKTagView *tagView = [[SKTagView alloc] initWithFrame: CGRectZero];
    
    tagView.preferredMaxLayoutWidth = 10;
    XCTAssertEqual(tagView.preferredMaxLayoutWidth, 10);
}

- (void)testTagViewSingleLine {
    
    self.tagView.singleLine = true;
    XCTAssertTrue(self.tagView.singleLine);

    self.tagView.singleLine = false;
    XCTAssertFalse(self.tagView.singleLine);
}

// MARK: - Test Public Methods

- (void)testTagViewAddTag {
    SKTag *tag = [SKTag tagWithText:@"Test Tag"];
    
    [self.tagView addTag:tag];
    
    XCTAssertEqual(self.tagView.tags.count, 1);
}

- (void)testTagViewRemoveTag {
    SKTag *tag = [SKTag tagWithText:@"Test Tag"];
    
    [self.tagView addTag:tag];
    [self.tagView removeTag: tag];
    
    XCTAssertEqual(self.tagView.tags.count, 0);
}

- (void)testTagViewRemoveSameTagTwice {
    SKTag *tag = [SKTag tagWithText:@"Test Tag"];
    
    [self.tagView addTag:tag];
    [self.tagView removeTag: tag];
    [self.tagView removeTag: tag];
    
    XCTAssertEqual(self.tagView.tags.count, 0);
}

- (void) testTagViewInsertTagAtIndex {
    SKTag *tag = [SKTag tagWithText:@"Test Tag"];
    
    [self.tagView insertTag:tag atIndex:0];
    
    XCTAssertEqual(self.tagView.tags.count, 1);
    XCTAssertEqualObjects([self.tagView.tags objectAtIndex:0], tag);
}

- (void) testTagViewInsertMultipleTagsAtIndex {
    SKTag *tag1 = [SKTag tagWithText:@"Test Tag 1"];
    SKTag *tag2 = [SKTag tagWithText:@"Test Tag 2"];
    
    [self.tagView insertTag:tag1 atIndex:0];
    [self.tagView insertTag:tag2 atIndex:1];
    
    XCTAssertEqual(self.tagView.tags.count, 2);
    XCTAssertEqualObjects([self.tagView.tags objectAtIndex:0], tag1);
    XCTAssertEqualObjects([self.tagView.tags objectAtIndex:1], tag2);
}

- (void) testTagViewInsertAndRemoveTagAtIndex {
    SKTag *tag = [SKTag tagWithText:@"Test Tag"];
    
    [self.tagView insertTag:tag atIndex:0];
    [self.tagView removeTagAtIndex:0];
    
    XCTAssertEqual(self.tagView.tags.count, 0);
}

- (void) testTagViewRemoveAllTags {
    SKTag *tag1 = [SKTag tagWithText:@"Test Tag 1"];
    SKTag *tag2 = [SKTag tagWithText:@"Test Tag 2"];
    SKTag *tag3 = [SKTag tagWithText:@"Test Tag 3"];
    
    [self.tagView insertTag:tag1 atIndex:0];
    [self.tagView insertTag:tag2 atIndex:1];
    [self.tagView insertTag:tag3 atIndex:2];
    
    XCTAssertEqual(self.tagView.tags.count, 3);
    
    [self.tagView removeAllTags];
    
    XCTAssertEqual(self.tagView.tags.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
