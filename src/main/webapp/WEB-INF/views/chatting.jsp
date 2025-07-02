<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.ChatWrapper {
   width: 100%;
   height: 100%;
}

#Chatting {
   width: 60%;
   height: 400px;
   border : 1px solid gray;
}

#Chatting-send{
   width: 60%;
}
.content {
   width: 100%;
   height: 5%;
}
.my{
   text-align : right;
}
.others{
   text-align : left;
}
</style>

</head>
<body>

   <div class="container">
      <h2>WebSocket Chatting</h2>
      <div class="panel panel-default">
         <div class="panel-heading">채팅구현하기</div>
         <div class="panel-body" align="center">
         
            <div class="ChatWrapper">
               <div id="Chatting">
               </div>
               
               <br>
               
               <div id = "Chatting-send">
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="nickname">닉네임:</label>
                     <div class="col-sm-8">
                        <input type="email" class="form-control" id="nickname"
                           placeholder="닉네임입력" name="nickname">
                     </div>
                     <button id="eCheck" class="btn btn-success col-sm-2">닉네임확정</button>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="content">메시지:</label>
                     <div class="col-sm-8">
                        <textarea placeholder="메시지입력" rows="5" class="form-control" id="content" name="content"></textarea>
                     </div>
                  </div>
                  <div class="form-group">
                     <button class="btn btn-info col-sm-2" id="sendMsg" disabled>전송</button>                  
                  </div>
               </div>

            </div>

         </div>
         <div class="panel-footer">데이터분석 SW엔지니어 양성과정 - 신재영<div>
      </div>
   </div>
   </div>
   </div>
   <script>
   let websocket;
   	//websocket 열어주기 
   	//1. 닉네임을 입력하고 닉네임 확정 버튼을 누르면 동작하는 함수
   	$("#eCheck").on("click",function(){
   		
   	
   	//2. 입력한 닉네임을 가져오기
   	let nickname = $("#nickname").val();
   	//3. 입력한 닉네임이 null이 아니라며ㄴ, 닉네임 확정버튼을 비활성화하고 소켓을 열어주기
   	if (nickname != null){
   		$("#nickname").attr("readonly","readonly");
   		$(this).attr("disabled","disabled");
   		
   		//웹소켓 열어주기
   		let wsUri = "ws://127.0.0.1:8090/web/websocket";
   		websocket = new WebSocket(wsUri);
   		console.log("웹소켓>>", websocket);
   		
   		//1. 전송 버튼을 활성화 해주기 
   		$("#sendMsg").removeAttr("disabled");
   		
   		//2. 전송 버튼을 누르면 textarea에 입력된 글자를 가져오기
   		$("#sendMsg").on("click", function(){
   		//3. 메시지 전송 
   		let content = $("#content").val();
		websocket.send(content);   			
   		});
   		
   		
   		/////////////////////////////////////////////////////////////////////////////////
   		//웹소켓이 열렸을 때 실행할 함수
   		websocket.onopen = function(){
   			console.log("웹소켓 연결");
   		}
   		//웹소켓이 닫혔을 때 실행할 함수
   		websocket.onclose = function(){
   			console.log("웹소켓 종료");
   		}
   		
   		//메세지가 도착했을 때 실행할 함수
   		websocket.onmessage = function(msg){
   			console.log("받아온 데이터 >>" + msg);
   			$("#Chatting").append(`<div>\${msg.data}</div>`);
   		}
   		
   	}
   	})
   	
   </script>
   

</body>
</html>
