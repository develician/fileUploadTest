<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: paul
  Date: 2017. 10. 14.
  Time: PM 3:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%

    String savePath = request.getServletContext().getRealPath("upload");
    int sizeLimit = 10 * 1024 * 1024;

    try {
        MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
        String fileName = multi.getFilesystemName("upfile");
        String originalFileName = multi.getOriginalFileName("upfile");

        if (fileName == null) {


%>
<h2>File has not been uploaded.</h2>
<br>
<a href="javascript:history.back()">Re Upload</a>
<%
} else {
    File file1 = multi.getFile("upfile");
    String division = multi.getParameter("division");
    String contents = multi.getParameter("contents");


%>

<h2>Success for file uploading!</h2>
Saved File Name :  <%=fileName%> <br>
File name before changing : <%=originalFileName%> <br>
Type : <%=getDivisionName(division)%>
Description : <%=contents%><br>
Size : <%=file1.length()%> <br>
ContentType : <%=multi.getContentType("upfile")%> <br>


<%
        }
    } catch (IOException e) {
        out.print("<h2> IOException 이 발생했습니다 </h2> <BR><pre>" + e.getMessage() + "</pre>");
    }
%>


</body>
</html>

<%!
    public String getDivisionName(String division) {
        String divisionName = "";
        try {
            if (division.equals("game")) {
                divisionName = "Game";
            } else if (division.equals("util")) {
                divisionName = "Utility";
            } else if (division.equals("doc")) {
                divisionName = "Document";
            } else if (division.equals("movie")) {
                divisionName = "Movie";
            } else if (division.equals("music")) {
                divisionName = "Music";
            } else if (divisionName.equals("etc")) {
                divisionName = "ETC";
            }
        } catch (Exception e) {
            divisionName = "ETC";
        }

        return divisionName;

    }
%>