## SKTagView

[![CI Status](http://img.shields.io/travis/zsk425/SKTagView.svg?style=flat-square)](https://travis-ci.org/zsk425/SKTagView)
[![Version](https://img.shields.io/cocoapods/v/SKTagView.svg?style=flat-square)](http://cocoadocs.org/docsets/SKTagView)
[![License](https://img.shields.io/cocoapods/l/SKTagView.svg?style=flat-square)](http://cocoadocs.org/docsets/SKTagView)
[![Platform](https://img.shields.io/cocoapods/p/SKTagView.svg?style=flat-square)](http://cocoadocs.org/docsets/SKTagView)

This library is derived from [SFTagView](https://github.com/shiweifu/SFTagView), which tries to build a view displaying tags without using UICollectionView and supports Autolayout.

I tried to make it more Autolayout. After having tried a lot, I inspired by UILabel. Now it just works like UILabel and supports single line and multi-line mode.

### Installation with CocoaPods

```ruby
platform :ios, '7.0'
pod "SKTagView"
```

### Usage

#### Example
Check out the project. It contains the usages of normal way and in UITableViewCell.

#### Code
```objc
- (void)setupTagView
{
  self.tagView = ({
    SKTagView *view = [SKTagView new];
    view.backgroundColor = [UIColor cyanColor];
    view.padding = UIEdgeInsetsMake(10, 25, 10, 25);
    view.interitemSpacing = 8;
    view.lineSpacing = 10;
	//Handle tag's tap event
	view.didTapTagAtIndex = ^(NSUInteger index){
		NSLog(@"Tap");
	};
    view;
  });
  [self.view addSubview:self.tagView];
  [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(superView);
    make.leading.equalTo(superView);
    make.trailing.equalTo(superView);
  }];

  //Add Tags
  [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C", @"C", @"PHP"] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
    SKTag *tag = [SKTag tagWithText:text];
    tag.textColor = UIColor.whiteColor;
    tag.bgColor = UIColor.orangeColor;
    tag.cornerRadius = 3;
	tag.fontSize = 15;
	tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);

    [self.tagView addTag:tag];
  }];
}
```

### Tips
When uses with UITableViewCell in multi-line mode,it MUST be set preferredMaxLayoutWidth before invoking
```objc
[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
```

### Screenshots

#### Normal
![](https://raw.github.com/zsk425/SKTagView/master/Screenshots/example.png)

#### With UITableViewCell
![](https://raw.github.com/zsk425/SKTagView/master/Screenshots/example2.png)

### License

SKTagView is available under the MIT license. See the LICENSE file for more info.
