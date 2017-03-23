<%--
  Created by IntelliJ IDEA.
  User: Linda
  Date: 3/23/2017
  Time: 10:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>新增</title>
</head>
<body>
<form method="post" action="<c:url value="/user.html"/>">
    <table>
        <tr><td>用户名:</td><td><input type="text" name="userName" value="请输入用户名"></td></tr>
        <tr><td>密码  :</td><td><input type="password" name="password"></td></tr>
        <tr><td colspan="2"><input type="submit" value="注册"></td></tr>
    </table>
</form>
</body>
</html>
