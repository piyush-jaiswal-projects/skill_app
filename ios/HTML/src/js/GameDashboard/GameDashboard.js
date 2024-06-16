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

        var dictJSON = JSON.parse(message);
        if (dictJSON.type == "showProgress")
        {
            showDownloadPrgressBar();
        }
        else if (dictJSON.type == "closeProgress")
        {
            closeDownloadPrgressBar();
        }
        else if (dictJSON.type == "percentage")
        {
            document.getElementById("fillprogressID").style.width = dictJSON.number + "%";
        }
        else if (dictJSON.type == "error")
        {
            closeDownloadPrgressBar();
            //document.getElementById(collapseID).setAttribute("class", "collapse");
            showAlert(messageObj.NW_EMSG);
        }
        else if (dictJSON.type == "notification")
        {
            //closeDownloadPrgressBar();
            //alert(dictJSON.value);
            if(dictJSON.value != "0" )
              document.getElementById("notificationId").style.display = "inline-block";
              document.getElementById("notificationId").innerHTML = dictJSON.value;
            //showAlert(messageObj.NW_EMSG);
        }
        //log('JS got a message', message)
        //var data = {'Javascript Responds': 'Wee!'}
        //log('JS responding with', data)
        //responseCallback(data)
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
var listData;
var next_click_sound;

