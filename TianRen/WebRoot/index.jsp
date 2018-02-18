<%@ page language="java" import="java.util.*,java.sql.Connection,
 java.sql.DriverManager,
java.sql.SQLException,
 java.sql.Statement,java.sql.ResultSet" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<base href="<%=basePath%>">

<title>美团电影 首页</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter"
	content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit"
	content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/index.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	function clickButton(movieName) {
		location = "play!showOneMoviePlaies.action?movieName="
				+ encodeURI(movieName);
	}
	
</script>

</head>

<body>

	<s:if test="!#session.cookieFlag">
		<script>
			location = "member!prepareLogin.action";
		</script>
	</s:if>
	<s:if
		test="#request.beforeMovieByPage==null||#request.afterMovieByPage==null">
		<script>
			location = "movie!showBeforeAndAfterMovieByPageOnIndex.action";
		</script>
	</s:if>
	<div id="header">
		<s:include value="head.jsp" />
	</div>
	<div id="main">
		<%--<div id="main_top">
			<s:iterator var="ad" value="#application.lstAd">
				<s:if test="#ad.adId==2">
					<a href="%{#ad.adHref}"> <s:generator separator=","
							val="#ad.adImg">
							<s:iterator>
								<img src='<s:property />' border="0" width="1000" />
							</s:iterator>
						</s:generator> </a>
				</s:if>
			</s:iterator>
		</div>--%>
		<div id="main_left">
			<div id="main_left_top">

				<s:iterator var="ad" value="#application.lstAd">
					<s:if test="#ad.adId==10">
						<s:hidden id="ad1Img" value="%{#ad.adImg}" />
						<s:hidden id="ad1Href" value="%{#ad.adHref}" />
					</s:if>
					<s:if test="#ad.adId==11">
						<s:hidden id="ad2Img" value="%{#ad.adImg}" />
						<s:hidden id="ad2Href" value="%{#ad.adHref}" />
					</s:if>
					<s:if test="#ad.adId==12">
						<s:hidden id="ad3Img" value="%{#ad.adImg}" />
						<s:hidden id="ad3Href" value="%{#ad.adHref}" />
					</s:if>
					<s:if test="#ad.adId==13">
						<s:hidden id="ad4Img" value="%{#ad.adImg}" />
						<s:hidden id="ad4Href" value="%{#ad.adHref}" />
					</s:if>
				</s:iterator>

			</div>

			<div id="main_left_middle">
				<div id="TabbedPanels1" class="TabbedPanels">
					<ul class="TabbedPanelsTabGroup">
						<li class="TabbedPanelsTab" tabindex="0">正在热播</li>
						<li class="TabbedPanelsTab" tabindex="0">即将上映</li>
					</ul>
					<div class="TabbedPanelsContentGroup">
						<div class="TabbedPanelsContent" style="width:100%;height:auto;">
							<s:iterator var="movie" value="#request.beforeMovieByPage.data">
								<ul class="main_left_middle_ul">
									<li><s:a action="play" method="showOneMoviePlaies">
											<s:param name="movieName" value="#movie.movieName" />
											<s:generator separator="," val="#movie.moviePhoto">
												<s:iterator>
													<img src='<s:property />' border="0" width="160px" />
												</s:iterator>
											</s:generator>
										</s:a>
									</li>
									<li><b> <s:a action="play" method="showOneMoviePlaies">
												<s:param name="movieName" value="#movie.movieName" />
												<s:property value="#movie.movieName" />
											</s:a> </b>
									</li>
									<li><b> <s:date name="#movie.movieDate"
												format="yyyy年MM月dd日" /> </b>
									</li>
									<li><s:property
											value="#movie.movieInfo.substring(0,30)+'...'" />
									</li>
									<li><s:property value="#movie.movieActor" />
									</li>
									<li><input type="button" value="想看"
										onclick="clickButton('<s:property value="%{#movie.movieName}"/>')"
										style="float:left;" />
									</li>
									<li><input type="button" value="我要购票"
										onclick="clickButton('<s:property value="%{#movie.movieName}"/>')"
										style="float:right;" />
									</li>
								</ul>
							</s:iterator>
						</div>
						<div class="TabbedPanelsContent" style="width:100%;height:auto;">
							<s:iterator var="movie" value="#request.afterMovieByPage.data">
								<ul class="main_left_middle_ul">
									<li><s:a action="play" method="showOneMoviePlaies">
											<s:param name="movieName" value="#movie.movieName" />
											<s:generator separator="," val="#movie.moviePhoto">
												<s:iterator>
													<img src='<s:property />' border="0" width="160px" />
												</s:iterator>
											</s:generator>
										</s:a>
									</li>
									<li><b> <s:a action="play" method="showOneMoviePlaies">
												<s:param name="movieName" value="#movie.movieName" />
												<s:property value="#movie.movieName" />
											</s:a> </b>
									</li>
									<li><b> <s:date name="#movie.movieDate"
												format="yyyy年MM月dd日" /> </b>
									</li>
									<li><s:property
											value="#movie.movieInfo.substring(0,30)+'...'" />
									</li>
									<li><s:property value="#movie.movieActor" />
									</li>
									<li><input type="button" value="想看"
										onclick="clickButton('<s:property value="%{#movie.movieName}"/>')"
										style="float:left;" />
									</li>
									<li><input type="button" value="我要购票"
										onclick="clickButton('<s:property value="%{#movie.movieName}"/>')"
										style="float:right;" />
									</li>
								</ul>
							</s:iterator>
						</div>
					</div>
				</div>
			</div>

			<div id="main_left_bottom">
				<s:iterator var="ad" value="#application.lstAd">
					<s:if test="#ad.adId==3">
						<s:a href="%{#ad.adHref}">
							<s:generator separator="," val="#ad.adImg">
								<s:iterator>
									<img src='<s:property />' border="0" width="760" />
								</s:iterator>
							</s:generator>
						</s:a>
					</s:if>
				</s:iterator>
			</div>

		</div>

		<div id="main_right">
			<s:include value="right.jsp"></s:include>
		</div>

		<div id="main_bottom">
			<s:iterator var="ad" value="#application.lstAd">
				<s:if test="#ad.adId==4">
					<s:a href="%{#ad.adHref}">
						<s:generator separator="," val="#ad.adImg">
							<s:iterator>
								<img src='<s:property />' border="0" />
							</s:iterator>
						</s:generator>
					</s:a>
				</s:if>
			</s:iterator>
		</div>
	</div>
	<div id="footer">
		<s:include value="foot.jsp"></s:include>
	</div>

	<script type="text/javascript">
	<!--
		var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
	//-->
	</script>
</body>
</html>
