### v0.9.2
Fixed item spacing being ignored on single line mode.

### v0.9.1
Add highlighted background color

### v0.9
Remove Autolayout inside SKTagView.

### v0.8
Rename insets, lineSpace and didClickTagAtIndex to interitemSpacing, lineSpacing and didTapTagAtIndex.

### v0.7
Added support for attributed strings

### v0.6
Added support for setting the font.

Fixed bug when tag's title is too long.

### v0.5
Added support for setting the userInteractionEnabled of tag.

### v0.4
Added support for setting bgImg,borderColor,borderWidth.

### v0.3
Use block to handle tag's click event.
```objc
//SKTagView
@property (nonatomic, copy) void (^didClickTagAtIndex)(NSUInteger index);
```

### v0.2
Add new methods:
```objc
- (void)insertTag:(SKTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag:(SKTag *)tag;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;
```
