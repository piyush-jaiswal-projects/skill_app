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
        callback(WebViewJavascriptBridge);
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function () {
            callback(WebViewJavascriptBridge);
        }, false);
    }
}

connectWebViewJavascriptBridge(function (bridge) {
    var uniqueId = 1;
    iOSInterface = bridge;
    OSType = "IOS";
    var jsObject = new Object();
    jsObject.type = "msg";
    jsObject.data = 30;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
        messageObj = JSON.parse(responseData);
        //loadMessage(messageObj);


    });

    var jsObject = new Object();
    jsObject.type = "getCurrentUid";
    //jsObject.data = 2;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
        if (responseData == "")
        {
            current = 0;
        }
        else
        {
            current = parseInt(responseData, 10);
        }


    });


    var jsObject = new Object();
    jsObject.type = "drawData";
    jsObject.data = 2;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
        var msg = responseData;
        var data = JSON.parse(msg);
         Initialise(data);

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

        
    });

    bridge.registerHandler('testJavascriptHandler', function (data, responseCallback) {

        var responseData = {'Javascript Says': 'Right back atcha!'};

        responseCallback(responseData);
    });
});

var OSType = null;
var iOSInterface = null;



function OSCall()
{
    
    
    
  var jsonval = JSInterface.initialise(30);
    //alert(jsonval);
    if(jsonval == null || typeof jsonval == 'undefined' || jsonval == undefined )
    {

        return;
    }
    else
    {
        OSType = "ANDROID";  
    }
    var raw = JSON.parse(jsonval);
    var msg = raw.json;
    var uri_dec = decodeURIComponent(msg);
    messageObj = JSON.parse(JSInterface.getScreenMsg(30));
    msg = uri_dec;
    var regex = new RegExp('%22', 'g');
    var regex1 = new RegExp('%20', 'g');
    msg = msg.replace(regex, '"');
    msg = msg.replace(regex1, ' ');

    var listJsonData = JSON.parse(msg);

    Initialise(listJsonData);
    
//  var msg = "{\"name\":\"Amit \" , \"irdata\":34,\"irPercentage\":30, \"badgeNo\":2}"; 
//  var data = JSON.parse(msg);
//    Initialise(data);
}


function createSound(fpath) {
    var aud = document.createElement("audio");
    aud.src=fpath;
    aud.load();
    return aud;
}

function playSound(sndTag) {
    
         
         sndTag.play();
          
}



 function Initialise(msg)
 {
     var coinSnd = createSound("../McqDnd/liqvid/coinsDroping.mp3");
     
     var cupAreabackGround  = document.createElement("div"); 
     //cupAreabackGround.setp
     cupAreabackGround.setAttribute("class","cupAreabackground");
     document.getElementById("mainId").appendChild(cupAreabackGround);
     var cupArea = document.createElement("div");
     cupArea.setAttribute("class","col-xs-12 cupArea text-center");
     if(parseInt(msg.irData,10) > 0)
     {
         playSound(coinSnd);
         cupArea.style.backgroundImage = "url('../McqDnd/liqvid/legend_1.png')";
     }
     else 
     {
         cupArea.style.backgroundImage = "url('../McqDnd/liqvid/emptyCup.gif')";
     }
//     if(msg.badgeNo == 1)
//     {
//        cupArea.style.backgroundImage =  url('../McqDnd/liqvid/legend.png'); 
//     }
//     else if(msg.badgeNo == 2)
//     {
//       cupArea.style.backgroundImage =  url('../McqDnd/liqvid/legend.png');   
//     }
//     else
//     {
//        cupArea.style.backgroundImage =  url('../McqDnd/liqvid/legend.png');  
//     }
     cupAreabackGround.appendChild(cupArea);
     
     var NameArea = document.createElement("div");
     NameArea.setAttribute("class","col-xs-12  name text-center");
    var newArr = new Array();
    newArr.push(msg.irData);
    
    var text = formatString(messageObj.YOUGOT,newArr);
     NameArea.innerHTML =   "<div class=\"fa fa-star text-warning\" style=\"font-size:25px; padding-right:5px\"></div>"+text;//+messageObj.CONGRATS+" "+ msg.name; //"Congratulations ! "+ msg.name;
     document.getElementById("mainId").appendChild(NameArea);
     
     
     var bottomArea = document.createElement("div");
     bottomArea.setAttribute("class","col-xs-12 text-center");
     document.getElementById("mainId").appendChild(bottomArea);
     
     var starVal = document.createElement("div");
     //starVal.setAttribute("style","margin-top:1%;");
     starVal.innerHTML = messageObj.CONGRATS+" "+ msg.name; //"<span class=\"fa-stack\" style=\"font-size:32px\"><i class=\"fa fa-circle fa-stack-2x circleColor  \"></i><i class=\"fa fa-star fa-stack-1x text-warning customStarbolt\"></i><div class=\"roundedCorner  block m-t-xs text-center\"> "+messageObj.YOUGOT +" <em>"+ msg.irData+"</em></div></span>";
     starVal.setAttribute("class","col-xs-12 text-center fa-2x congrats");
     bottomArea.appendChild(starVal);
     
     
     var courseVal = document.createElement("div");
     courseVal.setAttribute("class","col-xs-12 text-center");
     courseVal.setAttribute("onclick","gotoDashboard();");
     bottomArea.appendChild(courseVal);
     courseVal.innerHTML ="<div class=\"blueroundedCorner text-center\">"+messageObj.CURRENT_CHAP+"</div>";//"<span class=\"fa-stack \" style=\"font-size:32px\"><i class=\"fa fa-circle fa-stack-2x circleColor  \"></i><i class=\"fa fa-bolt fa-stack-1x text-warning customStarbolt\"></i><div class=\"blueroundedCorner text-center\">+messageObj.CURRENT_CHAP+</div></span>";
      
     
//     var FacebookArea = document.createElement("div");
//     FacebookArea.innerHTML = "<span class=\"fa-stack fa-2x pull-left m-r-sm\"><i class=\"fa fa-circle fa-stack-2x circleColor  \"></i><i class=\"fa fa-bolt fa-stack-1x text-warning \"></i><div class=\"roundedCorner text-right\">Completed "+msg.irPercentage+" %</</div></span>";
//     
//     document.getElementById("mainId").appendChild(bottomArea);
     
     
     
     
 }
 
 function formatString(formatstring, arrayInput)
            {
                var newStr;
                var returnStr = "";
                var arrString = formatstring.split("%s");
                if (arrString != null && arrString.length > 0)
                {
                    newStr = new Array();
                    for (var i = 0; i < arrString.length; i++)
                    {

                        newStr.push(arrString[i]);
                        if (i != arrString.length - 1)
                            newStr.push(arrayInput[i]);
                    }
                }

                if (newStr != null && newStr.length > 0)
                {

                    for (var j = 0; j < newStr.length; j++)
                    {
                        returnStr = returnStr + newStr[j];
                    }
                }

                return returnStr;
            }
            
            
            
    function gotoDashboard()
    {
        var obj = new Object();
        obj.uid = "";
        
        
        if(OSType == "IOS")
        {
            obj.type = "dashboard"; 
            var jsonString = JSON.stringify(obj);
            iOSInterface.send(jsonString);
        }
        else
        {
            obj.type = "3"; 
            var jsonString = JSON.stringify(obj);
            JSInterface.setHtmlResp(jsonString);
        }
    }
