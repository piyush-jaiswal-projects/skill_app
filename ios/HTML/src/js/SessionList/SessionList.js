/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

window.onerror = function (err) {
       //log('window.onerror: ' + err)
    }

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

    iOSInterface =bridge;
    OSType = "IOS"; 

   var jsObject = new Object();
    jsObject.type = "getcookie";

    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {

        jsonvalCookie = responseData;


    });


    var uniqueId = 1;
    var Data;
    var jsObject = new Object();
    jsObject.type = "msg";
    jsObject.data = 10;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
        messageObj = JSON.parse(responseData);
        //loadMessage(messageObj);


    });

    //initialise();
    var jsObject = new Object();
    jsObject.type = "drawData";
    jsObject.data = 10;
    var dataval = JSON.stringify(jsObject);
    bridge.send(dataval, function (responseData) {
    var msg = responseData;
    var listJsonData = JSON.parse(msg);
    var listData = listJsonData["course"];
    
    
    
    //alert($(document).height());
    if($(document).height() == 960 && $(document).width() == 768)
        {
        document.getElementById("alertID").style.top = "45%";
        document.getElementById("alertID").style.left = "25%";
        document.getElementById("alertID").style.height = "150px";
        document.getElementById("alertID").style.width = "50%";
        }
        else
        {
          document.getElementById("alertID").style.top = "25%";
        document.getElementById("alertID").style.left = "15%";
        document.getElementById("alertID").style.height = "150px";
        document.getElementById("alertID").style.width = "300px"; 
        }
        document.getElementById("okId").innerHTML = messageObj.OK;

        //alert(listData);
        document.getElementById("downloadMSGID").innerHTML = messageObj.DLOAD_CHAP_MSG;
    
    
    Initialise(listData); 

    });




function log(message, data) {
        var log = document.getElementById('log')
        var el = document.createElement('div')
        el.className = 'logLine'
        el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data)
        if (log.children.length) {
            log.insertBefore(el, log.children[0])
        }
        else {
            log.appendChild(el)
        }
    }
    bridge.init(function (message, responseCallback) {

        var dictJSON = JSON.parse(message);
        if(dictJSON.type == "showProgress")
        {
           showDownloadPrgressBar(); 
        }
        else if(dictJSON.type == "closeProgress")
        {
            closeDownloadPrgressBar();
        }
        else if(dictJSON.type == "percentage")
        {
        document.getElementById("fillprogressID").style.width = dictJSON.number+"%";
        //document.getElementById("msgTextId").style.display = 'none';
//                    if(parseInt(dictJSON.number,10) >= 83)
//                        {
//                            
//                            //document.getElementById("msgTextId").style.display = 'block';
//                           document.getElementById("progressCancelId").disabled = true; 
//                           document.getElementById("progressCancelId").style.color ='#e8e8e8';
//                        }
        }
        else if(dictJSON.type == "error")
        {
           closeDownloadPrgressBar();
           //document.getElementById(collapseID).setAttribute("class", "collapse");
           showAlert(messageObj.NW_EMSG);
        }
        //log('JS got a message', message)
        //var data = {'Javascript Responds': 'Wee!'}
        //log('JS responding with', data)
        //responseCallback(data)
    });

    bridge.registerHandler('testJavascriptHandler', function (data, responseCallback) {

        var responseData = {'Javascript Says': 'Right back atcha!'}

        responseCallback(responseData)
    });
});
            
            
            
            
var OSType = null;
var iOSInterface = null;

