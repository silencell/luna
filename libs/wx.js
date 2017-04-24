var self_url=window.location.href;
var url = self_url;
var title = '混沌研习社感恩季';
var content = '遍邀国内外最顶级的专家学者、企业领袖，全新升级的课程体系，带您触碰全球最有价值的思想。';
var logo = 'http://yxs-app.oss-cn-beijing.aliyuncs.com/4bde9102b7db750ff32b6acd04447946';
var pay_id = window.pay_id;
var phone = window.phone;
var param={
    web_url: self_url
};
// $.get('http://member.hundun.cn/member/redeem_share_info',{pay_id:pay_id},function(res){
//     url = res.share_info.url;
//     title = res.share_info.title;
//     content = res.share_info.content;
//     logo = res.share_info.thumbnail;
// },'json')
$.get('https://tmicro.hundun.cn/weixin_base/get_weixin_config',param,function(data){
    if(data.error_no==0){
        wx.config({
            debug: false,
            appId: data.weixin_config.appId,
            timestamp: data.weixin_config.timestamp,
            nonceStr: data.weixin_config.nonceStr,
            signature: data.weixin_config.signature,
            jsApiList: [
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'showMenuItems',
                'showAllNonBaseMenuItem'
            ]
        });
        wx.ready(function () {
            wx.onMenuShareTimeline({//分享到朋友圈
                title: title, // 分享标题
                link: url, // 分享链接
                imgUrl: logo, // 分享图标
                desc: content,
                success: function () {
                    // 用户确认分享后执行的回调函数-统计分享
                    var params={
                            share_url: url, //分享的页面url
                            share_scene: 2,//分享场景, 1微信朋友/2朋友圈/3QQ好友/4QQ空间/5微博
                            share_user: phone //分享者的用户标识, 注意不同页面的用户标识类型不同, 如手机号/openid
                    };

                    $.post('https://tmicro.hundun.cn/weixin_base/push_share_action',params,function(data){
                        console.log(data);
                        if(data.error_no==0){
                            console.log(data);
                        }else{
                            console.log(data.error_msg);
                        }

                    },'json').error(function(){
                        console.log('微信统计接口请求失败');
                    });
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            });
            wx.onMenuShareAppMessage({//分享给朋友
                title: title, // 分享标题
                link: url, // 分享链接
                imgUrl: logo, // 分享图标
                desc: content,
                success: function () {
                    // 用户确认分享后执行的回调函数-统计分享
                    var params={
                        share_url: url, //分享的页面url
                        share_scene: 1,//分享场景, 1微信朋友/2朋友圈/3QQ好友/4QQ空间/5微博
                        share_user: phone //分享者的用户标识, 注意不同页面的用户标识类型不同, 如手机号/openid
                    };
                    $.post('https://tmicro.hundun.cn/weixin_base/push_share_action',params,function(data){
                        console.log(data);
                        if(data.error_no==0){
                        }else{
                            console.log(data.error_msg);
                        }

                    },'json').error(function(){
                        console.log('微信统计接口请求失败');
                    });
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            });
        });
    }else{
        alert(data.error_msg);
    }

},'json');