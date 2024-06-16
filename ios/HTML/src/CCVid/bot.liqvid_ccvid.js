/*
liqvid common javascript code library
(c) Liqvid E-Learning Services Pvt. Ltd. 2014-15
*/
LiqCommon.registerEvent("ccvid_showScriptText",function() {
    resp = $('.liqvid_cc_video')[0].transcript;
    return resp;
    //return $('.liqvid_cc_video')[0].transcript;
});

LiqCommon.registerEvent("ccvid_nextVideoNotification",ccVidPlayNextVideo);
LiqCommon.registerEvent("ccvid_playPauseNotification",ccVidPlayPauseVideo);

LiqCommon.registerEvent("liqStartOperation",function(e,d) {
    initialiseBottom();
    ccVidJumpToIndex(0);
});
function ccVidPlayNextVideo(e) {
    ccVidNext();
}

function ccVidPlayPauseVideo(e) {
    ccVidTogglePlayPause();
}
function ccVidJumpToIndex(i) {
    var obj = new Object();
    obj.event="ccvid_jumpToVideo";
    obj.eventData = new Object();
    //alert(i);
    //alert($('.liqvid_cc_video')[0].playState.videoTags.length);
    
    if(parseInt(i,10) > parseInt($('.liqvid_cc_video')[0].playState.videoTags.length,10)-1)
    {
         //alert("End");
        obj.eventData.videoPath = "";
        obj.eventData.videoPathIndex = -1;
    }
    else
    {
        obj.eventData.videoPath = $('.liqvid_cc_video')[0].playState.videoTags[i].src;
        obj.eventData.videoPathIndex = i;
    }
    
    //alert("Firing next video event with i="+i);
    LiqNative.send(obj);
}

LiqCommon.registerEvent("ccvid_jumpToVideo",ccVidHandleJumpToIndexEvent);
function ccVidHandleJumpToIndexEvent(e,d) {
  $('.liqvid_cc_video').each(function(){
	playState = this.playState;
	playState.jump(d.videoPathIndex);
  });
}

function ccVidNext() {
    ccVidJumpToIndex($('.liqvid_cc_video')[0].playState.index+1);
}

function ccVidBack() {
    ccVidJumpToIndex($('.liqvid_cc_video')[0].playState.index-1);
}

function ccVidTogglePlayPause() {
    $('.liqvid_cc_video').each(function(){
    playState = this.playState;
    if(playState.state == 0) {
        playState.play();
        this.playbackCtrl.playPauseButton.image.setAttribute("src","images/pause.png");
    } else {
        this.playbackCtrl.playPauseButton.image.setAttribute("src","images/play_p.png");
        playState.pause();
    }
  });     
}

function ccVidRefresh() {
    ccVidJumpToIndex(0);
}

function ccVidIsFullScreenEnabled() {
    return true;
}

function ccVidGoFullScreen() {
    var obj = new Object();
    obj.event="ccvid_fullScreen";
    obj.eventData =  null;
    LiqNative.send(obj);
}

function ccVidToggleCaption() {
    $('.liqvid_cc_video').each(function(){
        playState = this.playState;
        if(playState.captionState ==1) {
            this.playbackCtrl.captionButton.image.setAttribute("src","images/trans_on.png");
            playState.captionState = 0;
            $(this.captionContainer).hide();
        } else {
            this.playbackCtrl.captionButton.image.setAttribute("src","images/trans_off.png");
            playState.captionState = 1;
            $(this.captionContainer).show();
        }
    });
}



