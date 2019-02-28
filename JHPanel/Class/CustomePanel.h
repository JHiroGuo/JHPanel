//
//  CustomePanel.h
//  MacXcodeDemo
//
//  Created by GJH on 2017/9/5.
//  Copyright © 2017年 chird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface CustomePanel : NSObject

+(NSOpenPanel *)openPanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                              chooseFiles:(BOOL)bChooseFiles
                        multipleSelection:(BOOL)bSelection
                        chooseDirectories:(BOOL)bChooseDirc
                        createDirectories:(BOOL)bCreateDirc
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes;

//  Open Panel To Choose Files
+(NSArray *)getOpenPanelChooseFiles:(NSOpenPanel *)panel;







//  Open Save Panel To Set Save File
+(NSSavePanel *)savePanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                                 setTitle:(NSString *)title
                           nameFiledValue:(NSString *)fileName
                        createDirectories:(BOOL)bCreateDirc
                   bSelectHiddenExtension:(BOOL)bSelectHiddenExtension
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes;


+(NSString *)getSavePanelChooseFiles:(NSSavePanel *)panel;




//  Open Save Panel To Set Save File
+(NSSavePanel *)savePanelWithAllowedFileTypes:(NSArray *)fileTypes
                              titleMessage:(NSString *)ttMessage
                                 setPrompt:(NSString *)prompt
                         andAccessoryImage:(NSImage *)accessoryImage;

@end
