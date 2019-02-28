### NSPanel 的使用

`NSPanel`包含`NSOpenPanel`文件打开面板和`NSSavePanel`文件保存面板。是用来提供文件打开路径选择 和文件保存路径选择的两种系统样式。

#### NSOpenPanel
用于文件打开路径或者文件`保存`路径的选择

##### 属性
```
+(NSOpenPanel *)openPanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                              chooseFiles:(BOOL)bChooseFiles
                        multipleSelection:(BOOL)bSelection
                        chooseDirectories:(BOOL)bChooseDirc
                        createDirectories:(BOOL)bCreateDirc
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setPrompt:prompt]; 	// 设置默认选中按钮的显示（OK 、打开，Open ...） 
    [panel setMessage: ttMessage];	// 设置面板上的提示信息
    [panel setCanChooseDirectories : bChooseDirc]; // 是否可以选择文件夹
    [panel setCanCreateDirectories : bCreateDirc]; // 是否可以创建文件夹
    [panel setCanChooseFiles : bChooseFiles];      // 是否可以选择文件
    [panel setAllowsMultipleSelection : bSelection]; // 是否可以多选
    [panel setAllowedFileTypes : fileTypes];        // 所能打开文件的后缀
    [panel setDirectoryURL:dirURL];		            // 打开的文件路径
    
    return panel;
}

```

##### 方法
###### 非模态(刘海)打开方式
```
  NSOpenPanel *panel = [CustomePanel
                          openPanelWithTitleMessage:@"Choose File" // folder 顶部提示
                                                       setPrompt:@"OK"                      // 文件选择确认键 显示内容（一般NULL随系统）
                                                     chooseFiles:YES                        // 是否可以选择文件（如果为NO 则只可以选择文件夹）
                                               multipleSelection:YES                        // 是否可以多选
                                               chooseDirectories:YES                         // 是否可以选择文件夹
                                               createDirectories:YES                        // 是否可以创建文件夹
                                                 andDirectoryURL:NULL                       // 默认打开路径（桌面、 下载、...）
                                                AllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil] // 所能选择的文件类型
                          ];
    
    __block NSArray *chooseFiles;
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            chooseFiles = [panel URLs];
            NSLog(@"Click OK Choose files : %@",chooseFiles);
        }else if(result == NSModalResponseCancel)
            NSLog(@"Click cancle");
    }];
    
    NSLog(@"Choose files : %@",chooseFiles);
    
--------------------------------------------------------
2019-02-28 15:54:24.466364+0800 JHPanel[1557:21952] Choose files : (null)
2019-02-28 15:54:29.089672+0800 JHPanel[1557:21952] Click OK Choose files : (
    "file:///Users/gjh/Desktop/31111142m4ap.jpg"
)
--------------------------------------------------------    

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190228162446200.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hlcm9HdW9fSlA=,size_16,color_FFFFFF,t_70)

注意：在非模态打开情况下，当调用 `beginSheetModalForWindow` 后 会打开面板----->执行 `beginSheetModalForWindow `下面的代码，然后当用户有选择`OK/Cancle`的时候 才会执行`completionHandler`的`Block`方法。

###### 模态(弹出)打开方式
```
NSOpenPanel *panel = [CustomePanel openPanelWithTitleMessage:@"Choose File" // folder 顶部提示
                                      setPrompt:@"OK"                      // 文件选择确认键 显示内容（一般NULL随系统）
                                    chooseFiles:YES                        // 是否可以选择文件（如果为NO 则只可以选择文件夹）
                              multipleSelection:YES                        // 是否可以多选
                              chooseDirectories:YES                         // 是否可以选择文件夹
                              createDirectories:YES                        // 是否可以创建文件夹
                                andDirectoryURL:NULL                       // 默认打开路径（桌面、 下载、...）
                                AllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil] // 所能选择的文件类型
                     ];    
NSLog(@"choose files : %@",[CustomePanel getOpenPanelChooseFiles:panel]);
 
 
+(NSArray *)getOpenPanelChooseFiles:(NSOpenPanel *)panel;

{
    NSArray *select_files;
    NSInteger result = [panel runModal];
    if (result == NSModalResponseOK)
    {
        select_files = [panel filenames]; // 注意[panel Urls]的路径是 file:///User/GJH/....
        if ([select_files count] == 1)
        {
            NSString * oneFile = [select_files objectAtIndex : 0];
            NSLog(@"SELECT A FILE :%@",oneFile);
            
        }else{
            NSLog(@"SELECT  FILES");
        }
    }
    return  select_files;
}
    
--------------------------------------------------------
2019-02-28 16:01:48.706727+0800 JHPanel[1584:24337] SELECT A FILE :/Users/gjh/Desktop/Image/psb.jpg
2019-02-28 16:01:48.706808+0800 JHPanel[1584:24337] choose files : (
    "/Users/gjh/Desktop/Image/psb.jpg"
)
--------------------------------------------------------    
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190228162537648.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hlcm9HdW9fSlA=,size_16,color_FFFFFF,t_70)
在模态模式下，当运行 `[panel runModal]`代码执行会等待停留在文件选择`Window`上等待用户选择后才会执行下面的代码，如果做`Window`与`Mac`协同开发，建议使用模态模式打开。


