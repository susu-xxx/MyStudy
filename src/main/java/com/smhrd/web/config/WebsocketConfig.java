package com.smhrd.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration //환경설정 파잃 spring container가 생성할 수 있게끔 추가
@EnableWebSocket // 웹소켓 활성화시킬거야
public class WebsocketConfig implements WebSocketConfigurer{
	//우리가 직접 컨테이너가 관리할 수 있게끔
	
	//웹소켓 핸들러를 빈 형태로 생성해서 
	//웹소켓 핸들러를 관리하는 레지스트리에 추가

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		registry.addHandler(webSocketHandler(), "/websocket").setAllowedOrigins("*");
		
		
	}
	
	@Bean
	public WebSocketHandler webSocketHandler() {
		return new WebSocketHandler();
	}

}
