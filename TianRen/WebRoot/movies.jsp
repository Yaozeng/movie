<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

<title>美团电影</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Page-Enter" content="revealTrans(duration=5, transition=23)">
<meta http-equiv="Page-Exit" content="revealTrans(duration=5, transition=23)">

<link href="styles/global.css" type="text/css" rel="stylesheet" />
<link href="styles/movies.css" type="text/css" rel="stylesheet" />
<link href="styles/head.css" type="text/css" rel="stylesheet" />
<link href="styles/right.css" type="text/css" rel="stylesheet" />
<link href="styles/foot.css" type="text/css" rel="stylesheet" />
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet"
	type="text/css" />
	
<script type="text/javascript" src="/TianRen/scripts/jquery-1.7.2.js"></script>
<script type="text/javascript" src="/TianRen/scripts/global.js"></script>

<script type="text/javascript">
	function showJson(currentPage, flag) {
		//(1) : xmlhttp 的创建
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		//(2) : 指定交互路径	
		var url;
		if (flag == 1) {
			url = "movie!findBeforeByPageByJson.action?beforeCurrentPage="
					+ currentPage;
		} else {
			url = "movie!findAfterByPageByJson.action?afterCurrentPage="
					+ currentPage;
		}

		xmlhttp.open("post", url, true);
		//(3) : 指定回调函数
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var json_data = eval('(' + xmlhttp.responseText + ')'); // 获取Json 数据

				if (json_data != null && json_data[0].data.length > 0) { // 确保数据有效性
					//获取层
					var show_json = document.getElementById("json" + flag);
					if (show_json.firstChild != null) {
						show_json.removeChild(show_json.firstChild);
					}
					var div = document.createElement("div");

					for ( var i = 0; i < json_data[0].data.length; i++) {
						var ul = document.createElement("ul");
						ul.style.height = 360;
						ul.style.width = 165;
						ul.style.styleFloat = "left";
						ul.style.cssFloat = "left";
						ul.style.margin = "15px 8px";

						//电影照片
						var li1 = document.createElement("li");
						li1.style.margin = "5px 0px";

						var aMoviePhoto = document.createElement("a");
						aMoviePhoto.href = "play!showOneMoviePlaies.action?movieName="
								+ json_data[0].data[i].movieName;

						var img = document.createElement("img");
						img.src = json_data[0].data[i].moviePhoto;
						img.height = 160 * img.height / img.width;
						img.width = 160;

						aMoviePhoto.appendChild(img);
						li1.appendChild(aMoviePhoto);
						ul.appendChild(li1);

						//电影名称
						var li2 = document.createElement("li");
						li2.style.margin = "5px 0px";

						var aMovieName = document.createElement("a");
						aMovieName.href = "play!showOneMoviePlaies.action?movieName="
								+ json_data[0].data[i].movieName;
						aMovieName.style.fontWeight = "bold";
						var movieName = document
								.createTextNode(json_data[0].data[i].movieName);
						aMovieName.appendChild(movieName);
						li2.appendChild(aMovieName);
						ul.appendChild(li2);

						//上映时间
						var li3 = document.createElement("li");
						li3.style.margin = "5px 0px";
						var bMovieDate = document.createElement("b");
						var movieDate = document
								.createTextNode(json_data[0].data[i].movieDate);
						bMovieDate.appendChild(movieDate);
						li3.appendChild(bMovieDate);
						ul.appendChild(li3);

						//电影信息
						var li4 = document.createElement("li");
						li4.style.margin = "5px 0px";
						var movieInfo = document
								.createTextNode(json_data[0].data[i].movieInfo
										.substring(0, 30)
										+ "...");
						li4.appendChild(movieInfo);
						ul.appendChild(li4);

						//电影演员
						var li5 = document.createElement("li");
						li5.style.margin = "5px 0px";
						var movieActor = document
								.createTextNode(json_data[0].data[i].movieActor);
						li5.appendChild(movieActor);
						ul.appendChild(li5);

						//我要购票
						var li6 = document.createElement("li");
						li6.style.margin = "5px 0px";

						var a = document.createElement("a");
						a.style.styleFloat = "right";
						a.style.cssFloat = "right";
						a.href = "play!showOneMoviePlaies.action?movieName="
								+ encodeURI(json_data[0].data[i].movieName);
						var word = document.createTextNode("我要购票");

						a.appendChild(word);
						li6.appendChild(a);
						ul.appendChild(li6);

						div.appendChild(ul);
					}

					var divPage = document.createElement("div");
					divPage.style.textAlign = "center";
					divPage.style.clear = "both";

					if (json_data[0].currentPage != 1) {
						var aPrevious = document.createElement("a");
						aPrevious.style.cursor = "hand";
						aPrevious.style.marginRight = "5px";
						aPrevious.onclick = function() {
							showJson(json_data[0].currentPage - 1, flag);
						};
						var wordPrevious = document.createTextNode("前一页");
						aPrevious.appendChild(wordPrevious);
						divPage.appendChild(aPrevious);
					}
					//for ( var i = 1; i <= json_data[0].totalPages; i++) {
					//	if (i == json_data[0].currentPage) {
					//		var bCurrentPage = document.createElement("b");
					//		bCurrentPage.style.color = "red";
					//		bCurrentPage.style.marginRight = "5px";
					//		var wordCurrentPage = document.createTextNode(i);
					//		bCurrentPage.appendChild(wordCurrentPage);
					//		divPage.appendChild(bCurrentPage);
					//	} else {
					//		var aCurrentPage = document.createElement("a");
					//		aCurrentPage.style.marginRight = "5px";
					//		aCurrentPage.style.cursor = "hand";
					//		aCurrentPage.onclick = function() {
					//			showJson(i,flag);
					//		};
					//		var wordCurrentPage = document.createTextNode(i);
					//		aCurrentPage.appendChild(wordCurrentPage);
					//		divPage.appendChild(aCurrentPage);
					//	}
					//}
					if (json_data[0].currentPage != json_data[0].totalPages) {
						var aNext = document.createElement("a");
						aNext.style.marginRight = "5px";
						aNext.style.cursor = "hand";
						aNext.onclick = function() {
							showJson(json_data[0].currentPage + 1, flag);
						};
						var wordNext = document.createTextNode("后一页");
						aNext.appendChild(wordNext);
						divPage.appendChild(aNext);
					}
					div.appendChild(divPage);

					show_json.appendChild(div);
				}
			}
		};
		//(4) : 开始交互 ， 发送请求
		xmlhttp.send();
	}