function OSCall()
{

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
    next_click_sound = createSound("../MCQ/media/next_click.mp3");
    //Current = 0;
    
    var listJsonData = JSON.parse(msg);
    listData = listJsonData["scnArray"];
    var topview = document.createElement("div");
    document.getElementById("mainId").appendChild(topview);
    topview.setAttribute("class", "top");
    topview.setAttribute("id", "topId");

    for (var i = 0; i < listData.length; i++)
    {

        var divinline = document.createElement("div");
        divinline.setAttribute("class", "horizontalDiv dragend-page");
        
        
        divinline.setAttribute("id", listData[i].uid.toString());
        topview.appendChild(divinline);
        var modalView = document.createElement("div");
        
        divinline.appendChild(modalView);
        modalView.setAttribute("class", "modalWindow");
        var colorDiv = "background:#ffffff;";//+"color:"+messageObj.WIDGET_TEXT_COLOR;
     modalView.setAttribute("style",colorDiv);
        
        var triangleDiv = document.createElement("div");
        triangleDiv.setAttribute("class", "triangle-topright");
        
        var obj1 = listData[i];
        //triangleDiv.setAttribute("onclick", "javascript:clickOnScenarioUpdate('" + JSON.stringify(obj1) + "')");
        if(obj1.action != null && typeof(obj1.action) != "undefined" && obj1.action == 2 )
                    {
                       triangleDiv.innerHTML = "<span class=\"textTransform\">Update</span>";
                       modalView.appendChild(triangleDiv); 
                    }
        else if(obj1.action != null && typeof(obj1.action) != "undefined" && obj1.action == 1 )
                    {
                       triangleDiv.innerHTML = "<span class=\"textTransform\">New</span>";
                       modalView.appendChild(triangleDiv); 
                    }            
                    
        
        var innerModel = document.createElement("div");
        innerModel.setAttribute("class", "text-center");
//        innerModel.setAttribute("id", "swipeBox");
//        innerModel.setAttribute("ontouchstart", "touchStart(event,'swipeBox');");
//        innerModel.setAttribute("ontouchend", "touchEnd(event);");
//        innerModel.setAttribute("ontouchmove", "touchMove(event);");
//        innerModel.setAttribute("ontouchcancel", "touchCancel(event);");


        modalView.appendChild(innerModel);

        var starsArea = document.createElement("div");
        //starsArea.setAttribute("class","col-xs-12 text-center");
        innerModel.appendChild(starsArea);
        //alert(listData[i].irData);

        var emptyArea = document.createElement("div");
        emptyArea.setAttribute("class", "col-sm-3 ");
        //starsArea.appendChild(emptyArea);

        var star1Area = document.createElement("div");
        star1Area.setAttribute("class", "col-ls-2-5  fa fa-star starFontSize");
        if (listData[i].irData >= 20)
        {
            star1Area.style.color = messageObj.START_COLOR;
        }

        starsArea.appendChild(star1Area);
//    var star1 =  document.createElement("div");
//     star1Area.appendChild(star1);
//    star1.setAttribute("class","");

        var star2Area = document.createElement("div");
        star2Area.setAttribute("class", "col-ls-2-5  fa fa-star starFontSize");
        if (listData[i].irData >= 40)
        {
            star2Area.style.color = messageObj.START_COLOR;
        }
        starsArea.appendChild(star2Area);
//    var star1 =  document.createElement("div");
//     star1Area.appendChild(star1);
//    star1.setAttribute("class"," ");


        var star3Area = document.createElement("div");
        star3Area.setAttribute("class", "col-ls-2-5  fa fa-star starFontSize");
        if (listData[i].irData >= 60)
        {
            star3Area.style.color = messageObj.START_COLOR;
        }
        starsArea.appendChild(star3Area);
//    var star1 =  document.createElement("div");
//     star1Area.appendChild(star1);
//    star1.setAttribute("class","fa fa-star ");


        var star4Area = document.createElement("div");
        star4Area.setAttribute("class", "col-ls-2-5  fa fa-star starFontSize");
        if (listData[i].irData >= 80)
        {
            star4Area.style.color = messageObj.START_COLOR;
        }

        starsArea.appendChild(star4Area);


        var star5Area = document.createElement("div");
        star5Area.setAttribute("class", "col-ls-2-5  fa fa-star starFontSize");
        if (listData[i].irData >= 100)
        {
            star5Area.style.color = messageObj.START_COLOR;
        }
        starsArea.appendChild(star5Area);


        var emptyArea = document.createElement("div");
        emptyArea.setAttribute("class", "col-sm-3 ");
        //starsArea.appendChild(emptyArea);


        var scnName = document.createElement("div");
        scnName.setAttribute("class", "text-center col-xs-12 scnText");
        scnName.innerHTML = "<u>" + listData[i].name + "</u>";
        var colorIcon = "color:#4e4e4e";
    scnName.setAttribute("style",colorIcon);
        innerModel.appendChild(scnName);

        var scnDescName = document.createElement("div");
        scnDescName.setAttribute("class", "text-center col-xs-12 scndesc");
        scnDescName.innerHTML = listData[i].desc;
        innerModel.appendChild(scnDescName);
        
         var colorIcon = "color:#4e4e4e";
         scnDescName.setAttribute("style",colorIcon);
        var clickArr = document.createElement("div");
        clickArr.setAttribute("class", "col-xs-12");
        //startbutton.innerHTML = "start <div class=\"fa fa-arrow-circle-right\"></div>";
        modalView.appendChild(clickArr);

        var startbutton = document.createElement("div");
        startbutton.setAttribute("class", "col-xs-3");
        //startbutton.innerHTML = "start <div class=\"fa fa-arrow-circle-right\"></div>";
        
        clickArr.appendChild(startbutton);

        var startbutton = document.createElement("div");
        startbutton.setAttribute("class", "col-xs-6 refreshAndStart text-center");
        if(messageObj.MDB_BUY == 1 && listData[i].ZIPURL == "" )
        {
          startbutton.innerHTML = "Buy" ;  
        }
        else
        {
        startbutton.innerHTML = messageObj.CHAP_START ;//+"<div class=\"fa fa-arrow-circle-right\"></div>"
        }
            var obj = listData[i];
        //alert(JSON.stringify(obj));
        
        startbutton.setAttribute("onclick", "javascript:clickOnScenario(" +i+ ",'" + obj.action + "')");
        var colorDiv = "background:"+messageObj.WIDGET_BUTTON_BACKGROUD_COLOR+";"+"color:"+messageObj.WIDGET_BUTTON_TEXT_COLOR;
        startbutton.setAttribute("style",colorDiv);
        clickArr.appendChild(startbutton);

        var startbutton = document.createElement("div");
        startbutton.setAttribute("class", "col-xs-3 ");
        //startbutton.innerHTML = "start <div class=\"fa fa-arrow-circle-right\"></div>";
        clickArr.appendChild(startbutton);



    }
    
    
    

    var bottomview = document.createElement("div");
    document.getElementById("mainId").appendChild(bottomview);

    bottomview.setAttribute("class","bottom");

    var leftView = document.createElement("div");
    bottomview.appendChild(leftView);
    leftView.setAttribute("class", "col-xs-6 text-center");

    var leftCircleView = document.createElement("div");
    leftView.appendChild(leftCircleView);
    leftCircleView.setAttribute("class", "CircleDefault fa fa-align-justify fa-2x iconColor");
    leftCircleView.setAttribute("onclick", "clickCourse();");
    var colorDiv = "background:"+messageObj.DASHBOARD_BOTTOM_ICON_BACKGROUND_COLOR+";"+"color:"+messageObj.DASHBOARD_BOTTOM_ICON;
     leftCircleView.setAttribute("style",colorDiv);
    
 
 
 
    var leftNameView = document.createElement("div");
    leftView.appendChild(leftNameView);
    leftNameView.setAttribute("class", "name");

    leftNameView.innerHTML = messageObj.H_CHAPTERS;
    
    var colorIcon = "color:"+messageObj.BACKGROUND_IMAGE_TEXT_COLOR;
    leftNameView.setAttribute("style",colorIcon);


    var middleView = document.createElement("div");
    bottomview.appendChild(middleView);
    middleView.setAttribute("class", "col-xs-6 text-center");
   
   
    var middleCircleView = document.createElement("div");
    middleView.appendChild(middleCircleView);
    middleCircleView.setAttribute("class", "CircleDefault fa fa fa-bar-chart-o fa-2x iconColor");
    middleCircleView.setAttribute("onclick", "clickMyProfile();");
    
    var colorDiv = "background:"+messageObj.DASHBOARD_BOTTOM_ICON_BACKGROUND_COLOR+";"+"color:"+messageObj.DASHBOARD_BOTTOM_ICON;
     middleCircleView.setAttribute("style",colorDiv);
     
     
    var middleNameView = document.createElement("div");
    middleView.appendChild(middleNameView);
    middleNameView.setAttribute("class", "name");
    var colorIcon = "color:"+messageObj.BACKGROUND_IMAGE_TEXT_COLOR;
    middleNameView.setAttribute("style",colorIcon);
    middleNameView.innerHTML = messageObj.H_PROFILE;



    var rightView = document.createElement("div");
    //bottomview.appendChild(rightView);
    rightView.setAttribute("class", "col-xs-4 text-center");
    //badge badge-xl up
    //inline-block
    rightView.innerHTML ="<span id = \"notificationId\" class=\"badge_cus\" style=\"display:none ;\">0</span>";
   
    var rightCircleView = document.createElement("div");
    rightView.appendChild(rightCircleView);
    rightCircleView.setAttribute("class", "CircleDefault fa fa-search fa-2x iconColor"); //fa-search //fa-group
    rightCircleView.setAttribute("onclick", "clickProgramOverview();");
    var colorDiv = "background:"+messageObj.DASHBOARD_BOTTOM_ICON_BACKGROUND_COLOR+";"+"color:"+messageObj.DASHBOARD_BOTTOM_ICON;
     rightCircleView    .setAttribute("style",colorDiv);
    
     var rightNameView = document.createElement("div");
    rightView.appendChild(rightNameView);
    rightNameView.setAttribute("class", "name");
   var colorIcon = "color:"+messageObj.BACKGROUND_IMAGE_TEXT_COLOR;
    rightNameView.setAttribute("style",colorIcon);
    rightNameView.innerHTML = messageObj.ACTIVITY; 
    
    
    var jsObject = new Object();
    jsObject.type = "getCurrentUid";
    //jsObject.data = 2;
    var dataval = JSON.stringify(jsObject);
    iOSInterface.send(dataval, function (responseData) {
        if (responseData == "")
        {
            Current = 1;
        }
        else
        {
           
            Current =0;
            for(var i=0;i<listData.length;i++ )
                {
                    Current++;
                    if(parseInt(responseData,10) == parseInt(listData[i].uid,10))
                    {
                     Callforcefully(); 
                     return;
                    }
                    
                }
            Current =1; 
            Callforcefully(); 
        }


    });
   
 
   

}
function clickOnScenario(i,_action)
{

    if (OSType == "IOS")
    {
        var obj = listData[i];
        var jsComObject = new Object();
        if(parseInt(obj.type) === 5){
            jsComObject.type = "scn";
        }
        else
        {
            jsComObject.type = "assessment";
        }
        jsComObject.data = JSON.stringify(obj);
        jsComObject.status = _action;// "0";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
    }
    else
    {
        JSInterface.startScn(scnobj);
    }
}