function OScall()
{
    var jsonval = JSInterface.initialise(10);
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
    msg = uri_dec;
    var regex = new RegExp('%22', 'g');
    var regex1 = new RegExp('%20', 'g');
    msg = msg.replace(regex, '"');
    msg = msg.replace(regex1, ' ');
    
    
    //var msg = "{ \"course\" : [ { \"name\" : \"Pre Assessment\", \"scnArray\" : [ ], \"type\" : \"3\", \"isLock\" : \"0\", \"uid\" : \"15934\", \"isComp\" : \"0\" }, { \"name\" : \"Module 1\", \"scnArray\" : [ { \"name\" : \"सिनेरियो 1\", \"type\" : \"5\", \"uid\" : \"15936\", \"desc\" : \"Talking About Yourself\", \"isComp\" : \"0\" }, { \"name\" : \"सिनेरियो 2\", \"type\" : \"5\", \"uid\" : \"15946\", \"desc\" : \"Long Term Career Goals\", \"isComp\" : \"0\" } ], \"type\" : \"4\", \"isLock\" : \"0\", \"uid\" : \"15935\", \"isComp\" : \"0\" }, { \"name\" : \"Module 2\", \"scnArray\" : [ { \"name\" : \"सिनेरियो 1\", \"type\" : \"5\", \"uid\" : \"15958\", \"desc\" : \"Strengths and Weaknesses\", \"isComp\" : \"0\" }, { \"name\" : \"सिनेरियो 2\", \"type\" : \"5\", \"uid\" : \"15968\", \"desc\" : \"Your Key Differentiator\", \"isComp\" : \"0\" } ], \"type\" : \"4\", \"isLock\" : \"0\", \"uid\" : \"15957\", \"isComp\" : \"0\" }, { \"name\" : \"Mid Assessment\", \"scnArray\" : [ ], \"type\" : \"3\", \"isLock\" : \"0\", \"uid\" : \"15979\", \"isComp\" : \"0\" }, { \"name\" : \"Module 3\", \"scnArray\" : [ { \"name\" : \"सिनेरियो 1\", \"type\" : \"5\", \"uid\" : \"15981\", \"desc\" : \"Talking About The Company\", \"isComp\" : \"0\" }, { \"name\" : \"सिनेरियो 2\", \"type\" : \"5\", \"uid\" : \"15991\", \"desc\" : \"Discussing Salaries\", \"isComp\" : \"0\" } ], \"type\" : \"4\", \"isLock\" : \"0\", \"uid\" : \"15980\", \"isComp\" : \"0\" }, { \"name\" : \"Module 4\", \"scnArray\" : [ { \"name\" : \"सिनेरियो 1\", \"type\" : \"5\", \"uid\" : \"16003\", \"desc\" : \"Asking questions\", \"isComp\" : \"0\" }, { \"name\" : \"सिनेरियो 2\", \"type\" : \"5\", \"uid\" : \"16013\", \"desc\" : \"After The Interview\", \"isComp\" : \"0\" } ], \"type\" : \"4\", \"isLock\" : \"0\", \"uid\" : \"16002\", \"isComp\" : \"0\" }, { \"name\" : \"Post Assessment\", \"scnArray\" : [ ], \"type\" : \"3\", \"isLock\" : \"0\", \"uid\" : \"16024\", \"isComp\" : \"0\" } ] }";  
   
    var listJsonData = JSON.parse(msg);
    var listData = listJsonData["course"];
    Initialise(listData);
}

