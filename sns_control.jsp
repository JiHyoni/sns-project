<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="mysns.sns.*,mysns.member.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="msg" class="mysns.sns.Message" />
<jsp:useBean id="msgdao" class="mysns.sns.MessageDAO" />
<jsp:useBean id="reply" class="mysns.sns.Reply" />

<jsp:setProperty name="msg" property="*" />
<jsp:setProperty name="reply" property="*" />

<%
	String action = request.getParameter("action"); 
	String cnt = request.getParameter("cnt"); 
	String suid = request.getParameter("suid"); 
	String home;

	int mcnt; 
	
	if((cnt != null) && (suid !=null)) {
		home = "sns_control.jsp?action=getall&cnt="+cnt+"&suid="+suid;
		mcnt = Integer.parseInt(request.getParameter("cnt"));
	}
	else {
		home = "sns_control.jsp?action=getall";
		mcnt = 5;
	}
	
	request.setAttribute("curmsg", request.getParameter("curmsg"));

	if (action.equals("newmsg")) {
		if (msgdao.newMsg(msg))
			response.sendRedirect(home);
		else
			throw new Exception("메시지 등록 오류!!");

	} else if (action.equals("newreply")) {
		if (msgdao.newReply(reply))
			pageContext.forward(home);
		else
			throw new Exception("댓글 등록 오류!!");
	} 
	else if (action.equals("delmsg")) { 
		if(msgdao.delMsg(msg.getMid())) 
			response.sendRedirect(home);			
		else
			throw new Exception("메시지 등록 오류!!");
	} 
	
	else if (action.equals("delreply")) {	
		if(msgdao.delReply(reply.getRid())) {
			pageContext.forward(home);
		}
		else
			throw new Exception("메시지 등록 오류!!");
	} 

	else if (action.equals("getall")) {	
		ArrayList<MessageSet> datas = msgdao.getAll(mcnt,suid);
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		ArrayList<String> nfriends = new MemberDAO().getNewFriends(); // 추가 ) 친구 목록 불러오기 
		request.setAttribute("datas", datas);		
		request.setAttribute("nusers", nusers);	   
		request.setAttribute("nfriends",nfriends); // 추가) 추가한 친구 목록 
		request.setAttribute("suid",suid);   
		request.setAttribute("cnt",mcnt);    
		pageContext.forward("sns_main.jsp");
	}
	
	else if(action.equals("fav")) { 
		msgdao.favorite(msg.getMid());
		pageContext.forward(home);
	}
%>
