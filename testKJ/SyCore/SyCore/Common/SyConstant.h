//
//  SyConstant.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

//#ifndef SyCore_SyConstant_h
//#define SyCore_SyConstant_h


//---------------------------每次获取列表的条数
#define kPageListSize 30
#define kAllContactCount    3000
#define kHotTopicCount      50

//---------------------------字体宏
#pragma mark UIFont宏
#define FONT(NAME,FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define FONTSYS(size) ([UIFont systemFontOfSize:(size)])
#define FONTBOLDSYS(size) ([UIFont boldSystemFontOfSize:(size)])
#define FONTITALICSYS(size) ([UIFont italicSystemFontOfSize:(size)])
#define kFont_NavTitle FONTBOLDSYS(17)

//---------------------------颜色宏
#pragma mark Color宏
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]
#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kColor_NavTitle UIColorFromRGB(0xFFFFFF)

//----------------------------Release宏
#pragma mark release宏
#define SY_RELEASE(__POINTER) { [__POINTER release]; }
#define SY_RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


#pragma mark UIImage宏
#define SY_IMAGE(name) [UIImage imageNamed:(name)]
#define SY_PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define SY_JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define SY_PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

#define SY_PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define SY_JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define SY_IMAGENO(NAME,EXT)      [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

#define SY_LoadNibNamed(NAME)             [[[NSBundle mainBundle] loadNibNamed:(NAME) owner:self options:nil] lastObject]


//当前版本
#define FSystenVersion            ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystenVersion            ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion            ([[UIDevice currentDevice] systemVersion])

//当前语言
#define SY_CurrentLanguage           ([[NSLocale preferredLanguages] objectAtIndex:0])
#define SY_AppleLanguages            [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]

//屏幕的分辨率 当结果为1时，显示的是普通屏幕，结果为2时，显示的是Retian屏幕
#define MainScreenScale [[UIScreen mainScreen]scale]
// App Frame Height&Width
#define Application_Frame  [[UIScreen mainScreen] applicationFrame] //除去信号区的屏幕的frame
#define APP_Frame_Height   [[UIScreen mainScreen] applicationFrame].size.height //应用程序的屏幕高度
#define App_Frame_Width    [[UIScreen mainScreen] applicationFrame].size.width  //应用程序的屏幕宽度
/*** MainScreen Height Width */
#define App_Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define App_Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度
//根据系统版本得到屏幕高度
#define APP_IOS_Frame_Width App_Main_Screen_Width
#define APP_IOS_Frame_Height (IOS7 ? App_Main_Screen_Height : APP_Frame_Height)
//#define APP_IOS_Frame_Height IOS7 ? App_Main_Screen_Height : APP_Frame_Height


#warning 第一次搭建，需要修改  --------------------------------------------------------------------
//---------------------------error
#define kDajiaErrorDomain        @"DajiaErrorDomain"
#define kServerErrorCode        @"errorCode"
#define kServerErrorMessage     @"errorMessage"
#define kServerErrorStack       @"errorStack"
#define kServerExceptionID       @"exceptionId"
#define kDajiaLocalErrorDomain        @"DajiaLocalErrorDomain"
#define kAuthError       @"error"
#define kDajiaAuthErrorDomain        @"DajiaAuthErrorDomain"

#define kAuthErrorInvalidGrant 5001

//---------------------------DB
#define kSyDBFileName @"SyLocaDB.db"

//------log cache
#define kAccess_token   @"access_token"
#define kRefresh_token  @"refresh_token"
#define kExpires_in     @"expires_in"
#define kPersonID       @"login_personID"
#define kPersonName     @"login_personName"
#define kCommunityID    @"communityID"
#define kCommunityName  @"communityName"
#define kDeviceToken    @"deviceToken"
#define kUserName       @"kUserName"
#define kPassWord       @"kPassWord"
#define kKeyChain       @"kKeyChain"
#define kSessionID      @"kSessionID"
#define kEmailUrl      @"kEmailUrl"
#define kIsApplying      @"kIsApplying"
#define pCategery  @"productCategery"

#define kExperienceFlag        @"ExperienceFlag"     // 体验服务标识

#define kSendData       @"SendData"
#define KObject1       @"object1"
#define KObject2       @"object2"


#define kZoomViewSingleTap                  @"zoomViewSingleTap"