function Initialise(listData)
{
    
    if(listData != null && listData.length > 0)
    {
       for (var licount = 0;licount < parseInt(listData.length,10) ;licount ++)
       {
           var listDiv = document.createElement("div");
           listDiv.setAttribute("class", "dd-handleAssessMent col-xs-12 headerFontStylePhone fa");
           listDiv.setAttribute("onclick", "javascript:clickList('" + listData[licount].uid + "','" + listData[licount].type + "','" + listData[licount].name + "','" + listData[licount].action + "')");
           //listDiv.innerHTML = listData[licount].name;
           var colorDiv = "background:"+messageObj.WIDGET_BACKGROUD_COLOR+";"+"color:#4e4e4e";//+messageObj.WIDGET_TEXT_COLOR;
           listDiv.setAttribute("style",colorDiv);
            var listName = listData[licount].name;
           listName = listName.split(' ').join('&nbsp;');
           //listDiv.innerHTML  = listName.trim();
           
           var textDiv = document.createElement("div");
           textDiv.innerHTML  = listName.trim();
           textDiv.setAttribute("class", "fa textDiv");
           
           var updateImage = document.createElement("div");
           
           if(listData[licount].action != null && typeof(listData[licount].action) != "undefined" && listData[licount].action == 2 )
                    {
                       updateImage.setAttribute("class", "fa fa-refresh fa-stack-2x refreshImage");
                       //updateImage.setAttribute("onclick", "javascript:clickList('" + listData[licount].uid + "','" + listData[licount].type + "','" + listData[licount].name + "','" + listData[licount].action + "')"); 
                       listDiv.appendChild(updateImage);  
                    }
                    else if(listData[licount].action != null && typeof(listData[licount].action) != "undefined" && listData[licount].action == 1 )
                    {
                       updateImage.setAttribute("class", "fa fa-star fa-stack-2x refreshImage");
                       //updateImage.setAttribute("onclick", "javascript:clickList('" + listData[licount].uid + "','" + listData[licount].type + "','" + listData[licount].name + "','" + listData[licount].action + "')"); 
                       listDiv.appendChild(updateImage);  
                    }
                    else if(listData[licount].zipurl == "" && messageObj.MDB_BUY == 1 )
                    {
                        updateImage.setAttribute("class", "fa fa-lock fa-stack-2x refreshImage");
                       //updateImage.setAttribute("onclick", "javascript:clickUpdate('" + listData[licount].scnArray[scnListcount].uid + "','" + listData[licount].scnArray[scnListcount].type + "')"); 
                       listDiv.appendChild(updateImage);
                    }
                    else
                    {
                       //alert("amit"); 
                    }
           
           
           
           
           var updownImage = document.createElement("div");
           updownImage.setAttribute("class", "fa fa-check-square-o fa-stack-2x updownImageBlue");
           listDiv.appendChild(updownImage); 
           listDiv.appendChild(textDiv);
           if(parseInt(listData[licount].type,10) === 3 )
           {
             document.getElementById("mainId").appendChild(listDiv);
           }
           else if(parseInt(listData[licount].type,10) === 4)
           {
              
               for(var scnListcount =0 ; scnListcount < parseInt(listData[licount].scnArray.length); scnListcount++ )
               {
                   var listscnDiv = document.createElement("div");
                   
                   listscnDiv.setAttribute("class", "dd-handleModule col-xs-12 headerFontStylePhone fa");
                   var listName = listData[licount].scnArray[scnListcount].name;
                   listName = listName.split(' ').join('&nbsp;');
                   
                   var textDiv = document.createElement("div");
                    textDiv.innerHTML  = listName.trim();
                   textDiv.setAttribute("class", "fa textDiv");
           
                   
                   //listscnDiv.innerHTML = listName.trim();
                   listscnDiv.setAttribute("onclick", "javascript:clickList('" + listData[licount].scnArray[scnListcount].uid + "','" + listData[licount].scnArray[scnListcount].type + "','" + listData[licount].scnArray[scnListcount].name + "','" + listData[licount].scnArray[scnListcount].action + "')");
                   var colorDiv = "background:#ffffff;"+"color:#4e4e4e"; //+messageObj.WIDGET_TEXT_COLOR;
                    listscnDiv.setAttribute("style",colorDiv);
                   document.getElementById("mainId").appendChild(listscnDiv);
                   
                    var updownImage = document.createElement("div");
                    //var dId = "su" + scnListcount;
                    //updownImage.setAttribute("id", dId);
                    //updownImage.setAttribute("onclick","javascript:changeColor('"+i+"','"+modl_Data[i].uid+"','"+modl_Data[i].type+"')");
                    updownImage.setAttribute("class", "fa fa-play-circle fa-stack-2x updownImage");
                    listscnDiv.appendChild(updownImage);
                    
                    listscnDiv.appendChild(textDiv);
                    
                    var updateImage = document.createElement("div");
                    
                    //var dId = "su" + scnListcount;
                    //updownImage.setAttribute("id", dId);
                    //updownImage.setAttribute("onclick","javascript:changeColor('"+i+"','"+modl_Data[i].uid+"','"+modl_Data[i].type+"')");
                    
                    
                    if(listData[licount].scnArray[scnListcount].action != null && typeof(listData[licount].scnArray[scnListcount].action) != "undefined" && listData[licount].scnArray[scnListcount].action == 2 )
                    {
                       updateImage.setAttribute("class", "fa fa-refresh fa-stack-2x refreshImage");
                       //updateImage.setAttribute("onclick", "javascript:clickList('" + listData[licount].scnArray[scnListcount].uid + "','" + listData[licount].scnArray[scnListcount].type + "','" + listData[licount].scnArray[scnListcount].name + "','" + listData[licount].scnArray[scnListcount].action + "')"); 
                       listscnDiv.appendChild(updateImage);  
                    }
                    else if(listData[licount].scnArray[scnListcount].action != null && typeof(listData[licount].scnArray[scnListcount].action) != "undefined" && listData[licount].scnArray[scnListcount].action == 1 )
                    {
                       updateImage.setAttribute("class", "fa fa-star fa-stack-2x refreshImage");
                       //updateImage.setAttribute("onclick", "javascript:clickList('" + listData[licount].scnArray[scnListcount].uid + "','" + listData[licount].scnArray[scnListcount].type + "','" + listData[licount].scnArray[scnListcount].name + "','" + listData[licount].scnArray[scnListcount].action + "')"); 
                       listscnDiv.appendChild(updateImage);  
                    }
                    else if(listData[licount].scnArray[scnListcount].zipurl == "" && messageObj.MDB_BUY == 1 )
                    {
                        updateImage.setAttribute("class", "fa fa-lock fa-stack-2x refreshImage");
                       //updateImage.setAttribute("onclick", "javascript:clickUpdate('" + listData[licount].scnArray[scnListcount].uid + "','" + listData[licount].scnArray[scnListcount].type + "')"); 
                       listscnDiv.appendChild(updateImage);
                    }
                    else
                    {
                       //alert("amit"); 
                    }
                    
                    

                    
                   
                   
                   
               }
                
           }
        }
    }
    else
    {
        
    }
    
}

