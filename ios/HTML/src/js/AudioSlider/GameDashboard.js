/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onerror = function (err) {
    //log('window.onerror: ' + err);
};

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function () {
            callback(WebViewJavascriptBridge)
        }, false);
    }
}

connectWebViewJavascriptBridge(function (bridge) {
    var uniqueId = 1;
    iOSInterface = bridge;
    OSType = "IOS";
    var jsObject = new Object();
    jsObject.type = "msg";
    jsObject.data = 29;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
        //alert(responseData);
        messageObj = JSON.parse(responseData);
        //loadMessage(messageObj);


    });

    
    var jsObject = new Object();
    jsObject.type = "drawData";
    jsObject.data = 2;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
        var msg = responseData;
        Initialise(msg);

    });




    
    function log(message, data) {
        var log = document.getElementById('log');
        var el = document.createElement('div');
        el.className = 'logLine';
        el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data);
        if (log.children.length) {
            log.insertBefore(el, log.children[0]);
        }
        else {
            log.appendChild(el);
        }
    }
    bridge.init(function (message, responseCallback) {
        startPlayer = false;    
        document.getElementById(message).style.opacity ='1.0';
        
        
        $("#CC"+message.substring(1, message.length)).removeClass("cus-circle").addClass("cus-circle-o");
        
        $("#CC1"+message.substring(1, message.length)).removeClass("pause").addClass("fa-step-forward");
        $("#CC1"+message.substring(1, message.length)).css("color","#5dc9e6");
        $("#CC1"+message.substring(1, message.length)).css("margin-left","-5px");
        
        $("#CC2"+message.substring(1, message.length)).addClass("fa-step-backward");
        $("#CC2"+message.substring(1, message.length)).css("color","#5dc9e6");
        
        
        
        $("#EE"+message.substring(1, message.length)).removeClass("cus-circle").addClass("cus-circle-o");
        $("#EE1"+message.substring(1, message.length)).removeClass("pause").addClass("fa-user");
        $("#EE1"+message.substring(1, message.length)).css("color","#5dc9e6");
        
        
    $("#RR"+message.substring(1, message.length)).removeClass("cus-circle").addClass("cus-circle-o");
        $("#RR1"+message.substring(1, message.length)).removeClass("pause").addClass("fa-microphone");
        $("#RR1"+message.substring(1, message.length)).css("color","#5dc9e6");
    $("#LL"+message.substring(1, message.length)).removeClass("cus-circle").addClass("cus-circle-o");
        $("#LL1"+message.substring(1, message.length)).removeClass("pause").addClass("fa-headphone");
        $("#LL1"+message.substring(1, message.length)).css("color","#5dc9e6");
        
        
        
        
        
        
        
    });
    
    
    
    

    bridge.registerHandler('testJavascriptHandler', function (data, responseCallback) {

        var responseData = {'Javascript Says': 'Right back atcha!'};

        responseCallback(responseData);
    });
});

var OSType = null;
var iOSInterface = null;

var triggerElementID = null; // this variable is used to identity the triggering element
var fingerCount = 0;
var startX = 0;
var startY = 0;
var curX = 0;
var curY = 0;
var deltaX = 0;
var deltaY = 0;
var horzDiff = 0;
var vertDiff = 0;
var minLength = 72; // the shortest distance the user may swipe
var swipeLength = 0;
var swipeAngle = null;
var swipeDirection = null;
var Current = 0;
//var listData;
var next_click_sound;
var startRec = false;
var startPlayer = false;


