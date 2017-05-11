var theme_id;
var get_url = function(prop) {
    var GETURL, arg, args, i, len, obj;
    GETURL = {};
    if (location.search.length) {
        args = location.search.slice(1).split('&');
        for (i = 0, len = args.length; i < len; i++) {
        obj = args[i];
        arg = obj.split('=');
        GETURL[arg[0]] = arg[1];
        }

    }
    return GETURL[prop];
};
function handleMessage(e) {
  console.log(e.type, JSON.parse(e.data));
  var val = ~~$('.'+e.type).text();
  var sum = val + JSON.parse(e.data).type_data.length
  $('.'+e.type).text(sum)
}
$(document).ready(function(){
    theme_id= get_url('theme_id') 
    $.post('http://web.hundun.cn/micro/analysis_init/'+theme_id, function(result){
	    for(var i=0; i<result.data.length; i++)
		{
            var sum = 0;
			for(var j=0; j<result.data[i].typeScore.length; j++)
			{
				sum+=result.data[i].typeScore[j].type_data.length;
			}
    		$("#flexBox").append('<p>'+result.data[i].type_name+": <em class='"+theme_id+'_'+result.data[i].type_idname+"'>"+sum+ '</em></p>');
        }
    });
    if(typeof(EventSource)!=="undefined"){
        var source = new EventSource('http://web.hundun.cn:9001/analysis/'+ theme_id);
        var $list = $('.resultdata');
        // when channelsAsEvents is true, you can listen to specific events...
        var queryStr= "http://web.hundun.cn/micro/get_type?theme_id="+theme_id;
        $.get(queryStr, function(res){
          if(res.error_no === 0){
            res.data.forEach(function(item){
              source.addEventListener(theme_id+'_'+item.type_idname, handleMessage, false);
            })
          }
        })


  		// var source=new EventSource('http://web.hundun.cn:9001/analysis/58fc5278ffffbe7cbe40c8c2');
    //     console.log('hahahhah')
  		// source.onmessage=function(event)
    // 	{
    // 		console.log("kk");
    // 		document.getElementById("resultdata").innerHTML+=event.data + "<br />";
    // 	};
  	}
	else{
  		document.getElementById("result").innerHTML="抱歉，您的浏览器不支持 server-sent 事件 ...";
  	}
 // var e = new EventSource('http://web.hundun.cn:9001/analysis/58fc5278ffffbe7cbe40c8c2');
 
// e.onopen = function(){
//   console.log('你创建了一个服务器长连接！');
// };

// e.onmessage = function(event){
//   // var e = event || window.event;
//   console.log('接受到来自服务器的消息： ' + event.data);
// }

// e.onerror = function(event){
//   console.log('链接发生错误，当前链接状态： ' +  event.readyState);
// }
  });