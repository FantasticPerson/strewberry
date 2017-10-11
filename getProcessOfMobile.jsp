<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title><%=SystemParamConfigUtil.getParamValueByParam("webTitle") %></title>
    <%@ include file="/common/header.jsp"%>
    <%@ include file="/common/headerbase.jsp"%>
    <!--表单样式-->
    <link href="${ctx}/assets-common/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/assets-common/css/timeline.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/assets-common/css/animate.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/assets-common/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="${ctx }/flow/themes/default/easyui.css">
	<link href="${ctx }/flow/css/flowPath_show.css" type="text/css" rel="stylesheet" />    
	<link rel="stylesheet" href="${ctx}/assets-common/css/font-awesome.min.css">
    <script src="${ctx}/assets-common/js/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets-common/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctx }/pdfocx/json2.js?x=2022" type="text/javascript"></script>
	<style type="text/css">
		.bodyclass{
			position: fixed;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
		}
		
		.ls{
			height: 40%;
			overflow: auto;
		}
	</style>
	<script type="text/javascript">
		function hide(){
			$("#hide").css('display','none');
	    	$("#show").css('display','');
	    	$("#contextBody").css('display','none');
	    	$("#wf-course").css('height','');
	    	$("#wf-course").css('overflow','');
		}
		
		function show(){
			$("#show").css('display','none');
	    	$("#hide").css('display','');
	    	$("#contextBody").css('display','');
	    	$("#wf-course").css('height','50%');
	    	$("#wf-course").css('overflow','auto');
		}
	</script>