//消息推送设备类型
#define kClientType  @"ios"

//版本更新
#define kVersionClientType  @"1"
#define kVersionApp @"001"
#define kUpdateStrategyNotNeedUpdate 0
#define kUpdateStrategyNeedUpdate 1
#define kUpdateStrategyMustUpdate 2
#define kVersionDB  @"VersionDB"    // 数据库版本

//----------------------SyTableView
#define kHeight_FooterView      60.0f       // footer
#define kHeight_HeaderView      60.0f
#define kHeight_CellDefault     44.0f
#define kHeight_PullDown        65.0f
#define kHeight_PullUp          10.0f
#define kTableLastRefreshDate   @"LastRefreshDate"
#define kCell_Select        1
#define kCell_UnSelect      2

#define kPullState_Pull         1
#define kPullState_Release      2
#define kPullState_Loading      3
#define kPullState_NoDataLoad   4


// IOS6-IOS7
#ifdef __IPHONE_6_0
# define SYLINE_BREAK_WORD_WRAP NSLineBreakByWordWrapping
#else
# define SYLINE_BREAK_WORD_WRAP UILineBreakModeWordWrap
#endif


//------------------------net support
#define kRecord_TimeOut			300
#define kVoice_TimeOut			120

#define kUIDeviceNet_Invalid            1       // 没有网络
#define kUIDeviceNet_WiFi               2       // WIFI
#define kUIDeviceNet_3G                 3       // 3G



//------------------------file path
#define kFaceImagePath                  @"Documents/File/FaceImage"
#define kPicturePath                    @"Documents/File/Picture"
#define kFilePath                       @"Documents/File/File"
#define kVoicePath                      @"Documents/File/Voice"
#define kRecordPath                     @"Documents/File/Record"
#define kUploadImagesFilePath           @"Documents/File/UploadTemp"
#define kFileTempPath                   @"Documents/File/temp"

#define kSourceRecordFileName           @"recordTemp.caf"


#define K_Default_Image_Type         @"png"
#define K_Image_Type_JPG             @"jpg"
#define K_Image_Type_MOV             @"mov"



//------------------------file type
#define kFileType_Image						1		// 图像文件
#define kFileType_Audio						2		// 音频文件
#define kFileType_Movie                     3       // 视频
#define kFileType_MovieMP4                  4       // 视频MP4
#define kFileType_File                      5       // 附件
#define kMaxPictureCount                    6


//-------------------------date
#define kDateFormate_YYYYMMDDHHMMSS             @"yyyyMMddhhmmss"       // 20130122202240
#define kDateFormate_YYYYMMDDHHBigMMSS          @"yyyyMMddHHmmss"       // 20130122202240
#define kDateFormate_YYYY_MM_DD_hh_MM_SS        @"yyyy-MM-dd hh:mm:ss"  // 2013-01-22 20:22:40
#define kDateFormate_YYYY_MM_DD_HH_MM_SS        @"yyyy-MM-dd HH:mm:ss"  // 2013-01-22 20:22:40
#define kDateFormate_YYYY_MM_DD_hh_MM_PM        @"yyyy-MM-dd hh:mm a"   // 2013-01-22 20:22 AM/PM
#define kDateFormate_YYYY_MM_DD_HH_MM           @"yyyy-MM-dd HH:mm"     // 2013-01-22 20:22
#define kDateFormate_YYYY_MM_DD                 @"yyyy-MM-dd"           // 2013-01-22

//-------------------------audio
#define GetAmrPath(_file)           [NSString stringWithFormat:@"%@/%@",GetAmrDirectory,_file]
#define GetAmrDirectory             [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/.AppData/Amr"]

typedef enum XMPSoundMode{
    XMPSoundModeDefault     = 0,
    XMPSoundModeProximity   = 1,
}XMPSoundMode;
#define kSoundModel              @"SoundModel"

//-----------------------dev
#define iPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) :NO)
#define isPad                      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// UIView - viewWithTag 通过tag值获得子视图
#define VIEWWITHTAG(_OBJECT,_TAG)   [_OBJECT viewWithTag : _TAG]
//应用程序的名字
#define AppDisplayName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
//应用程序的版本
#define AppBundleVersion              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

//判断设备室真机还是模拟器
#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif


#define K_HTTP_REQUEST_TYPE             @"http"
//#endif
