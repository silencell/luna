$(document).ready(function(){
    $.post('http://web.hundun.cn/micro/analysis_init/58fc5278ffffbe7cbe40c8c2', function(result){
    	// console.log(data);
    	console.log(result.data);
    	console.log(result.data[0].typeScore[0].type_data.length);
    	
    	var allnumber=[0,0];
    	    for(var i=0; i<result.data.length; i++)
    		{
    			for(var j=0; j<result.data[i].typeScore.length; j++)
    			{
    				allnumber[i]+=result.data[i].typeScore[j].type_data.length;
    				console.log(result.data[i].type_name);
    				console.log(allnumber[i]);
    			}
    		}
    		$("#flexBox>p:nth-child(1)").append(result.data[0].type_name+": "+allnumber[0]);
    		$("#flexBox>p:nth-child(2)").append(result.data[1].type_name+": "+allnumber[1]);
    		// alert(allnumber);
        });
    if(typeof(EventSource)!=="undefined"){
  		var source=new EventSource('http://web.hundun.cn/micro/analysis_init/58fc5278ffffbe7cbe40c8c2');
  		source.onmessage=function(event)
    	{
    		console.log(event.data);
    		document.getElementById("result").innerHTML+=event.data + "<br />";
    	};
  	}
	else{
  		document.getElementById("result").innerHTML="抱歉，您的浏览器不支持 server-sent 事件 ...";
  	}
  });