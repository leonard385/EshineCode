#IOS 打开本地或网络PDF word excel PPT等文件
方式：

1. QuickLook
2. UIDocumentInteractionController
3. 文件下载后直接用webView打开


核心代码：

~~~objectivec
- (void)btnClick:(UIButton *)btn{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    if (btn.tag == 0) {
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        self.documentInteractionController.delegate = self;
        [self.documentInteractionController presentPreviewAnimated:YES];
    }else if (btn.tag == 1){
        QuickLookViewController *quickLookVC = [[QuickLookViewController alloc]init];
        quickLookVC.fileURL = URL;
        [self.navigationController pushViewController:quickLookVC animated:YES];
    }else if (btn.tag == 2){
        OpenRemoteFileViewController *openRemoteFileVC =[[OpenRemoteFileViewController alloc]init];
        openRemoteFileVC.fileURLString = @"http://weixintest.ihk.cn/ihkwx_upload/1.pdf";
        [self.navigationController pushViewController:openRemoteFileVC animated:YES];
    }
}

~~~

3.webView下载打开

~~~objectivec
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网络加载");
    NSURL *targetURL = [NSURL URLWithString:self.fileURLString];
    NSString *docPath = [self documentsDirectoryPath];
    NSString *pathToDownloadTo = [NSString stringWithFormat:@"%@/%@", docPath, [targetURL lastPathComponent]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //是否已经下载
    BOOL hasDownLoad= [fileManager fileExistsAtPath:pathToDownloadTo];
    if (hasDownLoad) {
        NSLog(@"下载过了");
        self.fileURL = [NSURL fileURLWithPath:pathToDownloadTo];
        _qlVC = [[QLPreviewController alloc]init];
        _qlVC.delegate = self;
        _qlVC.dataSource = self;
//        _qlVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width , self.view.frame.size.height);
//        [self addChildViewController:_qlVC];
//        [self.view addSubview:_qlVC.view];
//        [_qlVC reloadData];
//        [self.navigationController pushViewController:_qlVC animated:NO];
        [self presentViewController:_qlVC animated:NO completion:nil];
    }else {
        NSLog(@"没下载过");
        NSURL *targetURL = [NSURL URLWithString:self.fileURLString];
        NSData *fileData = [[NSData alloc] initWithContentsOfURL:targetURL];
       
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        [fileData writeToFile:[NSString stringWithFormat:@"%@/%@", documentsDirectory, [targetURL lastPathComponent]] atomically:YES];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [_openFileWebView loadRequest:request];
    }
}

~~~