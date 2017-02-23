//
//  URLMacros.h
//  BSEM
//
//  Created by 逸信Mac on 16/2/29.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

//#define BaseUrl @"http://zy.dglg.net:9080/st/"
//#define BaseUrl @"http://183.232.237.222:8228/st/"


//#define BaseUrl @"http://192.168.2.33:8111/test/"

//#define BaseUrl @"http://www.stu66.com/"//发布

// 东莞理工版本
#if TARGET_DGLG == 1
#define BaseUrl @"http://zy.dglg.net:9080/st/"
// 通用发布版本
#elif TARGET_DGLG == 0
#define BaseUrl @"http://www.stu66.com/"
//#define BaseUrl @"http://soft.xunyijia.cn:8228/st/"
#endif

#define BsemURL_PREFIX  [BaseUrl stringByAppendingString:@"app/"] //公司

#define HTTP(x) [BsemURL_PREFIX stringByAppendingString:x]

#define MsgHTTP(x) [BaseUrl stringByAppendingString:x]


/*------------
      登陆
 -------------*/
#define kDynamicCodeUrl  HTTP(@"account/getScalCode")

/*------------
      求助
 -------------*/
//上传路径信息
#define kSOSPointUrl   HTTP(@"sos/point")

//创建求助记录
#define kNewSosOrderUrl  HTTP(@"sos/callSos")

//停止求救
#define kStopSosUrl  HTTP(@"sos/endSos")

//最后一次求救状态
#define kLastSosState HTTP(@"sos/queryIsEnd")

/*-----------
   考勤
 -----------*/
//查询设置
#define  kGetCardRecordUrl HTTP(@"attend/getRecord")
//获取考勤记录
#define  kGetReCordUrl  HTTP(@"attend/countRecord")
//打卡
#define  kCardUrl  HTTP(@"attend/record")
//查询考勤设置
#define kGetCardSettingUrl HTTP(@"attend/getStudentInternship")

//勤奋榜
#define kHardworkUrl HTTP(@"attend/getHardworkRank")

//迟到榜
#define kLateUrl  HTTP(@"attend/getLateRank")


/*----------- 
 报告
 -----------*/

//添加实习报告
#define HTTP_AddReport HTTP(@"report/submitReport")

//报告详情
#define HTTP_ReportDetail HTTP(@"report/getReport")

//删除实习报告
#define HTTP_DeleteReport HTTP(@"report/delReport")
// 分页查询
#define HTTP_QueryReport HTTP(@"report/queryReport")
// 查询某个报告
#define HTTP_GetReport HTTP(@"report/getReport")

//登陆
#define HTTP_LOGIN HTTP(@"account/submit")

//密文登陆
#define HTTP_LoginMd5 HTTP(@"account/appSubmitScal")

// 退出登录
#define HTTP_LOGOUT HTTP(@"account/logout")

// 修改考勤设置
#define HTTP_UPDATE_ATTEND HTTP(@"attend/updateStudentInternship")

// 查询考勤设置
#define HTTP_QUERY_ATTEND HTTP(@"attend/getStudentInternship")

// 修改紧急联系人
#define HTTP_UPDATE_CONTACTS HTTP(@"sos/updateSosContacts")
// 删除紧急联系人
#define HTTP_DEL_CONTACTS HTTP(@"sos/delSosContacts")
// 查找紧急联系人
#define HTTP_QUERY_CONTACTS HTTP(@"sos/getAllSosContactsByStuId")
// 添加紧急联系人
#define HTTP_ADD_CONTACTS HTTP(@"sos/saveSosContacts")
// 添加报告图片
#define HTTP_NEW_ReportImage HTTP(@"picServerCtrl/uploadPicture")

/**************
 消息
 ***************/

//发送消息给朋友
#define kSendMessageFrind  MsgHTTP(@"snsMsgProduceRecordJson/msg2Friend")
//发送
#define kSendMessageGroup  MsgHTTP(@"snsMsgProduceRecordJson/msg2Group")
//学校消息
#define kSchoolMessage MsgHTTP(@"msgJson/pageMsgSchInfo")
//未读消息列表
#define kUnReadMessageList MsgHTTP(@"snsContactChatJson/getUnReadMsgList")

// 用户联系人接口
// 我的联系人列表
#define KMessageForContacts MsgHTTP(@"snsFriendsContactsJson/getContacts")
// 增量查询联系人
#define KMessageForContactsCdc MsgHTTP(@"snsFriendsContactsJson/getContactsCdc")

//获取群信息
#define KMyGroup  MsgHTTP(@"snsFriendsUserGroupJson/getMyGrps")


//获取学校通知
#define kSchoolNotice MsgHTTP(@"snsNoticeJson/getNoticeList")
//已读学校通知
#define kReadSchoolNotice MsgHTTP(@"snsNoticeJson/readNotice")

#define kUploadImage  MsgHTTP(@"picServerCtrl/uploadPicture")

/**************
  我的
 ***************/
//二维码
#define kQRCodeUrl   MsgHTTP(@"picServerCtrl/getDownloadQrcode")
// 问题反馈
#define KAddProblem HTTP(@"stProblem/addProblem")

#define KChangePassword MsgHTTP(@"h5/stUser/enterUpdatePassword")

#define KQingpinwoEntry  HTTP(@"account/qingpinwoAppEntry")

#endif /* URLMacros_h */