function OSCall()
{
     alert($(document).height());
    document.getElementById("mainId").setAttribute("style", "height:" + ($(document).height() - 10) + "px;");


    var jsonval = JSInterface.initialise(3);
    if (jsonval == null || typeof jsonval == 'undefined' || jsonval == undefined)
    {

        return;
    }
    else
    {
        OSType = "ANDROID";
    }
    var raw = JSON.parse(jsonval);
    messageObj = JSON.parse(JSInterface.getScreenMsg(3));
    var msg = raw.json;
    var uri_dec = decodeURIComponent(msg);
    msg = uri_dec;
    var regex = new RegExp('%22', 'g');
    var regex1 = new RegExp('%20', 'g');
    msg = msg.replace(regex, '"');
    msg = msg.replace(regex1, ' ');


    //var msg = "{\"scnArray\":[{\"desc\":\"scn1 desc\",\"name\":\"scn1\",\"uid\":\"34251\",\"irdata\":\"11\"},{\"desc\":\"scn2 desc\",\"name\":\"scn2\",\"uid\":\"34252\",\"irdata\":\"11\"},{\"desc\":\"scn3 desc\",\"name\":\"scn3\",\"uid\":\"34253\",\"irdata\":\"11\"},{\"desc\":\"scn4 desc\",\"name\":\"scn4\",\"uid\":\"34254\",\"irdata\":\"11\"},{\"desc\":\"scn5 desc\",\"name\":\"scn5\",\"uid\":\"34255\",\"irdata\":\"11\"}]}";
    Initialise(msg);
}
function Initialise(msg)
{
   // alert($(document).height());
    document.getElementById("mainId").setAttribute("style", "height:" + ($(document).height() - 10) + "px;");


    next_click_sound = createSound("../MCQ/media/slider.mp3");
    //Current = 0;
    
    var listData = JSON.parse(msg);
   // listData = listJsonData["vocabArray"];
    var topview = document.createElement("div");
    document.getElementById("mainId").appendChild(topview);
    topview.setAttribute("class", "top");
    topview.setAttribute("id", "topId");
   //alert(JSON.stringify(listData[0]));
    for (var i = 0; i < listData.length; i++)
    {
       listData[i].showStatus = 0; 
       var divinline = document.createElement("div");
        divinline.setAttribute("class", "horizontalDiv dragend-page");
        //divinline.setAttribute("id", listData[i].uid.toString());
        topview.appendChild(divinline);
        var modalView = document.createElement("div");
        divinline.appendChild(modalView);
        modalView.setAttribute("class", "modalWindow bg-white-only");
        
        
        modalView.innerHTML = "<div style=\"height: 70%;\"> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"height:25%;\"> <div style=\"font-size: 17px;\">"+listData[i].word+"</div> <i class=\"fa fa-1x text-muted\" style=\"font-size: 12px;\">"+listData[i].pronunciation+"</i> </div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"background-color:#f2f2f2\"></div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"height:25%;\"> <div style=\"font-size: 13px;\">Meaning</div> <i class=\"fa fa-1x scroll-y text-muted\" style=\"font-size: 12px;\">"+listData[i].meaning+"</i> </div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"background-color: #f2f2f2\"></div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"height:25%;\"> <div  style=\"font-size: 13px;\">Part of speech</div> <i class=\"fa fa-1x text-muted\" style=\"font-size: 12px;\">"+listData[i].partOfSpeech+"</i> </div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"background-color: #f2f2f2\"></div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"height:25%;\"> <div style=\"font-size: 13px;\">Usage </div> <i class=\"fa fa-1x text-muted\" style=\"font-size: 12px;\">"+listData[i].usage+"</i> </div> </div> <div class=\"col-sm-12 col-xs-12 col-md-12 col-lg-12\" style=\"background-color: #f2f2f2\"></div><div class=\"paddingLast\">  <div id=\"E"+listData[i].vocabWordID+"\" style=\"opacity: 1.0;\" class=\"col-sm-3 col-xs-3 col-md-3 col-lg-3 padder-v text-center \" onclick=\"playExpert('"+listData[i].vocabWordID+"');\"> <span class=\"fa-stack fa-2x m-r-sm\"> <i id=\"EE"+listData[i].vocabWordID+"\" class=\"fa  circleBase cus-circle-o fa-stack-2x\"></i> <i id=\"EE1"+listData[i].vocabWordID+"\" class=\"fa fa-user fa-stack-1x iconPadding\" ></i> </span><br> <i style=\"font-size:10px;\">1.Expert</i> </div> <div id=\"R"+listData[i].vocabWordID+"\" style=\"opacity: 0.6;\" class=\"col-sm-3 col-xs-3 col-md-3 col-lg-3 padder-v text-center \" onclick=\"playRecord('"+listData[i].vocabWordID+"');\"> <span class=\"fa-stack fa-2x m-r-sm\"> <i id=\"RR"+listData[i].vocabWordID+"\"class=\"fa  circleBase cus-circle-o fa-stack-2x\"></i> <i id=\"RR1"+listData[i].vocabWordID+"\" class=\"fa fa-microphone fa-stack-1x iconPadding\" ></i> </span><br> <i style=\"font-size:10px;\">2.record</i> </div> <div id=\"L"+listData[i].vocabWordID+"\" style=\"opacity: 0.6;\" class=\"col-sm-3 col-xs-3 col-md-3 col-lg-3 padder-v text-center \" onclick=\"playListen('"+listData[i].vocabWordID+"');\"> <span class=\"fa-stack fa-2x m-r-sm\"> <i id=\"LL"+listData[i].vocabWordID+"\" class=\"fa  circleBase cus-circle-o fa-stack-2x\" ></i> <i id=\"LL1"+listData[i].vocabWordID+"\" class=\"fa fa-headphones fa-stack-1x iconPadding\" ></i> </span><br> <i style=\"font-size:10px;\">3.Listen</i> </div> <div id=\"C"+listData[i].vocabWordID+"\" style=\"opacity: 0.6;\" class=\"col-sm-3 col-xs-3 col-md-3 col-lg-3 padder-v text-center \"  onclick=\"playCompare('"+listData[i].vocabWordID+"');\"> <span class=\"fa-stack fa-2x m-r-sm\"> <i id=\"CC"+listData[i].vocabWordID+"\" class=\"fa  circleBase cus-circle-o fa-stack-2x\" ></i> <i id=\"CC1"+listData[i].vocabWordID+"\" class=\"fa fa-step-forward fa-stack-1x comiconPadding1\" ></i><i id=\"CC2"+listData[i].vocabWordID+"\" class=\"fa fa-step-backward fa-stack-1x comiconPadding2\"></i> </span><br> <i style=\"font-size:10px;\">4.Compare</i> </div> </div>";
        
        
        
        
        
//        var wordName = document.createElement("div");
//        modalView.appendChild(wordName);
//        wordName.setAttribute("class", "col-sm-12 col-xs-12 col-md-12 col-lg-12");
//        wordName.innerHTML = "<div class=\"fa fa-2x\">"+listData[i].word+"</div> <br><div>"+listData[i].pronunciation+"</div>";
//        
        
    }
    
    
    var jsObject = new Object();
    jsObject.type = "getcookie";
    iOSInterface.send(JSON.stringify(jsObject), function (responseData)
        {
            Current = parseInt(responseData, 10)+1;
            Callforcefully(); 
        });
    
    

 
   

}
function playCompare(vocabId)
{
       if(startPlayer == true)
       {
         var jsComObject = new Object();
        jsComObject.type = "10";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
        });  
        startPlayer = false;
        return;
       }
       startPlayer = true;
       
           
      
       $("#CC"+vocabId).removeClass("cus-circle-o").addClass("cus-circle");
        $("#CC1"+vocabId).removeClass("fa-step-forward").addClass("pause");
        $("#CC1"+vocabId).css("color","#ffffff");
        $("#CC2"+vocabId).removeClass("fa-step-backward");
        $("#CC1"+vocabId).css("margin-left","0px");

        var jsComObject = new Object();
        jsComObject.type = "4";
        jsComObject.data = vocabId;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
    
}

