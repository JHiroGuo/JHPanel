//
//  CustomePanel.m
//  MacXcodeDemo
//
//  Created by GJH on 2017/9/5.
//  Copyright © 2017年 chird. All rights reserved.
//

#import "CustomePanel.h"

@interface CustomePanel()


@end

@implementation CustomePanel




+(NSArray *)getOpenPanelChooseFiles:(NSOpenPanel *)panel;

{
    NSArray *select_files;
    NSInteger result = [panel runModal];
    if (result == NSModalResponseOK)
    {
        select_files = [panel filenames];
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

/**
 Open Panel To Choose Files
 
 @param fileTypes   Able to select file formats
 @param ttMessage   Sets the message shown under title of the panel
 @param prompt      Sets the text shown on the Open or Save button
 @param dirURL      Sets the directoryURL shown
 @return            Use Choose Files URL
 */
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
    [panel setPrompt:prompt];
    [panel setMessage: ttMessage];
    [panel setCanChooseDirectories : bChooseDirc];
    [panel setCanCreateDirectories : bCreateDirc];
    [panel setCanChooseFiles : bChooseFiles];
    [panel setAllowsMultipleSelection : bSelection];
    [panel setAllowedFileTypes : fileTypes];
    [panel setDirectoryURL:dirURL];
    
    return panel;
}

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



+(NSString *)getSavePanelChooseFiles:(NSSavePanel *)panel
{
    NSString *filePath = @"";
    NSInteger result = [panel runModal];
    if (result == NSModalResponseOK)
    {
        filePath = [panel filename] ;  //[panel filename]
        NSLog(@"filePath : %@",filePath);
    }else
    {
        NSLog(@"Choose Cancle! ");
    }
    return filePath;
}



//  Open Save Panel To Set Save File
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

@end
