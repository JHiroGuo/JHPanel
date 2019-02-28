//
//  ViewController.m
//  JHPanel
//
//  Created by GJH on 2019/2/27.
//  Copyright © 2019 GJH. All rights reserved.
//

#import "ViewController.h"
#import "CustomePanel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)opnePanelModal:(NSButton *)sender
{
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
}


- (IBAction)openPanelUnModal:(NSButton *)sender
{
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
}

- (IBAction)savePanelModal:(NSButton *)sender
{
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
}


- (IBAction)savePanelUnModal:(NSButton *)sender
{
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
}

- (IBAction)savePanelWithImage:(NSButton *)sender
{
    NSSavePanel *panel  = [CustomePanel
                           savePanelWithAllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil] 
                           titleMessage:@"Save File"
                           setPrompt:NULL
                           andAccessoryImage:[NSImage imageNamed:@"QRCode"]];
    [panel runModal];
    
}


@end
