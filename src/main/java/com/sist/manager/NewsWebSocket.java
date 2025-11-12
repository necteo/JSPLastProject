package com.sist.manager;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/news")
public class NewsWebSocket {
	// 접속자 정보 => 저장
	private static Set<Session> clients = ConcurrentHashMap.newKeySet();
	// 스케쥴러
	private static ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
	
	static {
		scheduler.scheduleAtFixedRate(() -> {
			try {
				String news = NewsManager.newsSearch("맛집");
				// news 전송
				broadcast(news);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}, 0, 60, TimeUnit.SECONDS); // 1분마다 새뉴스 전송
	}
	
	// 접속시 처리
	@OnOpen
	public void onOpen(Session session) {
		clients.add(session);
		System.out.println("클라리언트 연결:" + session.getId());
	}
	// 접속 종료
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("연결 종료:" + session.getId());
	}
	// 메세지 전송
	@OnMessage
	public void OnMessage(String msg, Session session) {
		System.out.println("클라이언트 메세지:" + msg);
	}
	
	private static void broadcast(String message) {
		for (Session session : clients) {
			if (session.isOpen()) {
				try {
					session.getBasicRemote().sendText(message);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