</script>
</head>

<body>
	<s:if
		test="#request.beforeMovieByPage==null||#request.afterMovieByPage==null">
		<script>
			location = "movie!showBeforeAndAfterMovieByPageOnMovies.action";
		</script>
	</s:if>
	<div id="header">
		<s:include value="head.jsp"></s:include>
	</div>
	<div id="main">
		<div id="main_top">
			<a href="index.jsp" class="aToptxt">首页</a>
			&nbsp;&gt;&nbsp;
			<a href="movies.jsp" class="aToptxt">电影</a>
		</div>
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
						<div class="TabbedPanelsContent" id="json1" style="width:100%;height:auto;">
							<div>
								<s:iterator var="movie" value="#request.beforeMovieByPage.data">
									<ul class="main_left_middle_ul" style="height: 360px;">
										<li><s:a action="play" method="showOneMoviePlaies">
												<s:param name="movieName" value="#movie.movieName" />
												<s:generator separator="," val="#movie.moviePhoto">
													<s:iterator>
														<img src='<s:property />' border="0" width="160px" />
													</s:iterator>
												</s:generator>
											</s:a>
										</li>
										<li><b> <s:a action="play"
													method="showOneMoviePlaies">
													<s:param name="movieName" value="#movie.movieName" />
													<s:property value="#movie.movieName" />
												</s:a> </b>
										</li>
										<li><b> <s:date name="#movie.movieDate"
													format="yyyy年MM月dd日" /> </b>
										</li>
										<li><s:property
												value="#movie.movieInfo" />
										</li>
										<li><s:property value="#movie.movieActor" />
										</li>
										<li><s:a action="play" method="showOneMoviePlaies"
												style="float:left; padding:1px;">
												<s:param name="movieName" value="#movie.movieName" />
											想看
										</s:a>
										</li>
										<li><s:a action="play" method="showOneMoviePlaies"
												style="float:right; padding:1px;">
												<s:param name="movieName" value="#movie.movieName" />
											我要购票
										</s:a>
										</li>
									</ul>
								</s:iterator>

								<div style="text-align:center; clear:both;">
									<s:if test="#request.beforeMovieByPage!=null">
										<s:if test="#request.beforeMovieByPage.currentPage!=1">
											<a
												onclick="showJson('<s:property value="#request.beforeMovieByPage.currentPage-1" />',1)"
												style="cursor: hand;"> 前一页 </a>
										</s:if>
										<%-- 
										<s:iterator var="i" begin="1"
											end="%{#request.beforeMovieByPage.totalPages}">
											<s:if test="#i==#request.beforeMovieByPage.currentPage">
												<b style="color:red;"><s:property value="#i" /> </b>
											</s:if>
											<s:else>
												<a onclick="showJson(('<s:property value="#i" />',1)"
													style="cursor: hand;"> <s:property value="#i" /> </a>
											</s:else>
										</s:iterator>
										--%>
										<s:if
											test="#request.beforeMovieByPage.currentPage!=#request.beforeMovieByPage.totalPages">
											<a
												onclick="showJson('<s:property value="#request.beforeMovieByPage.currentPage+1" />',1)"
												style="cursor: hand;"> 后一页 </a>
										</s:if>
									</s:if>
								</div>
							</div>
						</div>
						<div class="TabbedPanelsContent" id="json2" style="width:100%;height:auto;">
							<div>
								<s:iterator var="movie" value="#request.afterMovieByPage.data">
									<ul class="main_left_middle_ul" style="height: 360px;">
										<li><s:a action="play" method="showOneMoviePlaies">
												<s:param name="movieName" value="#movie.movieName" />
												<s:generator separator="," val="#movie.moviePhoto">
													<s:iterator>
														<img src='<s:property />' border="0" width="160px" />
													</s:iterator>
												</s:generator>
											</s:a>
										</li>
										<li><b> <s:a action="play"
													method="showOneMoviePlaies">
													<s:param name="movieName" value="#movie.movieName" />
													<s:property value="#movie.movieName" />
												</s:a> </b>
										</li>
										<li><b> <s:date name="#movie.movieDate"
													format="yyyy年MM月dd日" /> </b>
										</li>
										<li><s:property
												value="#movie.movieInfo" />
										</li>
										<li><s:property value="#movie.movieActor" />
										</li>
										<li><s:a action="play" method="showOneMoviePlaies"
												style="float:left; padding:1px;">
												<s:param name="movieName" value="#movie.movieName" />
											想看
											</s:a>
										</li>
										<li><s:a action="play" method="showOneMoviePlaies"
												style="float:right; padding:1px;">
												<s:param name="movieName" value="#movie.movieName" />
											我要购票
											</s:a>
										</li>
									</ul>
								</s:iterator>

								<div style="text-align:center; clear:both;">
									<s:if test="#request.afterMovieByPage!=null">
										<s:if test="#request.afterMovieByPage.currentPage!=1">
											<a
												onclick="showJson('<s:property value="#request.afterMovieByPage.currentPage-1" />',2)"
												style="cursor: hand;"> 前一页 </a>
										</s:if>
										<%-- 
										<s:iterator var="i" begin="1"
											end="%{#request.afterMovieByPage.totalPages}">
											<s:if test="#i==#request.afterMovieByPage.currentPage">
												<b style="color:red;"><s:property value="#i" /> </b>
											</s:if>
											<s:else>
												<a onclick="showJson(('<s:property value="#i" />',2)"
													style="cursor: hand;"> <s:property value="#i" /> </a>
											</s:else>
										</s:iterator>
										--%>
										<s:if
											test="#request.afterMovieByPage.currentPage!=#request.afterMovieByPage.totalPages">
											<a
												onclick="showJson('<s:property value="#request.afterMovieByPage.currentPage+1" />',2)"
												style="cursor: hand;"> 后一页 </a>
										</s:if>
									</s:if>
								</div>
							</div>
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
									<img src='<s:property />' border="0" />
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
