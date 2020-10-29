<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My SNS</title>
<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js" ></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	$(function() {
		$("#accordion").accordion({
			heightStyle : "content",
			active : parseInt("${curmsg == null ? 0:curmsg}")
		});
	});

	function newuser() {
		window
				.open(
						"new_user.jsp",
						"newuser",
						"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=500,height=240");
	}
	function newfriend() { // 추가한 내용: 친구 추가 창 추가 , 검색으로 친구 찾아서 user id가 존재하면 친구 추가해주기  
		window
				.open(
						"newfriend.jsp",
						"newfreind",
						"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=500,height=240");
	}
	function management() { // 추가한 내용: 관리자가 유저들의 정보를 볼 수 있는 창 추가  
		pwd = prompt('관리자 비밀번호를 입력해주세요 ');
		if(pwd=='1234'){ // 관리자 비밀번호가 1234 라고 가정하고 관리자만 접근할 수 있도록 한다.  
			window
			.open(
					"management.jsp",
					"management",
					"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=500,height=240");
		}

			}		
	function del_user() { // 추가한 내용: 회원 탈퇴
			window
			.open(
					"del_user.jsp",
					"del_user",
					"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=500,height=240");
		}

</script>
</head>

<body>
	<header>
		<div class="container1">
			<h1 class="fontface" id="title">My SNS<img src="img\jihyun.png" width="90px" height="45px" alt="로고"></h1>
		</div>
	</header>
	
	<nav>
		<div class="menu">
			<ul>
				<li><a href="#">Home</a></li>
				<li><a href="javascript:newuser()">New User</a></li>
				<li><a href="javascript:newfriend()">친구 추가 </a></li>
				<li><a href="sns_control.jsp?action=getall">전체글보기</a>
				<li><sns:login /></li>
			</ul>
		</div>
	</nav>

	<div id="wrapper">
		<section id="main">
			<section id="content">
				<b>내소식 업데이트</b>
				<form class="m_form" method="post" action="sns_control.jsp?action=newmsg">
					<input type="hidden" name="uid" value="${uid}">
					<sns:write type="msg"/>
					<button class="submit" type="submit">등록</button>
				</form>
				<br>
				<br>
				<h3>친구들의 최신 소식</h3>
				<div id="accordion">
					<c:forEach varStatus="mcnt" var="msgs" items="${datas}">
					<c:set var="m" value="${msgs.message}"/>
					<h3>[${m.uid}]<br/>${m.msg}<br/> [좋아요 ${m.favcount} | 댓글 ${m.replycount}]</h3>
					<div>
						<p><sns:smenu mid="${m.mid}" auid="${m.uid}" curmsg="${mcnt.index}"/>/ ${m.date}에 작성된 글입니다.</p>
						<ul class="reply">
						<c:forEach  var="r" items="${msgs.rlist}">
							<li>${r.uid } :: ${r.rmsg} [${r.date}]<sns:rmenu curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}"/></li>
						</c:forEach>
						</ul>
	
						<form action="sns_control.jsp?action=newreply&cnt=${cnt}" method="post">
							<input type="hidden" name="mid" value="${m.mid}">
							<input type="hidden" name="uid" value="${uid}">
							<input type="hidden" name="suid" value="${suid}">
							<input type="hidden" name="curmsg" value="${mcnt.index}">				
							<sns:write type="rmsg"/>
						</form>
					</div>
					</c:forEach>
				</div>
				<div align="center"><a href="sns_control.jsp?action=getall&cnt=${cnt+5}&suid=${suid}">더보기&gt;&gt;</a></div>
			</section>
			<aside id="sidebar2">
				<h2>새로운  친구들</h2>
				<c:forEach items="${nusers}" var="n">
					<ul>
						<li><a href="sns_control.jsp?action=getall&suid=${n}">${n}</a></li>
					</ul>
				</c:forEach>
				<br>
				<h2>추가된 친구</h2>
				<c:forEach items="${nfriends}" var="nf">
					<ul>
						<li><a href="sns_control.jsp?action=getall&suid=${nf}">${nf}</a></li>
					</ul>
				</c:forEach>
				<br>
				<h2>Links</h2>
				<ul>
					<li><a href="https://www.duksung.ac.kr/main.do">덕성여자대학교</a></li>
					<li><a href="http://www.duksung.ac.kr/computer/">컴퓨터공학과</a></li>
					<li><a href="javascript:management()">사용자 관리 </a></li>
					<li><a href="javascript:del_user()">회원탈퇴</a>
				</ul>
				<br> <br>
				<img src="img/facebook_32.png" style="margin-left: 35px" width="28px" height="28px"> 
				<img src="img/twitter_32.png" width="28px" height="28px">
				<img src="img/youtube_32.png" width="28px" height="28px"> <br> <br>
				<br> <br>
			</aside>
		</section>
	</div>

	<footer>
		<div class="container1">
			<section id="footer-area">
			<section id="footer-outer-block">
					<aside class="footer-segment">
							<h4>About</h4>
								<ul>
									<li><a href="#">About My SNS</a></li>
									<li><a href="#">Copyright</a></li>
									<li><a href="#">Author</a></li>
								</ul>
					</aside>

					<aside class="footer-segment">
							<h4>Java Web Programming</h4>
								<ul>
									<li><a href="#">Information</a></li>
									<li><a href="#">Table of contents</a></li>
									<li><a href="#">Book History</a></li>
								</ul>
					</aside>

					<aside class="footer-segment">
							<h4>Contact Us</h4>
								<ul>
									<li><a href="#">Book Support</a></li>
									<li><a href="#">Publication</a></li>
									<li><a href="#">Investor
									 Relations</a></li>
									</ul>
					</aside>
					<aside class="footer-segment">
							<h4>Ji Hyun Song</h4>
								<p>&copy; 2020 <a href="#">www.duksung.ac.kr</a> </p>
					</aside>
				</section>
			</section>
		</div>
	</footer>
</body>
</html>