function clickUpdate(uid , type)
{
    //alert("click Update");
    var obj = new Object();
    obj.uid = uid;
    if(OSType == "IOS")
        {
            obj.type = type.toString();
            var status = 2;
            obj.status = status.toString(); //update
            var jsonString = JSON.stringify(obj);
            iOSInterface.send(jsonString);
        }
        else
        {
            obj.type = type;
            var jsonString = JSON.stringify(obj);
            JSInterface.setMCatLogResp(jsonString);
        }
        
    e = window.event;
    e.stopPropagation();
}

function showModalAlert()
{

    document.getElementById("modal").style.display = "block";
    document.getElementById("fadeout").height = documentHeight();
    document.getElementById("fadeout").style.display = "block";


    //var text = "You are registering for a live webinar session with our expert '"+name+"' on'"+data+"' scheduled for '"+time+"'. Click CONFIRM to book your slot or CANCEL to go back.";
    document.getElementById("modalDynamicText").innerHTML =  "Please complete previous Module.";''  

}

function closeModalAlert()
{
    //document.getElementById("resultSpan").innerHTML = document.getElementById("finput").value;
    document.getElementById("modal").style.display = "none";
    document.getElementById("fadeout").style.display = "none";

    showModal("submit score on server");
    if(tokenValue == null)
    {  
      var jsonData = makeJsonRequest();
      sendtoServerRequest(jsonData, "auth");
    }
    else
    {
        var reqData = makePushDataReqJson();
        sendtoServerRequest(reqData, "submitScore");  
    }
}


function documentHeight() {
    return Math.max(
        window.innerHeight,
        document.body.offsetHeight,
        document.documentElement.clientHeight
    );
}
function showDownloadPrgress()
{

    document.getElementById("Modelbar").style.display = "block";
    document.getElementById("fadeout").height = documentHeight();
    document.getElementById("fadeout").style.display = "block";

}

function closeDownloadPrgress()
{

    document.getElementById("Modelbar").style.display = "none";
    document.getElementById("fadeout").style.display = "none";


}


function showDownloadPrgressBar()
{
    //document.getElementById("progressCancelId").disabled = false; 
    document.getElementById("progressID").style.display = "block";
    //document.getElementById("progressCancelId").style.color ='#5dc9e6';
    document.getElementById("fadeout").height = documentHeight();
    document.getElementById("fadeout").style.display = "block";
    document.getElementById("fillprogressID").style.width = "0%";

}
function closeDownloadPrgressBarCall()
{
   var obj = new Object();
    obj.uid =""
    obj.type = "cancel";
    var jsonString = JSON.stringify(obj);
    //  dbgAlert("handleLearningClick called final"+jsonString);
     //JSInterface.setMCatLogResp(jsonString);
   JSInterface.send(jsonString);
}
function closeDownloadPrgressBar()
{


    document.getElementById("progressID").style.display = "none";
    document.getElementById("fadeout").style.display = "none";


}

function showAlert(text)
{
    document.getElementById("alertID").style.display = "block";
    document.getElementById("fadeout").height = documentHeight();
    document.getElementById("fadeout").style.display = "block";

    document.getElementById("displayMSG").innerHTML = text;
}

function closeAlert()
{
    //document.getElementById("resultSpan").innerHTML = document.getElementById("finput").value;
    document.getElementById("alertID").style.display = "none";
    document.getElementById("fadeout").style.display = "none";
}

function clickList(uid,type,name,_status)
{
    
    //alert("click download");
    var obj = new Object();
    obj.uid = uid;
    if(OSType == "IOS")
        {
            obj.type = type.toString();
            obj.name = name.toString();
            var status = _status;
            obj.status = status.toString(); //normal
            var jsonString = JSON.stringify(obj);
            iOSInterface.send(jsonString);
        }
        else
        {
            obj.type = type;
            var jsonString = JSON.stringify(obj);
            JSInterface.setMCatLogResp(jsonString);
        }
    //alert("handleLearningClick called final"+jsonString);
   //JSInterface.setMCatLogResp(jsonString);
   
}
            

    