</head>
<body class="bodyclass">

	<div region="center" title="" id="contextBody" class="mapContext ls">
		<canvas id="canvas" width="1610" height="1010" style="display:block;"></canvas>
	</div>
	
	<div style="height:60%;overflow:auto">

	<div class="timeline-container timeline-style" id="wf-course" style="">
		<button class="wf-btn-primary" id="hide" onclick="hide()" style="float: right;">隐藏</button>
	    <button class="wf-btn-primary" id="show" onclick="show()" style="float: right;display: none;">展开</button>
		<div class="timeline-label animated fadeInDown">
			<span class="label">
			    <img src="${ctx}/assets-common/image/start.png" />
			</span>
		</div>
		<c:forEach items="${list}" var="mainItem" begin="0" varStatus="s" step="1">
	    <div class="timeline-items">
			<div class="timeline-item clearfix">
				<div class="timeline-info">
				    <span class="timeline-name">${mainItem.nodeName }</span><br>
					<span class="timeline-date">${mainItem.applyTime }</span>
					<c:if test="${s.first}">
						<i class="timeline-indicator btn btn-success no-hover">${mainItem.stepIndex}</i>
						<i class="timeline-line timeline-start"></i>
					</c:if>
					<c:if test="${!s.first}">
						<c:if test="${mainItem.isEnd != '1'}">
							<i class="timeline-indicator btn btn-info no-hover">${mainItem.stepIndex}</i>
							<c:if test="${fn:length(mainItem.stepUserList)==1 }">
							<i class="timeline-line"></i>
							</c:if>
							<c:if test="${fn:length(mainItem.stepUserList)>1 }">
							<i class="timeline-minus icon-minus-sign"></i>
							</c:if>
						</c:if>
						<c:if test="${mainItem.isEnd == '1'}">
							<i class="timeline-indicator btn btn-danger no-hover">${mainItem.stepIndex}</i>
					        <span class="label  animated fadeInDown" style="position:absolute;left:160px;top:-40px;">
					            <img src="${ctx}/assets-common/image/end.png" />
					        </span>
							<i class="timeline-line timeline-end"></i>
						</c:if>
					</c:if>
				</div>
	            <div class="widget-box transparent">
	            	<c:if test="${fn:length(mainItem.stepUserList)==1 }">
					<div class="widget-body">
					</c:if>
					<c:if test="${fn:length(mainItem.stepUserList)>1 }">
					<div class="widget-body clearfix">
					</c:if>
					<c:forEach items="${mainItem.stepUserList}" var="item">
						<c:if test="${fn:length(mainItem.stepUserList)==1 }">
						<div class="widget-main no-padding">
						</c:if>
						<c:if test="${fn:length(mainItem.stepUserList)>1 }">
						<div class="widget-main widget-main2 no-padding fl">
						</c:if>
							<div class="widget-left">
								<c:if test="${fn:length(mainItem.stepUserList)>1 }">
								<i class="timeline-line2"></i>
								</c:if>
								<%-- <c:if test="${icons[item.mobileNum] != null}">
								<img src="${icons[item.mobileNum]}" width="100%;"/>
								</c:if> --%>
								<%-- <c:if test="${icons[item.mobileNum] == null}"> --%>
								<img src="${ctx}/assets-common/image/base_avatar.png" width="100%;"/>
								<%-- </c:if> --%>
								<c:if test="${fn:length(mainItem.stepUserList)==1 }">
								<p>${item.userName }</p>
								</c:if>
								<c:if test="${fn:length(mainItem.stepUserList)>1 }">
								<p><c:if test="${item.doType == '1' }"><button type="button" class="btn btn-xs btn-info">主</button></c:if>${item.userName }</p>
								</c:if>
							</div>
				     		<div class="widget-right">
				     		<c:if test="${null != item.receiveTime && '' != item.receiveTime}">
							    <label>接收：</label><span class="timeline-date2">${item.receiveTime}</span><br>
							</c:if>
							<c:if test="${null != item.finishTime && '' != item.finishTime}">
							    <label>办理：</label><span class="timeline-date2">${item.finishTime }</span><br>
							</c:if>
					            <label>状态：</label>
					            <span class="timeline-state">
					            	<c:if test="${item.status=='0' }"><button type="button" class="btn btn-xs btn-state4">废弃过程</button></c:if>
					            	<c:if test="${mainItem.isEnd != '1' && item.status=='1' }"><button type="button" class="btn btn-xs btn-state1">已办理</button></c:if>
					            	<c:if test="${mainItem.isEnd == '1' && item.status=='1' }"><button type="button" class="btn btn-xs btn-state4">已办结</button></c:if>
					            	<c:if test="${item.status=='2' }"><button type="button" class="btn btn-xs btn-state3">未接收</button></c:if>
					            	<c:if test="${item.status=='3' }"><button type="button" class="btn btn-xs btn-state2">办理中</button></c:if>
					            </span>
							</div>	
						</div>
						</c:forEach>
					</div>
				</div>
				<c:if test="${isEnd != '1' ||  !s.last}">
				<div class="timeline-arrow"></div>
				</c:if>
			</div>
		</div>
		</c:forEach>
	</div>
	</div>

	<script>
		$(".timeline-minus").click(function(){ 
		    var sunLength = $(this).closest('.timeline-item').find('.widget-box .widget-main2');
			var item = $(this).closest('.timeline-item');
		    sunLength.each(function(index){
			    if(index>0){
				    if(sunLength.is(":hidden")){
				        sunLength.eq(index).fadeIn("slow");	
		                $('.timeline-minus').removeClass("icon-plus-sign"); 				
		                $('.timeline-minus').addClass("icon-minus-sign");	
						var nHeight = item.height()+10;
		                item.find('.timeline-arrow').css('height',nHeight);					
					}else{
				        sunLength.eq(index).fadeOut("fast");
		                $('.timeline-minus').removeClass("icon-minus-sign"); 				
		                $('.timeline-minus').addClass("icon-plus-sign"); 
						item.find('.timeline-arrow').css('height','110px');			
					}
				}
			});
		});
		
		if(!$('i.timeline-line').hasClass('timeline-end')){
		    $('i.timeline-indicator:last').addClass('timeline-wait');
			$('i.timeline-indicator:last').html('待');
		}
		
		$('.timeline-items .timeline-item').each(function(index){
		    var $this = $(this);
		    var _height = $this.height()+10;
			var _time = (index+1)*1000;
			var _delayTime = index; 
			var _delayTime2 = index+0.4;
			var _delayTime3 = index+0.6;
			$this.find('.timeline-indicator').addClass('animated fadeInDown').attr('style','-webkit-animation-delay:'+_delayTime+'s; animation-delay:'+_delayTime+'s');
			$this.find('.timeline-info').addClass('animated fadeIn').attr('style','-webkit-animation-delay:'+_delayTime2+'s; animation-delay:'+_delayTime2+'s');
			$this.find('.widget-box').addClass('animated fadeIn').attr('style','-webkit-animation-delay:'+_delayTime3+'s; animation-delay:'+_delayTime3+'s');	
			setTimeout(function(){
				$this.find(".timeline-arrow").animate({height:_height});
			},_time);  
		});
		
		function ThirdChat(userId){
			/* var macaddr = document.getElementById("macaddr").value;
			if(macaddr==null || macaddr==''){
				return;
			}
			if(type!=null && type=='0'){
				alert("该人员不在线,只能发送离线消息！");
			}
			var userId = o.id;
			if(macaddr!=null){
				macaddr = macaddr.replaceAll(':','-');
			} */
			//ajax异步调取后台
			$.ajax({
				url: '${ctx}/ztree_ThirdChat.do',
		        type: 'POST',
		        cache: false,
		        async: false,
		        data:{
		        	'userId':userId,'macaddr':$("#macaddr").val()
		        },
		   		error: function(){
		   			 alert('AJAX调用错误');
		   		},
		   		success: function(result){
		   			if(result!=null && result=='unOnline'){
		   				alert("当前人员中威通讯录不在线,请登录");
		   			}
		   		}
			});
		}
	</script>
	<script src="${ctx }/flow/js/jquery-1.6.min.js" type="text/javascript"></script>
	<script src="${ctx }/flow/js/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx }/flow/js/xml2json.min.js?x=2022" type="text/javascript"></script>
	<!-- <script src="${ctx }/flow/js/juicer.min.js" type="text/javascript"></script> -->
	<!-- <script src="${ctx }/flow/js/strawberry.dialog.js?t=2017" type="text/javascript"></script> -->
	<!-- <script src="${ctx }/flow/js/strawberry_show.js?t=2017" type="text/javascript"></script> -->
	<script type="text/javascript" src="${ctx}/flow/js/excanvas.js"></script>
	<script>
		var processes = '${processes}';

		var xml = '${xml}';
		var x2js = new X2JS();
		var json = x2js.xml_str2json(xml);
		
		var jsonData = JSON2.parse(processes);
		var nodeInfoArr = json.flow.flow_seq;
        var lineInfoArr = json.flow.flow_line;
		var canvas,context;
        var lineClickRangeArr = [];
		console.log(jsonData);
        $(document).ready(function(){
            canvas=document.getElementById("canvas");
            context=canvas.getContext("2d");

            for(var i=0;i<jsonData.length;i++){
                var item = getNodeById(jsonData[i].fromNodeId);
                if(item){
                    jsonData[i].fromModeModule = item.id;
                }
            }

            for(var i=0;i<nodeInfoArr.length;i++){
                var item = nodeInfoArr[i];
                console.log(item.id,jsonData[jsonData.length-1].nodemodel);
                if(item.id == jsonData[jsonData.length-1].nodemodel){
                    drawShineNode(item.top,item.left,item.width,item.height,item.nodetype,item.node_name);
                } else {
                    drawNode(item.top,item.left,item.width,item.height,item.nodetype,item.node_name,checkIsGrayNode(item));
                }
            }

            function checkIsGrayNode(item){
                for(var i=0;i<jsonData.length;i++){
                    if(jsonData[i].fromModeModule == item.id){
                        return false;
                    }
                    if(jsonData[i].nodemodel == item.id){
                        return false;
                    }
                }
                return true;
            }

            for(var i=0;i<lineInfoArr.length;i++){
                var item = lineInfoArr[i];
                var startNode = findNode(item.wBaseMode);
                var endNode = findNode(item.xBaseMode);
                lineClickRangeArr.push(null);
                if(startNode && endNode){
                    var lineInfo = findLineInfo(item.wBaseMode,item.xBaseMode);
                    var linePosInfo = getLinePosInfoArr(startNode,endNode,lineInfo);
                    console.log(linePosInfo)
                    item.lineInfo = lineInfo;
                    if(lineInfo.length > 0){

                    }
                    lineClickRangeArr[i] = getClickRange(linePosInfo[0],linePosInfo[1],linePosInfo[2],linePosInfo[3]);
                    drawLine(linePosInfo[0],linePosInfo[1],linePosInfo[2],linePosInfo[3],linePosInfo[4],linePosInfo[5],lineInfo);
                }
            }

            $('#canvas').click(function(e){
                var mouseX = e.offsetX;
                var mouseY = e.offsetY;
                for(var i=0;i<lineClickRangeArr.length;i++){
                    var rangeItem = lineClickRangeArr[i];
                    var info = lineInfoArr[i];
                    var instanceId = window.location.href.split('?')[1].split('=')[1];
                    if(rangeItem && info.lineInfo.length > 0){
                    	var fromNode = findNode(info.lineInfo[0].fromModeModule);
                    	var toNode = findNode(info.lineInfo[0].nodemodel);
                    	
                        if(mouseX > rangeItem[0] && mouseX<rangeItem[2] && mouseY > rangeItem[1] && mouseY < rangeItem[3]){
                            layer.open({
                            			type:2,
                            			area:['700px','450px'],
                            			fixed:false,
                            			content:'${ctx}/table_showInfo.do?instanceId='+instanceId+'&fromNodeId='+fromNode.node_id+'&nodeId='+toNode.node_id,
                            			title:'详情'
                            		})
                            return;
                        } 
                    }
                }
            });

            $('#canvas').mousemove(function(e){
                var mouseX = e.offsetX;
                var mouseY = e.offsetY;
                var showCursor = false;;
                for(var i=0;i<lineClickRangeArr.length;i++){
                    var rangeItem = lineClickRangeArr[i];
                    var info = lineInfoArr[i];
                    if(rangeItem && info.lineInfo.length > 0){
                        if(mouseX > rangeItem[0] && mouseX<rangeItem[2] && mouseY > rangeItem[1] && mouseY < rangeItem[3]){
                            showCursor = true;
                            break;
                        } 
                    }
                }
                if(showCursor){
                    $("#canvas").css({cursor:'pointer'})
                } else {
                    $("#canvas").css({cursor:''})
                }

            })
        })

        function getLinePosInfoArr(startNode,endNode,lineInfos){//获取线条的位置信息
            if(Math.abs(Number(startNode.left)-Number(endNode.left)) < Math.abs(Number(startNode.top) - Number(endNode.top))){
                var topItem = (Number(startNode.top) > Number(endNode.top) ? startNode : endNode);
                var bottomItem = (startNode == topItem ? endNode : startNode);
                var widthArr = [];
                var tisdo=-1;
                for(var i=0;i<lineInfos.length;i++){
                    var fromId = lineInfos[i].fromModeModule;
                    var toId = lineInfos[i].nodemodel;
                    var isdo = lineInfos[i].userInfo[0].isdo;
                    if(topItem.id == toId){
                        if(getIndexOf(widthArr,'t') < 0){
                            widthArr.push('t');
                        }
                    } else if(bottomItem.id == toId){
                        if(getIndexOf(widthArr,'b') < 0){
                            widthArr.push('b');
                        }
                    }
                    if(tisdo != '1'){
                        tisdo = isdo;
                    }
                }
				if(lineInfos.length == 0){
					if(topItem == startNode){
						if(getIndexOf(widthArr,'t')<0){
                            widthArr.push('t');
                        }
					} else {
						if(getIndexOf(widthArr,'b')<0){
                            widthArr.push('b');
                        }
					}
				}
                return [Number(topItem.left)+25,Number(topItem.top),Number(bottomItem.left)+25,Number(bottomItem.top)+50,widthArr,tisdo];
            } else {
                var leftItem = (Number(startNode.left) < Number(endNode.left) ? startNode : endNode);
                var rightItem = (leftItem == startNode ? endNode : startNode);
                var widthArr = [];
                lineInfos[i]
                for(var i=0;i<lineInfos.length;i++){
                    var fromId = lineInfos[i].fromModeModule;
                    var toId = lineInfos[i].nodemodel;
                    var isdo = lineInfos[i].userInfo[0].isdo;
                    if(leftItem.id == toId){
                        if(getIndexOf(widthArr,'r')<0){
                            widthArr.push('r');
                        }
                    } else if(rightItem.id == toId){
                        if(getIndexOf(widthArr,'l')<0){
                            widthArr.push('l');
                        }
                    }
                    if(tisdo != '1'){
                        tisdo = isdo;
                    }
                }
				if(lineInfos.length == 0){
					if(leftItem == startNode){
						if(getIndexOf(widthArr,'l')<0){
                            widthArr.push('l');
                        }
					} else {
						if(getIndexOf(widthArr,'r')<0){
                            widthArr.push('r');
                        }
					}
				}
                return [Number(leftItem.left)+50,Number(leftItem.top)+25,Number(rightItem.left),Number(rightItem.top)+25,widthArr,isdo];
            }

            function getIndexOf(arr,item){
                for(var i=0;i<arr.length;i++){
                    if(arr[i] == item){
                        return i;
                    }
                }
                return -1;
            }
        }

        function getTrianglePosInfo(startX,startY,endX,endY,arrowArr){//获取箭头的类型及位置信息
			//if(arrowArr.indexOf('r') >= 0 || arrowArr.indexOf('l') >= 0)
            //if(Math.abs(Number(startX)-Number(endX)) > Math.abs(Number(startY)-Number(endY))){
			if(arrowArr.indexOf('r') >= 0 || arrowArr.indexOf('l') >= 0){
                var left = startX < endX ? [startX-2,startY-3.5] : [endX-2,endY-3.5];
                var right = startX < endX ? [endX-8,endY-3.5] : [startX-8,startY-3.5];
                return {left:left,right:right};
            } else {
                var top = startY < endY ? [startX-5,startY-2] : [endX-5,endY-2];
                var bottom = startY < endY ? [endX-5,endY-5] : [startX-5,startY-5];
                return {top:top,bottom:bottom};
            }
        }

        function drawLine(startX,startY,endX,endY,arrow,isdo,lineInfo){//画线
            context.restore();
            var strokeColor = getColor(lineInfo);
            context.strokeStyle  = strokeColor;
            context.lineWidth = 2;
            context.beginPath();
            context.moveTo(startX,startY);
            //if(Math.abs(startX-endX) > Math.abs(startY - endY)){
			if(arrow.indexOf('r') >= 0 || arrow.indexOf('l') >= 0){
            	context.lineTo((startX+endX)/2,startY);
            	context.lineTo((startX+endX)/2,endY);
            } else {
            	context.lineTo(startX,(startY+endY)/2);
            	context.lineTo(endX,(startY+endY)/2);
            }
            context.lineTo(endX,endY);
            context.stroke();
            context.closePath();
            context.restore();
            
            drawTriangle(startX,startY,endX,endY,arrow);
            if(lineInfo.length > 0){
                var lineInfoNum = lineInfo.length;
                var tx,ty;
                if(lineInfoNum > 1){
                    if(Math.abs(startX-endX) > Math.abs(startY-endY)){
                        ty = (startY < endY ? startY : endY) - 10;
                        tx = (startX + endX)/2; 
                    } else {
                        tx = (startX < endX ? endX : startX) + 10;
                        ty = (startY + endY)/2; 
                    }
                    context.save();
                    context.font="12px Georgia";
                    context.fillStyle="#333";
                    context.textAlign="center";
                    context.textBaseline = "middle";
                    context.fillText(lineInfoNum,tx,ty);
                    context.restore();
                }
            }

            function getColor(isdo){     
            	if(isdo.length > 0){
            		return '#FF0000'
            	}
                return '#AAAAAA';
            }
        }


        function drawTriangle(startX,startY,endX,endY,arrow){//画箭头
            var trianglePosInfo = getTrianglePosInfo(startX,startY,endX,endY,arrow);
            for(var i=0;i<arrow.length;i++){
                if(arrow[i] == 'r' && trianglePosInfo.right){
                    loadTriangle(trianglePosInfo.right[0],trianglePosInfo.right[1],'${ctx }/flow/images/strawberry/triangle_right.png');
                } else if(arrow[i] == 'l' && trianglePosInfo.left){
                    loadTriangle(trianglePosInfo.left[0],trianglePosInfo.left[1],'${ctx }/flow/images/strawberry/triangle_left.png');
                } else if(arrow[i] == 't' && trianglePosInfo.top){
                    loadTriangle(trianglePosInfo.top[0],trianglePosInfo.top[1],'${ctx }/flow/images/strawberry/triangle_top.png');
                } else if(arrow[i] == 'b' && trianglePosInfo.bottom){
                    loadTriangle(trianglePosInfo.bottom[0],trianglePosInfo.bottom[1],'${ctx }/flow/images/strawberry/triangle_bottom.png');
                }
            }
            if(arrow.length == 0){
                if(trianglePosInfo.right){
                    loadTriangle(trianglePosInfo.right[0],trianglePosInfo.right[1],'${ctx }/flow/images/strawberry/triangle_right_gray.png');
                }
                if(trianglePosInfo.left){
                    loadTriangle(trianglePosInfo.left[0],trianglePosInfo.left[1],'${ctx }/flow/images/strawberry/triangle_left_gray.png');
                }
                if(trianglePosInfo.top){
                    loadTriangle(trianglePosInfo.top[0],trianglePosInfo.top[1],'${ctx }/flow/images/strawberry/triangle_top_gray.png');
                }
                if(trianglePosInfo.bottom){
                    loadTriangle(trianglePosInfo.bottom[0],trianglePosInfo.bottom[1],'${ctx }/flow/images/strawberry/triangle_bottom_gray.png');
                }
            }
            function loadTriangle(x,y,src){
                var img = new Image();
                img.onload = function(){
                    context.drawImage(img,x,y,10,7);
                    context.restore();
                }
                img.src = src;
            }
        }

        function getClickRange(startX,startY,endX,endY){//设置线条的点击范围
            var tstartX = startX < endX ? startX : endX;
            var tendX = startX < endX ? endX : startX;
            var tstartY = startY < endY ? startY : endY;
            var tendY = startY < endY ? endY : startY;
            if(Math.abs(Number(tstartX)-Number(tendX)) < Math.abs(Number(tstartY)-Number(tendY))){
                var dis = Math.abs(Number(tstartX)-Number(tendX));
                dis = dis < 10 ? (10-dis) : 0;
                tstartX = tstartX - dis/2;
                tendX = tendX + dis/2;
                return [tstartX,tstartY,tendX,tendY]
            } else {
                var dis = Math.abs(Number(startY)-Number(endY));
                dis = dis<10 ? (10-dis):0;
                tstartY = tstartY - dis/2;
                tendY = tendY + dis/2;
                return [tstartX,tstartY,tendX,tendY];
            }
        }

        function findNode(id){//根据id查找节点
            for(var i=0;i<nodeInfoArr.length;i++){
                if(nodeInfoArr[i].id == id){
                    return nodeInfoArr[i];
                }
            }
            return null;
        }

        function getNodeById(id){
        	if(id == "first"){
        		for(var i=0;i<nodeInfoArr.length;i++){
                    if(nodeInfoArr[i].nodetype == 'start'){
                        return nodeInfoArr[i];
                    }
                }
        	}
        	if(id == "end"){
        		for(var i=0;i<nodeInfoArr.length;i++){
                    if(nodeInfoArr[i].nodetype == 'end'){
                        return nodeInfoArr[i];
                    }
                }
        	}
            for(var i=0;i<nodeInfoArr.length;i++){
                if(nodeInfoArr[i].node_id == id){
                    return nodeInfoArr[i];
                }
            }
            return null;
        }

        function findLineInfo(node1,node2){
            var arr = [];
            for(var i=0;i<jsonData.length;i++){
                var item = jsonData[i];
                if((item.fromModeModule == node1 && item.nodemodel == node2) ||(item.fromModeModule == node2 && item.nodemodel == node1)){
                    arr.push(item);
                }
            }
            return arr;
        }

        function drawNode(top,left,width,height,type,name,isgray){//画节点
            var img = new Image();
            img.onload = function(){
                context.drawImage(img,left,top,width,height);
                context.restore();
            }
            var src = '';
            if(type == 'end'){
                if(isgray){
                    src = '${ctx }/flow/images/strawberry/app_end-gray.png';
                } else {
                    src = '${ctx }/flow/images/strawberry/app_end.png'
                }
            } else if(type == 'start'){
                src = '${ctx }/flow/images/strawberry/app_start.png';
            } else {
                if(isgray){
                    src = '${ctx }/flow/images/strawberry/app_baseMode5-gray.png'
                } else {
                    src = '${ctx }/flow/images/strawberry/app_baseMode5.png'
                }
            }
            img.src = src;
            if(name){
                context.font="12px Georgia";
                context.fillStyle="#333";
                context.textAlign="center";
                context.textBaseline = "middle";
                context.fillText(name,Number(left)+25,Number(top)+55);
            }
        }

        function drawShineNode(top,left,width,height,type,name){
            var showShadow = true;
            var img = null;
            setInterval(draw,300);

            function draw(){
                if(!img){
                    img = new Image();
                    img.onload = function(){
                        context.drawImage(img,left,top,width,height);
                        context.restore();
                    }
                    img.src = type == 'end' ? '${ctx }/flow/images/strawberry/app_end.png' : (type == 'start' ? '${ctx }/flow/images/strawberry/app_start.png' : '${ctx }/flow/images/strawberry/app_baseMode5.png');
                } else {
                    context.drawImage(img,left,top,width,height);
                    context.restore();
                }
                if(showShadow){
                    var tLeft = Number(left);
                    var tTop = Number(top);
                    context.restore();
                    context.beginPath();
                    context.moveTo(tLeft+6,tTop+6);
                    context.lineTo(tLeft+44,tTop+6);
                    context.lineTo(tLeft+44,tTop+44);
                    context.lineTo(tLeft+6,tTop+44);
                    context.lineTo(tLeft+6,tTop+6);
                    context.closePath();
                    context.strokeStyle = '#FF0000';
                    context.lineWidth = 3;
                    context.stroke();
                    context.restore();
                }

                showShadow = !showShadow;
            }

            if(name){
                context.font="12px Georgia";
                context.fillStyle="#333";
                context.textAlign="center";
                context.textBaseline = "middle";
                context.fillText(name,Number(left)+25,Number(top)+55);
            }
        }
		
		// Changes XML to JSON
		function xmlToJson(xml) {

		  // Create the return object
		  var obj = {};

		  if (xml.nodeType == 1) { // element
		    // do attributes
		    if (xml.attributes.length > 0) {
		      obj["@attributes"] = {};
		      for (var j = 0; j < xml.attributes.length; j++) {
		        var attribute = xml.attributes.item(j);
		        obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
		      }
		    }
		  } else if (xml.nodeType == 3) { // text
		    obj = xml.nodeValue;
		  }

		  // do children
		  if (xml.hasChildNodes()) {
		    for (var i = 0; i < xml.childNodes.length; i++) {
		      var item = xml.childNodes.item(i);
		      var nodeName = item.nodeName;
		      if (typeof (obj[nodeName]) == "undefined") {
		        obj[nodeName] = xmlToJson(item);
		      } else {
		        if (typeof (obj[nodeName].length) == "undefined") {
		          var old = obj[nodeName];
		          obj[nodeName] = [];
		          obj[nodeName].push(old);
		        }
		        obj[nodeName].push(xmlToJson(item));
		      }
		    }
		  }
		  return obj;
		};
    </script>  	
</body>
</html>