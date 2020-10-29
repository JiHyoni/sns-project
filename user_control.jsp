<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
import="mysns.sns.*,mysns.member.*,java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="member" class="mysns.member.Member" />
<jsp:setProperty name="member" property="*" />
<jsp:useBean id="mdao" class="mysns.member.MemberDAO" />
<jsp:useBean id="friend" class="mysns.member.Friend" />
<jsp:setProperty name="friend" property="*" />

<%
	String action = request.getParameter("action");

	if(action.equals("new")) {
		if(mdao.addMember(member))
			out.println("<script>alert('정상적으로 등록 되었습니다. 로그인 하세요!!');opener.window.location.reload();window.close();</script>");
		else
			out.println("<script>alert('같은 아이디가 존재 합니다!!');history.go(-1);</script>");
	}

	else if(action.equals("login")) {
		if(mdao.login(member.getUid(),member.getPasswd())) {
			session.setAttribute("uid",member.getUid());
			response.sendRedirect("sns_control.jsp?action=getall");
		}
		else {
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다!');history.go(-1);</script>");
		}
	} 
	
	// 추가 내용 ) 친구추가 
	else if(action.equals("newfriend")){
		if(mdao.searchMember(member.getUid())){ //아이디가 존재 한다면  
			mdao.addFriend(member.getUid()); //친구 테이블에 아이디 추가해주기
			out.println("<script>alert('친구 추가 되었습니다!');opener.window.location.reload();window.close();</script>");
		}
		else{
			out.println("<script>alert('존재하지 않는 아이디 입니다!');history.go(-1);</script>");
			}
	}
	// 추가 내용 ) 회원 탈퇴 
	else if(action.equals("del")) {
			if(mdao.login(member.getUid(),member.getPasswd())){ //로그인 인증이 된다면 회원탈퇴 가능하도록
				mdao.delMember(member.getUid()); 
				out.println("<script>alert('정상적으로 탈퇴 되었습니다. 이용해주셔서 감사합니다 :)');opener.window.location.reload();window.close();</script>");
				session.removeAttribute("uid");
			}	

		else
			out.println("<script>alert('회원탈퇴 오류! 아이디나 비밀번호를 확인해주세요.');history.go(-1);</script>");
	}
	
	else if(action.equals("logout")) {
		session.removeAttribute("uid");
		response.sendRedirect("sns_control.jsp?action=getall");		
	}
%>