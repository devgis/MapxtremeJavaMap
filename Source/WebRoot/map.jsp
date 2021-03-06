<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.mapinfo.mapj.*"%>
<%
	String flag = request.getParameter("flag");
	if (flag != null && flag.equals("true")) {
		MapJ mymap = (MapJ) session.getAttribute("mapj");
		Layer tlayer = null;
		if (mymap != null) {
			for (int i = 0; i < mymap.getLayers().size(); i++) {
				tlayer = mymap.getLayers().elementAt(i);
				String param1 = "isview" + i;
				String param2 = "isselect" + i;
				String param3 = "islabel" + i;
				String isview = request.getParameter(param1);
				String isselect = request.getParameter(param2);
				String islabel = request.getParameter(param3);
				if (isview != null && isview.equals("true"))
					tlayer.setVisible(true);
				else
					tlayer.setVisible(false);
				if (isselect != null && isselect.equals("true"))
					tlayer.setSelectable(true);
				else
					tlayer.setSelectable(false);
				if (islabel != null && islabel.equals("true"))
					tlayer.setAutoLabel(true);
				else
					tlayer.setAutoLabel(false);
			}
		}
	}
%>
<html>
<head>
<title>地图显示</title>
		<style type="text/css">
<!--
.css1 {
	font-size: 12pt;
	color: #FFFFFF
}
-->
</style>
		<script language="JavaScript" src="scripts/mapevent.js">
</script>
		<script language="JavaScript" src="scripts/mapmove.js">
</script>
		<script language="JavaScript" src="scripts/maprquest.js">
</script>
		<script language="JavaScript">
function resetimg(){
	if(state=="big"){		
		document.all.bigimg.src="images/index-map_03.jpg"
	}
	else if(state=="small"){
		document.all.smallimg.src="images/index-map_05.jpg"
	}
	else if(state=="pan"){
		document.all.panimg.src="images/index-map_06.jpg"
	}else if(state=="reset"){
		document.all.resetimg.src="images/index-map_07.jpg"
	}else if(state=="bound"){
		document.all.bound.src="images/index-map_08.jpg"
	}else if(state=="player"){
		document.all.player.src="images/index-map_09.jpg"
	}
}
</script>
</head>

<body bgcolor="#DFFFDF" link="#000000" vlink="#000000" alink="#000000">
查询测试： 选择图层：<font color="red">*</font>
<select id="layerid" name="layername">
<%
MapJ mymap=(MapJ)session.getAttribute("mapj");
Layer tlayer=null;
if(mymap!=null){
	for (int i=0;i<mymap.getLayers().size();i++){
		tlayer=mymap.getLayers().elementAt(i);
		%>
    
      <option value="<%=tlayer.getName()%>"><%=tlayer.getName()%></option>

    <%	}
}
%>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
查询名称：<font color="red">*</font>
<Input id="selectid" name="selectname" type="text"/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" id="queryid" value="查找" onClick="Find()"/>
<img src="images/map_03.jpg" width="857"
			border="0"
			style="position: absolute; left: 9px; top: 49px; width: 852px"><img name="downloadimg" src="/GisMap/MapServlet"
			style="position: absolute; left: 180px; top: 220px; z-index: 2;">
		<!--div为地图边框，img为地图-->
	<div id="mapframe"
			style="position: absolute; left: 9px; top: 64px; height: 602px; width:852px; overflow: hidden; background-color: #99FFFF; layer-background-color: #99FFFF; border: 1px #339933 solid"><img height="600" id="imgmap"
				style="position: relative; left: 0px; top: 0px; height: 600px; width: 850px; cursor: default" galleryimg="false"></div>
		<!--div缩略图边框，img为缩略图-->
		<div id="mapboundframe"
			style="position: absolute; left: 881px; top: 283px; height: 182px; width: 242px; overflow: hidden; background-color: #99FFFF; layer-background-color: #99FFFF; border: 1px #339933 solid; display: none">
			<img id="boundmap" GALLERYIMG="false"
				style="position: relative; left: 0px; top: 0px; visibility: hidden; height: 180px; width: 240px;"
				onclick="mapsmallpaner()">
		</div>
		
		<IFRAME id="center" style="display: none"></IFRAME>
		<IFRAME id="zoom" style="display: none"></IFRAME>
		<table id="seltable"
			style="position: absolute; border: 1px solid Red; width: 0px; height: 0px; display: none;">
			<tr>
				<td></td>
			</tr>
		</table>
		<img name="selimg"
			style="position: absolute; border: 1px solid Red; width: 1px; height: 1px; display: none;">
		<!--以下table显示的是地图操作按钮-->
		<table width="31%" border="0" cellpadding="0" cellspacing="0"
			style="position: absolute; left: 881px; top: 71px;; width: 178px; height: 182px">
			
			<tr valign="middle" align="left">
				<td>
					<img name="bigimg" src="images/index-map_03.jpg" width="159"
						height="28" onClick="mapbig()" style="cursor: hand"
						alt="区域放大地图">
				</td>
			</tr>
			<tr>
				<td>
					<img name="smallimg" src="images/index-map_05.jpg" width="159"
						onclick="mapsmall()" style="cursor: hand" alt="点击缩小地图">
				</td>
			</tr>
			<tr>
				<td>
					<img name="panimg" src="images/index-map_06.jpg" width="159"
						height="28" onClick="mappan()" style="cursor: hand" alt="浏览地图">
				</td>
			</tr>
			<tr>
				<td>
					<img name="resetimg" src="images/index-map_07.jpg" width="159"
						height="29" onClick="mapreset()" style="cursor: hand"
						alt="恢复地图初始状态">
				</td>
			</tr>
			<tr>
				<td>
					<img name="bound" src="images/index-map_08.jpg" width="159" height="29"
						onclick="mapbound()" style="cursor: hand" alt="缩略图">
				</td>
			</tr>
			<tr>
				<td>
					<img name="player" src="images/index-map_09.jpg" width="159" height="29"
						onclick="maplayer()" style="cursor: hand" alt="图层控制">
				</td>
			</tr>
</table>
		<div id="layer1"
			style="position: absolute; left: 17px; top: 634px; width: 87px; height: 18px; z-index: 2; font-size: 12px; color: Red;">
			当前状态：		</div>
		<div id="center&zoom"
			style="position: absolute; left: 10px; top: 680px; width: 577px; height: 33px; z-index: 3">
			<!--显示中心点和zoom值-->
			<table width="526" border="0">
				<tr>
					<td width="250">
						<font size="2">中心点(米)Ｘ:</font>
						<input type="Text"
							style="border: none; background: #DFFFDF; text-align: left;"
							name="oldx">
					</td>
					<td width="266">
						<font size="2">Ｙ:</font>
						<input type="Text"
							style="border: none; background: #DFFFDF; text-align: left;"
							name="oldy">
					</td>
				</tr>
				<tr>
					<td width="250">
						<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;视野(米):</font>
						<input type="Text"
							style="border: none; background: #DFFFDF; text-align: left;"
							name="oldzoom">
					</td>
					<td width="266">&nbsp;
						
				  </td>
				</tr>
				
			</table>
</div>
</body>
	<script language="JavaScript" src="scripts/init.js">
</script>
	<script language="JavaScript">
function maplayer(){
	var layer;//打开图层控制页面
	resetimg()
	state="player"
	layer=window.open("layer.jsp");
	document.all.player.src="images/index-map-a_09.jpg"
}
</script>
</html>