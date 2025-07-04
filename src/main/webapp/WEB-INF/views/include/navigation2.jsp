<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<%
	if(com.sist.web.util.CookieUtil.getCookie(request, 
	  (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
<nav class="navbar navbar-expand-sm bg-secondary navbar-dark mb-3"> 
	<ul class="navbar-nav"> 
	    <li class="nav-item"> 
	      <a class="nav-link" href="/seller/loginOut"> 로그아웃</a> 
	    </li> 
	    <li class="nav-item"> 
	      <a class="nav-link" href="/seller/sellerUpdateForm">판매자정보수정</a> 
	    </li> 
	    <li class="nav-item"> 
	      <a class="nav-link" href="/seller/sellerPasswordForm">패스워드변경</a> 
	    </li> 
	    <li class="nav-item"> 
	      <a class="nav-link" href="/seller/pay">카카오페이</a> 
	    </li> 	    
  </ul> 
</nav>
<%
	}
	else
	{
%>
<nav class="navbar navbar-expand-sm bg-secondary navbar-dark mb-3"> 
	<ul class="navbar-nav"> 
	    <li class="nav-item"> 
	      <a class="nav-link" href="/seller/login"> 로그인</a> 
	    </li> 
	    <li class="nav-item"> 
	      <a class="nav-link" href="/seller/sellerRegForm">판매자가입</a> 
	    </li> 
  </ul> 
</nav>
<%
	}
%>