#### NSSavePanel
用于文件文件`保存`路径的选择,注意必须设置`User Selected File`权限。设置方法
路径：`target –> capabilitys –> file access `
设置 `user selected file 为 read/write`
否则会报错 *** Assertion failure in ............
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190228163207106.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hlcm9HdW9fSlA=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190228163220812.jpeg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hlcm9HdW9fSlA=,size_16,color_FFFFFF,t_70)
##### 属性

```
+(NSSavePanel *)savePanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                                 setTitle:(NSString *)title
                           nameFiledValue:(NSString *)fileName
                        createDirectories:(BOOL)bCreateDirc
                   bSelectHiddenExtension:(BOOL)bSelectHiddenExtension
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setMessage:ttMessage];
    [panel setPrompt:prompt];
    [panel setAllowedFileTypes:fileTypes];
    [panel setCanCreateDirectories : bCreateDirc];
    [panel setCanSelectHiddenExtension : bSelectHiddenExtension];
    [panel setTitle:title];
    [panel setNameFieldStringValue:fileName];
    [panel setDirectoryURL:dirURL];
    
    return panel;
}
```

##### 方法

###### 模态模式
```
 NSSavePanel *panel  =  [CustomePanel savePanelWithTitleMessage:@"Save File"
                                  setPrompt:NULL
                           setTitle:@"Save File Panel"
                             nameFiledValue:@"Image"
                          createDirectories:YES
                     bSelectHiddenExtension:YES
                            andDirectoryURL:NULL
                           AllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil]];
    
   NSString *savePath = [CustomePanel getSavePanelChooseFiles:panel];
   NSLog(@"Save Path : %@",savePath);
   
+(NSString *)getSavePanelChooseFiles:(NSSavePanel *)panel
{
    NSString *filePath = @"";
    NSInteger result = [panel runModal];
    if (result == NSModalResponseOK)
    {
        filePath = [[panel URL] absoluteString];  //[panel filename] 注意两个路径的格式
        NSLog(@"filePath : %@",filePath);
    }else
    {
        NSLog(@"Choose Cancle! ");
    }
    return filePath;
}

--------------------------------------------------------    
2019-02-28 16:15:00.677722+0800 JHPanel[1649:28355] filePath : /Users/gjh/Desktop/Image.png
2019-02-28 16:15:00.677770+0800 JHPanel[1649:28355] Save Path : /Users/gjh/Desktop/Image.png
--------------------------------------------------------    
    
```


###### 非模态模式
```
NSSavePanel *panel  =  [CustomePanel savePanelWithTitleMessage:@"Save File"
                                                         setPrompt:NULL
                                                          setTitle:@"Save File Panel"
                                                    nameFiledValue:@"Image"
                                                 createDirectories:YES
                                            bSelectHiddenExtension:YES
                                                   andDirectoryURL:NULL
                                                  AllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil]];
    
    __block NSString *chooseFile;
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            chooseFile = [[panel URL] absoluteString];
            NSLog(@"Click OK Choose files : %@",chooseFile);
        }else if(result == NSModalResponseCancel)
            NSLog(@"Click cancle");
    }];
    
    NSLog(@"Choose files : %@",chooseFile);
--------------------------------------------------------   
2019-02-28 16:16:25.377756+0800 JHPanel[1649:28355] Choose files : (null)
2019-02-28 16:16:26.322764+0800 JHPanel[1649:28355] Click OK Choose files : file:///Users/gjh/Desktop/Image.png
--------------------------------------------------------       
    
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019022816262591.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hlcm9HdW9fSlA=,size_16,color_FFFFFF,t_70)
##### 保存弹窗带图片

```
+(NSSavePanel *)savePanelWithAllowedFileTypes:(NSArray *)fileTypes
                              titleMessage:(NSString *)ttMessage
                                 setPrompt:(NSString *)prompt
                         andAccessoryImage:(NSImage *)accessoryImage
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    NSView *accessoryView = [[NSView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    NSImageView *accessoryImageView = [[NSImageView alloc]initWithFrame:accessoryView.frame];
    accessoryImageView.image = accessoryImage;
    accessoryImageView.wantsLayer = YES;
    accessoryImageView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [accessoryView addSubview:accessoryImageView];
    [panel setAccessoryView:accessoryView];
    [panel setAllowedFileTypes:fileTypes];
    [panel setCanCreateDirectories : YES];
    return panel;
}


    NSSavePanel *panel  = [CustomePanel
                           savePanelWithAllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil] 
                           titleMessage:@"Save File"
                           setPrompt:NULL
                           andAccessoryImage:[NSImage imageNamed:@"QRCode"]];
    [panel runModal];

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190228162643225.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hlcm9HdW9fSlA=,size_16,color_FFFFFF,t_70)

PS : 模态状态下都是以弹窗的形式弹出，但是如果有多个扩展屏幕。需要注意弹出的窗体可能和应用程序不在一个窗口上。非模态下弹出窗体都是在应用上以刘海的形式弹出，大需要注意的是，所有额有关`Code`执行循序的问题。