function ccVidWriteObjToXScript(key,obj,isLink) {
    var str="";
    if(LiqCommon.isUndefined(obj))
        return "";
    try {
        if(key == "simple" && obj!=null) {
            str = obj;
        } else if (key=="click" && obj!=null && !LiqCommon.isUndefined(obj) && !LiqCommon.isUndefined(obj.value)){
            str = obj.value;
            if(isLink)
            {
                
                obj.vocabid = obj.vocabid.replace(" ", "%30");
                //alert(obj.vocabid);
                str = "<a href=# onclick = javascript:clickOnWord('"+obj.vocabid+"')>"+str+"</a>";
            }
        }
    } catch(err) { }
    if(LiqCommon.isUndefined(str))
        return "";
   // if(str == "") return "";
   str = JSON.stringify(str);
    
    str = str.trim()+" ";
    str = str.replace(/\\\\n/gi,"<br>");
    str=str.replace("    ,", "");
    str=str.replace("&#x2019;", "'");
    //str=str.replace("&#38;", "&");
    //str=str.replace("&#38;", "&");
    //str=str.replace("&#38;&gt;", "'>'");
    //str=str.replace("&#38;&lt;", "'<'");
    
    //str=str.replace("&#38;", "&");
    str=str.replace("[", "");
    str=str.replace("]", "");
    //str=str.replace("\n","");
    str=str.replace(",","");
     str=str.replace("            ","");
    
    str=str.replace("{}", "");
    str = str.replace(/\\\\t/gi,"");
    str = str.replace(/\\r/gi,"");
    str = str.replace(/\\/gi,"");
    str = str.replace(/"/gi,"");
    str = str.replace(/&#38;/gi,"&");
    console.log(str);
   
    
    return str;
    
}


function ccVidGetFullTranscript(conversation) {
    var str = "";
    for(var index=0; index< conversation.unit.length; index++) {
        var text = conversation.unit[index].question.text;
        if(LiqCommon.isUndefined(text.segment.length)) {
            for(var key in text.segment) {
                if(text.segment.hasOwnProperty(key)){
                   var obj = text.segment[key];
                   str+=ccVidWriteObjToXScript(key,obj,false);
                }
            }
        } else {
            for(var i=0; i< text.segment.length; i++) {
                for(var key in text.segment[i]) {
                    var obj = text.segment[i][key];
                   if(!LiqCommon.isUndefined(obj)) {
                      str+=ccVidWriteObjToXScript(key,obj,false);
                   }
                }
            }	
        }
        str+="\n";
    }
    return str;
}
function clickOnWord(wordId)
{
  //alert(wordId);
  var obj = new Object();
    obj.event="ccvid_clickOnWord";
    obj.eventData = wordId;
    var stringData = JSON.stringify(obj); 
    JSInterface.send(stringData);  
}
function ccVidGetTranscript(text) {
	if(text.displayHTML != null)
		return text.displayHTML;
	text.displayHTML = "";
	if(LiqCommon.isUndefined(text.segment.length)) {
		for(var key in text.segment) {
			if(text.segment.hasOwnProperty(key)){
			   var obj = text.segment[key];
               text.displayHTML += ccVidWriteObjToXScript(key,obj,true);
			}
		}
	} else {
		for(var i=0; i< text.segment.length; i++) {
			for(var key in text.segment[i]) {
				var obj = text.segment[i][key];
                text.displayHTML += ccVidWriteObjToXScript(key,obj,true);
			}
		}	
	}
	return text.displayHTML;
}


function createDiv(className) {
    var thisfi = document.createElement("div");
    thisfi.className = className;
    return thisfi;
}

//!function ($) {
function initialiseBottom()
{
  $('.liqvid_cc_video').each(function(){
	$data = this.dataset;
	var xmlPath = $data.xml;
	var containerName = $data.container;
	if(!document.createElement('video').canPlayType) {
	    alert("Your browser does not support the modern HTML5 Video playback capability. Please try on a new generation browser");
	}
	if(xmlPath == null || LiqCommon.isUndefined(xmlPath)) {
		alert("The data-xml attribute is not defined for liqvid_cc_video. Please define the same");
		return;
	}
	if(containerName == null || LiqCommon.isUndefined(containerName)) {
		alert("The data-container attribute is not defined for liqvid_cc_video. Please define the same");
		return;
	}
	var containerDiv = $("#"+containerName);
	if(containerDiv == null || LiqCommon.isUndefined(containerDiv)) {
		alert("The data-container attribute's div is not defined for liqvid_cc_video. Please define the same");
		return;
	}

	/* parse the xml */
//	var liqvid_xml_string = LiqNative.loadFileIntoString(xmlPath);
        var liqvid_xml = xml2json.parser(ConceptXmlData);
         //var liqvid_xml = ConceptXmlData;  
	if( liqvid_xml == null ) {
		alert("Could not parse the XML file : "+xmlPath);
		return;
	}
    //alert(JSON.stringify(liqvid_xml));
	var conversation = liqvid_xml.conversation;
	//this.conversation = conversation;
        if( conversation.unit.length == undefined )
        {
          this.conversation = new Object();
          this.conversation.idealtime = conversation.idealtime;
          var Lunit = new Array();
          Lunit.push(conversation.unit);
          this.conversation.unit = Lunit;
          conversation = this.conversation;
        }
        else
        {
            this.conversation = conversation;
        }
        
          
	//alert(conversation);

    /* Create placholder Divs */
    this.containerDiv = containerDiv;
    this.jumpCtrl = createDiv("ccvid_jump_ctrl ccvid_jump_ctrl_standalone");
    this.playbackCtrl = createDiv("ccvid_playback_ctrl ccvid_playback_ctrl_standalone");
    this.captionContainer = createDiv("ccvid_caption ccvid_caption_standalone");
    //containerDiv.append(this.jumpCtrl);
    //containerDiv.append(this.playbackCtrl);
    containerDiv.append(this.captionContainer);

	var playState = new Object();
    playState.size = conversation.unit.length;

    playState.videoTags = new Array();
    var transriptLength = 0;
    for(var i=0; i< conversation.unit.length; i++) {
        var video=new Object();
        video.src = LiqNative.convertFileLocToUrl(conversation.unit[i].question.play);
        video.master=this;
        playState.videoTags[i]  = video;

	    var b = ccVidGetTranscript(conversation.unit[i].question.text);
        transriptLength+=b.length;
     }
    /* Make jump links */
    var avgLength = transriptLength / conversation.unit.length;
    for(var i=0; i< conversation.unit.length; i++) {
	    var b = ccVidGetTranscript(conversation.unit[i].question.text);
        var alink = document.createElement("a");
        alink.href = "javascript:ccVidJumpToIndex("+i+")";    
        if(b.length < avgLength) {
            alink.className = "ccvid_jump_small ccvid_jump_unseen";
            alink.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        } else {
            alink.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            alink.className = "ccvid_jump_big ccvid_jump_unseen";
        }
        playState.videoTags[i].jumpLink = alink;
        $(this.jumpCtrl).append(alink);
    }
    /* Add Playback Controls */
    this.playbackCtrl.backButton = createDiv("ccvid_playback_btn ccvid_playback_btn_left");
    $(this.playbackCtrl.backButton).append("<img src=images/back_p.png></img>");
    $(this.playbackCtrl.backButton).click(ccVidBack);

    var spacer = createDiv("ccvid_spacer_left");
    $(spacer).append("&nbsp;");

    this.playbackCtrl.playPauseButton = createDiv("ccvid_playback_btn ccvid_playback_btn_left");
    this.playbackCtrl.playPauseButton.image = document.createElement("img");
    this.playbackCtrl.playPauseButton.image.setAttribute("src","images/pause.png");
    $(this.playbackCtrl.playPauseButton).append(this.playbackCtrl.playPauseButton.image);
    $(this.playbackCtrl.playPauseButton).click(ccVidTogglePlayPause);

    var spacer2 = createDiv("ccvid_spacer_left");
    $(spacer2).append("&nbsp;");

    this.playbackCtrl.nextButton = createDiv("ccvid_playback_btn ccvid_playback_btn_left");
    $(this.playbackCtrl.nextButton).append("<img src=images/next_p.png></img>");
    $(this.playbackCtrl.nextButton).click(ccVidNext);

    this.playbackCtrl.captionButton = createDiv("ccvid_caption_btn");
    this.playbackCtrl.captionButton.image = document.createElement("img");
    this.playbackCtrl.captionButton.image.setAttribute("src","images/trans_off.png");
    $(this.playbackCtrl.captionButton).append(this.playbackCtrl.captionButton.image);
    $(this.playbackCtrl.captionButton).click(ccVidToggleCaption);

    var spacer3 = createDiv("ccvid_spacer_right");
    $(spacer3).append("&nbsp;");

    this.playbackCtrl.refreshButton = createDiv("ccvid_caption_btn");
    $(this.playbackCtrl.refreshButton).append("<img src=images/referesh_p.png></img>");
    $(this.playbackCtrl.refreshButton).click(ccVidRefresh);
    
    var spacer4 = createDiv("ccvid_spacer_right");
    $(spacer4).append("&nbsp;");

    this.playbackCtrl.fullScreenButton = createDiv("ccvid_caption_btn");
    $(this.playbackCtrl.fullScreenButton).append("<img src=images/fullscreen_p.png></img>");
    $(this.playbackCtrl.fullScreenButton).click(ccVidGoFullScreen);

    $(this.playbackCtrl).append(this.playbackCtrl.backButton);
    $(this.playbackCtrl).append(spacer);
    $(this.playbackCtrl).append(this.playbackCtrl.playPauseButton);
    $(this.playbackCtrl).append(spacer2);
    $(this.playbackCtrl).append(this.playbackCtrl.nextButton);
    if(ccVidIsFullScreenEnabled) {
        $(this.playbackCtrl).append(this.playbackCtrl.fullScreenButton);
        $(this.playbackCtrl).append(spacer3);
    }
    $(this.playbackCtrl).append(this.playbackCtrl.refreshButton);
    $(this.playbackCtrl).append(spacer4);
    $(this.playbackCtrl).append(this.playbackCtrl.captionButton);

    this.transcript =ccVidGetFullTranscript(conversation);
        
    /* Setup PlayStat object */
    playState.currentTag = "";
    playState.index = 0;
    playState.xscript = this.captionContainer;
    this.playState = playState;
	playState.loadNext = function() {
		this.index++;
		if(this.index < conversation.unit.length) {
            this.video = this.videoTags[this.index];
			this.play();
            this.state = 1;
			this.xscript.innerHTML = ccVidGetTranscript(conversation.unit[this.index].question.text);
            this.video.jumpLink.className+=" ccvid_jump_seen";
		}
	}
    playState.pause = function() {  
        var obj = new Object();
        obj.event = "ccvid_pause";
        obj.eventData = null;
        LiqNative.send(obj);
        this.state = 0;
    }
    playState.play = function() {
        var obj = new Object();
        obj.event = "ccvid_play";
        obj.eventData = null;
        LiqNative.send(obj);
        this.state = 1;
    }
    playState.jump = function(index) {
        this.index = index-1;
        this.loadNext();
    }
    containerDiv.index = -1;
    playState.captionState = 1;
  //  ccVidJumpToIndex(0);
  });
}(window.jQuery);