function playExpert(vocabId)
{
        if(startPlayer == true)
       {
         var jsComObject = new Object();
        jsComObject.type = "10";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
        });  
        startPlayer = false;
        return;
       }
       startPlayer = true;
        //document.getElementById("EE"+vocabId).removeAttribute("class")
        $("#EE"+vocabId).removeClass("cus-circle-o").addClass("cus-circle");
        $("#EE1"+vocabId).removeClass("fa-user").addClass("pause");
        $("#EE1"+vocabId).css("color","#ffffff");
        
        //document.getElementById("R"+vocabId).style.opacity ='1.0';
        var jsComObject = new Object();
        jsComObject.type = "1";
        jsComObject.data = vocabId;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
   
    
    e = window.event;
    e.stopPropagation();
}
function playRecord(vocabId)
{
     
    $("#RR"+vocabId).removeClass("cus-circle-o").addClass("cus-circle");
        $("#RR1"+vocabId).removeClass("fa-microphone").addClass("pause");
        $("#RR1"+vocabId).css("color","#ffffff");
//        document.getElementById("E"+vocabId).style.opacity ='1.0';
//        document.getElementById("R"+vocabId).style.opacity ='1.0';
//        document.getElementById("L"+vocabId).style.opacity ='1.0';
//        document.getElementById("C"+vocabId).style.opacity ='0.6';
        var jsComObject = new Object();
        jsComObject.type ="2";
        jsComObject.data = vocabId;
       startRec = !startRec;
        jsComObject.startRec = startRec;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
 
}

function playListen(vocabId)
{
        if(startPlayer == true)
       {
         var jsComObject = new Object();
        jsComObject.type = "10";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
        });  
        startPlayer = false;
        return;
       }
       startPlayer = true;
        $("#LL"+vocabId).removeClass("cus-circle-o").addClass("cus-circle");
        $("#LL1"+vocabId).removeClass("fa-headphone").addClass("pause");
        $("#LL1"+vocabId).css("color","#ffffff");
//       document.getElementById("E"+vocabId).style.opacity ='1.0';
//        document.getElementById("R"+vocabId).style.opacity ='1.0';
//        document.getElementById("L"+vocabId).style.opacity ='1.0';
//        document.getElementById("C"+vocabId).style.opacity ='1.0';
        var jsComObject = new Object();
        jsComObject.type = "3";
        jsComObject.data = vocabId;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
            

        });

    

}



