/*
liqvid common javascript code library
(c) Liqvid E-Learning Services Pvt. Ltd. 2014-15
*/
function createDiv(className) {
    var thisfi = document.createElement("div");
    thisfi.className = className;
    return thisfi;
}

function ccVidJumpToIndex(i) {
    var obj = new Object();
    obj.event = "ccvid_jumpToVideo";
    obj.eventData = new Object();
    obj.eventData.videoPath = $('.liqvid_cc_video')[0].playState.videoTags[i].src;
    obj.eventData.videoPathIndex = i;
    LiqNative.send(obj);
}


LiqCommon.registerEvent("liqStartOperation", function (e,d) {
    initialise();
    
});
LiqCommon.registerEvent("ccvid_jumpToVideo", function (e,d) {
    //initialise();
    var playState = $('.liqvid_cc_video')[0].playState;
    playState.index = d.videoPathIndex-1;
    playState.loadNext();
});



//!function ($) {
    
 function initialise()
 {
  $('.liqvid_cc_video').each(function(){
      
	$data = this.dataset;
	var xmlPath = $data.xml;
	var containerName = $data.container;
	if(!document.createElement('video').canPlayType) {
	    alert("Your browser does not support the modern HTML5 Video playback capability. Please try on a new generation browser");
	}
	if(xmlPath == null || LiqCommon.isUndefined(xmlPath)) {
		console.error("The data-xml attribute is not defined for liqvid_cc_video. Please define the same");
		return;
	}
	if(containerName == null || LiqCommon.isUndefined(containerName)) {
		console.error("The data-container attribute is not defined for liqvid_cc_video. Please define the same");
		return;
	}
	var containerDiv = $("#"+containerName);
	if(containerDiv == null || LiqCommon.isUndefined(containerDiv)) {
		console.error("The data-container attribute's div is not defined for liqvid_cc_video. Please define the same");
		return;
	}

//	/* parse the xml */
//	var liqvid_xml_string = LiqNative.loadFileIntoString(xmlPath);
    var liqvid_xml = xml2json.parser(ConceptXmlData);
    //var liqvid_xml = ;
	if( liqvid_xml == null ) {
		console.error("Could not parse the XML file : "+xmlPath);
		return;
	}
    //alert(JSON.stringify(liqvid_xml));
	var conversation = liqvid_xml.conversation;
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
        $data.title = conceptName;
	console.log(conversation);

    /* Create placholder Divs */
    // add section div
    this.containerDiv = containerDiv;
    this.titleDiv =  createDiv("ccvid_title ccvid_title_standalone");
    this.sectionControls = createDiv("ccvid_section ccvid_section_standalone");
    containerDiv.append(this.titleDiv);
    containerDiv.append(this.sectionControls);

	var playState = new Object();
    playState.size = conversation.unit.length;
    /* Set the ttitle */
    this.titleDiv.innerHTML = $data.title;
    /* Find Section Jumps and mark thm accordingly */
    this.sectionControls.innerHTML="<br>";
    var j=-1;
    var lastSection = "";
    var sectionArray = new Array();
    for(var i=0; i< conversation.unit.length; i++) {
        var question = conversation.unit[i].question[0];
        if(question == null || LiqCommon.isUndefined(question)) 
            question = conversation.unit[i].question;
        var tag = question.tag;
        if(tag != lastSection) {
            j++;
            var alink = document.createElement("a");
            alink.href="javascript:ccVidJumpToIndex("+i+")";
            var tag1 = tag.split(' ').join('&nbsp;');
            var tag2 = tag1.split('?').join('?&nbsp;');
            //var tag3 = tag2.split('').join();
            //var tag4 = tag3.replace('&nbsp;','');
                             
                           
            alink.innerHTML = tag2;//.toProperCase();
            alink.className = "ccvid_sectionLink";
            alink.sectionTag = tag;
            //$(this.sectionControls).append('<a id="section_jump_'+j+'" href="javascript:ccVidJumpToIndex('+i+')" class=sectionLink>'+tag+'</a>');
            $(this.sectionControls).append(alink);
            sectionArray[j] = alink;
            lastSection = tag;
        }
    }
    playState.sectionArray = sectionArray;
    playState.videoTags = new Array();
    var transriptLength = 0;
    for(var i=0; i< conversation.unit.length; i++) {
        var video=new Object();
        video.src = LiqNative.convertFileLocToUrl(conversation.unit[i].question.play);
        video.master=this;
        playState.videoTags[i]  = video;
     }


    /* Setup PlayStat object */
    playState.currentTag = "";
    playState.index = -1;
    playState.xscript = this.captionContainer;
    this.playState = playState;
	playState.loadNext = function() {
		this.index++;
		if(this.index < conversation.unit.length) {
            this.state = 1;
            var question = conversation.unit[this.index].question[0];
            if(question == null || LiqCommon.isUndefined(question)) 
                question = conversation.unit[this.index].question;
            var tag = question.tag;
            if(tag!=this.currentTag) {
                for(var k =0; k< this.sectionArray.length; k++) {
                    if(sectionArray[k].sectionTag !=tag) 
                        sectionArray[k].className = "ccvid_sectionLink ccvid_sectionLinkPassive";
                    else
                        sectionArray[k].className = "ccvid_sectionLink ccvid_sectionLinkActive";
                    this.currentTag = tag;
                }
            }
		}
	}
  });
}(window.jQuery);