function clickOnScenarioUpdate(scnobj)
{

    if (OSType == "IOS")
    {

        var jsComObject = new Object();
        jsComObject.type = "scn";
        jsComObject.data = scnobj;
        jsComObject.status = "2";
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
    }
    else
    {
        JSInterface.startScn(scnobj);
    }
    
    e = window.event;
    e.stopPropagation();
}
function clickMyProfile()
{
    if (OSType == "IOS")
    {

        var jsComObject = new Object();
        jsComObject.type = "menu";
        jsComObject.data = 2;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
    }
    else
    {
        var obj = new Object();
        obj.uid = -1;
        obj.type = 13;
        var jsonString = JSON.stringify(obj);
        //  dbgAlert("handleLearningClick called final"+jsonString);
        JSInterface.setMenuResp(jsonString);
    }




}

function clickCourse()
{
    if (OSType == "IOS")
    {
        var jsComObject = new Object();
        jsComObject.type = "menu";
        jsComObject.data = 10;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString, function (responseData)
        {
            if (responseData == 'closeProgress')
                closeProgress();

        });

    }
    else
    {
        var obj = new Object();
        obj.uid = -1;
        obj.type = 14;
        var jsonString = JSON.stringify(obj);

        JSInterface.setMenuResp(jsonString);
    }

}

function clickProgramOverview()
{
    if (OSType == "IOS")
    {
        var jsComObject = new Object();
        jsComObject.type = "menu";
        jsComObject.data = 8;
        var jsonString = JSON.stringify(jsComObject);
        iOSInterface.send(jsonString);
    }
    else
    {
        var obj = new Object();
        obj.uid = -1;
        obj.type = 15;
        var jsonString = JSON.stringify(obj);
        //  dbgAlert("handleLearningClick called final"+jsonString);
        JSInterface.setMenuResp(jsonString);
    }
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
    if (OSType == "IOS")
    {
        sndTag.play();

    }
    else
    {
        JSInterface.playMusic(sndTag.currentSrc);
    }

}        