function touchStart(event, passedName) {
    // disable the standard ability to select the touched object
    event.preventDefault();
    // get the total number of fingers touching the screen
    fingerCount = event.touches.length;
    // since we're looking for a swipe (single finger) and not a gesture (multiple fingers),
    // check that only one finger was used
    if (fingerCount == 1)
    {
        //alert("amit");
        // get the coordinates of the touch
        startX = event.touches[0].pageX;
        startY = event.touches[0].pageY;
        // store the triggering element ID
        triggerElementID = passedName;
    } else {
        // more than one finger touched so cancel
        touchCancel(event);
    }
}

function touchMove(event) {
    event.preventDefault();
    if (event.touches.length == 1) {
        curX = event.touches[0].pageX;
        curY = event.touches[0].pageY;
    } else {
        touchCancel(event);
    }
}

function touchEnd(event) {
    event.preventDefault();
    // check to see if more than one finger was used and that there is an ending coordinate
    if (fingerCount == 1 && curX != 0) {
        // use the Distance Formula to determine the length of the swipe
        swipeLength = Math.round(Math.sqrt(Math.pow(curX - startX, 2) + Math.pow(curY - startY, 2)));
        // if the user swiped more than the minimum length, perform the appropriate action
        if (swipeLength >= minLength) {
            caluculateAngle();
            determineSwipeDirection();
            processingRoutine();
            touchCancel(event); // reset the variables
        } else {
            touchCancel(event);
        }
    } else {
        touchCancel(event);
    }
}

function touchCancel(event) {
    // reset the variables back to default values
    fingerCount = 0;
    startX = 0;
    startY = 0;
    curX = 0;
    curY = 0;
    deltaX = 0;
    deltaY = 0;
    horzDiff = 0;
    vertDiff = 0;
    swipeLength = 0;
    swipeAngle = null;
    swipeDirection = null;
    triggerElementID = null;
}

function caluculateAngle() {
    var X = startX - curX;
    var Y = curY - startY;
    var Z = Math.round(Math.sqrt(Math.pow(X, 2) + Math.pow(Y, 2))); //the distance - rounded - in pixels
    var r = Math.atan2(Y, X); //angle in radians (Cartesian system)
    swipeAngle = Math.round(r * 180 / Math.PI); //angle in degrees
    if (swipeAngle < 0) {
        swipeAngle = 360 - Math.abs(swipeAngle);
    }
}

function determineSwipeDirection() {
    if ((swipeAngle <= 45) && (swipeAngle >= 0)) {
        swipeDirection = 'left';
    } else if ((swipeAngle <= 360) && (swipeAngle >= 315)) {
        swipeDirection = 'left';
    } else if ((swipeAngle >= 135) && (swipeAngle <= 225)) {
        swipeDirection = 'right';
    } else if ((swipeAngle > 45) && (swipeAngle < 135)) {
        swipeDirection = 'down';
    } else {
        swipeDirection = 'up';
    }
}

function processingRoutine() {
   alert("Amit");
    var swipedElement = document.getElementById(triggerElementID);
    if (swipeDirection == 'left') {
        
       
        if (Current == listData.length - 1)
            return;
        
        var uid = listData[++Current].uid.toString();
        
        location.hash = uid.toString();
        document.getElementById(listData[Current].uid.toString()).setAttribute("class","horizontalDiv-left");
        
        playSound(next_click_sound);
        //document.getElementById(uid).focus();
        //playSound(next_click_sound);
        //LiqFlexiSS.loadNextSlide();
    } else if (swipeDirection == 'right') {
        
        var jsComObject = new Object();
        jsComObject.type = "10";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
        });
        
        if (Current == 0)
            return;
        
        
        var uid = listData[--Current ].uid.toString();
        //alert(uid);
         //$('html, body').animate({ scrollTop: uid.offset().top }, 'slow');
         //uid.toString().focus();
        
        
        
//        if (window.location.hash != "") {
//            $('html, body').scrollTop(0).animate({scrollTop:$(window.location.hash).position().top}, 'slow');
//        }
        
        document.getElementById(listData[Current].uid.toString()).setAttribute("class","horizontalDiv-right");
        playSound(next_click_sound);
        location.hash = uid.toString();
//        document.getElementById(listData[Current].uid.toString()).setAttribute("class","horizontalDiv-right");
        


        //LiqFlexiSS.loadPreviousSlide();
    } else if (swipeDirection == 'up') {
        // REPLACE WITH YOUR ROUTINES
    } else if (swipeDirection == 'down') {
        // REPLACE WITH YOUR ROUTINES
    }

}

function createSound(fpath) {
    var aud = document.createElement("audio");
    aud.src = fpath;
    aud.load();
    return aud;

}

function playSound(sndTag) {
    var jsComObject = new Object();
        jsComObject.type = "10";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
        });
    if (OSType == "IOS")
    {
        sndTag.play();

    }
    else
    {
        JSInterface.playMusic(sndTag.currentSrc);
    }

}        