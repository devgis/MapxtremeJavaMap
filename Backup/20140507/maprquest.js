function mapbigger(){
	var centerx
	var centery
	var newzoom
	var frametop
	var frameleft
	var tablewidth
	var tablehigh
	var picwidth
	var pichigh
	frametop=parseInt(document.all.mapframe.style.top)
	frameleft=parseInt(document.all.mapframe.style.left)
	tablehigh=parseInt(document.all.seltable.style.height)
	tablewidth=parseInt(document.all.seltable.style.width)
	tableleft=parseInt(document.all.seltable.style.left)
	tabletop=parseInt(document.all.seltable.style.top)
	picwidth=parseInt(document.all.imgmap.style.width)
	pichigh=parseInt(document.all.imgmap.style.height)
	//centerx=tablewidth/2+tableleft-frameleft
	//centery=tablehigh/2+tabletop-frametop
	centerx=window.event.clientX+frameleft
	centery=window.event.clientY+frametop
	centerx=centerx*1.2
	centery=centery*1.2
	newzoom=0.5
	//if(tablewidth>tablehigh){
		//newzoom=tablewidth/picwidth
		//newzoom=0.5
	//}
	//else{
		//newzoom=tablehigh/pichigh
		//newzoom=0.5
	//}
	//if(newzoom==0){
		//newzoom=0.5
	//}
	chgmapsrc("rqutype=chgmapview&centerx="+centerx+"&centery="+centery+"&newzoom="+newzoom)
}

function mapsmaller(){
	var centerx
	var centery
	var frametop
	var frameleft
	frametop=parseInt(document.all.mapframe.style.top)
	frameleft=parseInt(document.all.mapframe.style.left)
	//centerx=window.event.clientX*6
	//centery=window.event.clientY*6
	centerx=window.event.clientX-(frameleft+1)
	centery=window.event.clientY-(frametop+1)
	//chgmapsrc("rqutype=chgmapview&centerx="+centerx+"&centery="+centery)
	chgmapsrc("rqutype=chgmapview&centerx="+centerx+"&centery="+centery+"&newzoom=2")
}

function mappaner(){
	var centerx
	var centery
	var picwidth
	var pichigh
	var picleft
	var pictop
	picwidth=parseInt(document.all.imgmap.style.width)
	pichigh=parseInt(document.all.imgmap.style.height)
	pictop=parseInt(document.all.imgmap.style.top)
	picleft=parseInt(document.all.imgmap.style.left)
	//alert("wi--"+picwidth+"--he--"+pichigh+"--pictop--"+pictop+"--le--"+picleft);
	if(pictop!=0&&picleft!=0){
		//centerx=picwidth/2-picleft
		//centery=pichigh/2-pictop
		//centerx=picwidth/2-window.event.clientX
		//centery=pichigh/2-window.event.clientY
		centerx=picwidth/2-picleft
		centery=pichigh/2-pictop
		//centerx=window.event.clientX-11
		//centery=window.event.clientY-146
		//alert(picwidth + ',' + picleft + ',' + centerx + ',' + centery);
		chgmapsrc("rqutype=panmap&centerx="+centerx+"&centery="+centery)
		document.all.imgmap.style.left=0
		document.all.imgmap.style.top=0
	}
}

function mapsmallpaner(){
	var centerx
	var centery
	var frametop
	var frameleft
	var boundhigh
	var maphigh
	frametop=parseInt(document.all.mapboundframe.style.top)
	frameleft=parseInt(document.all.mapboundframe.style.left)
	//centerx=window.event.clientX*6
	//centery=window.event.clientY*6
	centerx=window.event.clientX-(frameleft+1)
	centery=window.event.clientY-(frametop+1)
	//centerx=window.event.clientX-871-20 
	//centery=window.event.clientY-147-4
	//centerx=centerx*3
	//centery=centery*3
	//centerx=centerx
	//centery=centery
	//centerx=window.event.clientX*852/242
	//centery=window.event.clientY*602/182
	//centerx=window.event.clientX*2
	//centery=window.event.clientY*2
	chgmapsrc("rqutype=smallpanmap&centerx="+centerx+"&centery="+centery)
}

function mapreset(){
    resetimg()
	state="reset"
	chgmapsrc("rqutype=resetmap")
}

function mapbound(){
	if(document.all.mapboundframe.style.display=="none"){
		mapbounder()
		document.all.mapboundframe.style.display=""
	}
	else{
		document.all.mapboundframe.style.display="none"
	}
	resetimg()
	state="bound"
}

function mapbounder(){
	document.all.boundmap.src=mapboundserviceurl
}

function chgmapsrc(querystring){
	var locationrul
	locatinourl="&oldx="+document.all.oldx.value+"&oldy="+document.all.oldy.value+"&oldzoom="+document.all.oldzoom.value
	document.all.imgmap.src=mapserviceurl+"?"+querystring+locatinourl
}

function setlocation(){	
	center.document.location.reload()
	zoom.document.location.reload()
}


function Find()
{
	var layernames = document.getElementById("layerid").value;
	var selectnames = document.getElementById("selectid").value;
	if(layernames==""||layernames==null){
	   alert("null");
	}else if(selectnames==""||selectnames==null){
	   alert("please select");
	   document.getElementById("selectid").focus();
	}else{
	   chgmapsrc("rqutype=querymap&layernames="+layernames+"&selectnames="+selectnames)
	}

}
