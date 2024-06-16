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
                jsObject.data = 11;
                var dataval = JSON.stringify(jsObject);
                bridge.send(dataval, function (responseData) {
                    messageObj = JSON.parse(responseData);
                });
                var jsObject = new Object();
                jsObject.type = "drawData";
                jsObject.data = 12;
                var dataval = JSON.stringify(jsObject);
                bridge.send(dataval, function (responseData) {
                    var msg = responseData;
                    var regex = new RegExp('%22','g');
                    var regex1 = new RegExp('%20','g');
                    msg = msg.replace(regex, '"');
                    msg = msg.replace(regex1, ' ');
                    //alert(msg);
                    var listJsonData = JSON.parse(msg);
                    Initialise(listJsonData); 
                    
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

                    var data = {'Javascript Responds': 'Wee!'}
                    responseCallback(data)
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
                var jsonval = JSInterface.initialise(12);
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
                
                var listJsonData = JSON.parse(msg);
                
                Initialise(listJsonData);   
            }
            
            
            function Initialise(listJsonData) 
            {
                var colorBG = "background:"+messageObj.BACKGROUND_COLOR;
                document.getElementsByTagName("body")[0].setAttribute("style",colorBG);
                
                
                 var chapter = document.createElement("div");
                 document.getElementById("mainId").appendChild(chapter);
                 chapter.setAttribute("class","Activity");
                 var chapterLbl = document.createElement("div");
                 chapterLbl.innerHTML = listJsonData.name;
                 chapterLbl.setAttribute("class","textLabel");
                 var colorIcon = "color:"+messageObj.TEXT_COLOR;
                 chapterLbl.setAttribute("style",colorIcon);
                 chapter.appendChild(chapterLbl);
                
                 var listArr = listJsonData.capArray;
                 var componantArr;
                 if(listArr.length == 2){
                     componantArr = listArr[0].contentArray.concat(listArr[1].contentArray);
                 }
                 else
                 {
                     componantArr = listArr[0].contentArray;
                 }
                
                 if(componantArr.length > 1)
                 {
                   componantArr.sort(function(a, b){
                      return a.comp_sequence - b.comp_sequence
                   })
                 }
                var drawFlag = true;
                var practice = document.createElement("div");
                practice.setAttribute("class","Practice");
                
                var practiceLbl = document.createElement("div");
                practice.appendChild(practiceLbl);
                document.getElementById("mainId").appendChild(practice);
                
                for(var i =0; i<componantArr.length;i)
                {
                  if(i==0 || i==(componantArr.length-1)){
                      drawPracticeOne(componantArr[i],practice);
                      i = i+1;
                   }else {
                      drawPracticeTwo(componantArr[i],componantArr[i+1],practice);
                    i = i+2;
                   }
                }
                
        }
            
     function drawPracticeOne(Obj,divId)
            {
               var onePractice = document.createElement("div");
               onePractice.setAttribute("class","col-xs-12 contaner text-center");
               divId.appendChild(onePractice);
               var circle = document.createElement("div");
                if(Obj.type == "11")
                {
                  circle.setAttribute("onclick", "javascript:handleLearningItemClick('" + Obj.uid + "','" + Obj.type + "','" + Obj.name + "','" + JSON.stringify(Obj.data) + "')");
                }
                else
                {
                    circle.setAttribute("onclick", "javascript:handleLearningItemClick('" + Obj.uid + "','" + Obj.type + "','" + Obj.name + "','" + Obj.data + "')");
                 }
               
                     
               onePractice.appendChild(circle);
               addIconImage(circle,parseInt(Obj.type,10),parseInt(Obj.isComp,10),Obj.comp_Image);
               
               
               var ConceptText = document.createElement("div");
                     ConceptText.setAttribute("class","name");
            
                     ConceptText.innerHTML = Obj.name;
                     
                     var colorIcon = "color:"+messageObj.TEXT_COLOR;
                 
                      
                      ConceptText.setAttribute("style",colorIcon);
                     onePractice.appendChild(ConceptText);
               
               
               
               
                  
                      
            }
            function drawPracticeTwo(Obj1,Obj2,divId)
            {
               var Practice = document.createElement("div");   
               Practice.setAttribute("class","col-xs-12 contaner text-center");
               divId.appendChild(Practice);
               
               var onePractice = document.createElement("div");   
               onePractice.setAttribute("class","col-xs-6");
               if(Obj1.type == "11")
               {
                   onePractice.setAttribute("onclick", "javascript:handleLearningItemClick('" + Obj1.uid + "','" + Obj1.type + "','" + Obj1.name + "','" + JSON.stringify(Obj1.data) + "')");
               }
               else
               {
                    onePractice.setAttribute("onclick", "javascript:handleLearningItemClick('" + Obj1.uid + "','" + Obj1.type + "','" + Obj1.name + "','" + Obj1.data + "')");
               }
               Practice.appendChild(onePractice);
                
                
                
               var oneinner1Practice = document.createElement("div");
               onePractice.appendChild(oneinner1Practice);
               addIconImage(oneinner1Practice , parseInt(Obj1.type,10),parseInt(Obj1.isComp,10),Obj1.comp_Image);
                
               var ConceptText = document.createElement("div");
               ConceptText.setAttribute("class","name");
               ConceptText.innerHTML = Obj1.name;
               var colorIcon = "color:"+messageObj.TEXT_COLOR;
               ConceptText.setAttribute("style",colorIcon);
               onePractice.appendChild(ConceptText);
                
               var twoPractice = document.createElement("div");
               twoPractice.setAttribute("class","col-xs-6");
                if(Obj2.type == "11")
                {
                  twoPractice.setAttribute("onclick", "javascript:handleLearningItemClick('" + Obj2.uid + "','" + Obj2.type + "','" + Obj2.name + "','" + JSON.stringify(Obj2.data) + "')");
                }
                else
                {
                    twoPractice.setAttribute("onclick", "javascript:handleLearningItemClick('" + Obj2.uid + "','" + Obj2.type + "','" + Obj2.name + "','" + Obj2.data + "')");
                }
                Practice.appendChild(twoPractice);
                var oneinner2Practice = document.createElement("div");
                twoPractice.appendChild(oneinner2Practice);
                addIconImage(oneinner2Practice , parseInt(Obj2.type,10),parseInt(Obj2.isComp,10),Obj2.comp_Image);
                
                var ConceptText = document.createElement("div");
                ConceptText.setAttribute("class","name");
                ConceptText.innerHTML = Obj2.name;
                var colorIcon = "color:"+messageObj.TEXT_COLOR;
                ConceptText.setAttribute("style",colorIcon);
                twoPractice.appendChild(ConceptText);
             }
            
            function addIconImage(divId,type,isComp,comp_Image )
            {
                  
                  if(type == 6 && comp_Image == "")
                  {
                      comp_Image = "concept.png"
                  }
                  else if(type == 25 && comp_Image == "")
                  {
                      comp_Image = "conversation.png"
                  }
                  else if(type == 11 && comp_Image == "")
                  {
                    comp_Image = "game.png"
                  }
                  else if(type == 24 && comp_Image == "")
                  {
                      comp_Image = "resources.png"
                  }
                  else if(type == 21 && comp_Image == "")
                  {
                      comp_Image = "practice.png"
                  }
                  else if(type == 22 && comp_Image == "")
                  {
                      comp_Image = "speedreading.png"
                  }
                  else if(type == 9 && comp_Image == "")
                  {
                      comp_Image = "roleplay.png"
                  }
                  else if(type == 10 && comp_Image == "")
                  {
                      comp_Image = "vocabulary.png"
                  }
                  
               // alert(type);
                   if(isComp ===  1)
                    {
                        divId.setAttribute("class","CircleDefault Cwheel compIconColor");
                       var colorDiv = "background:"+messageObj.COMPONANT_ICON_BACKGROUND_COLOR_DISABLE+ ";"+messageObj.COMPONANT_C_COLOR;
                       divId.setAttribute("style",colorDiv);
                        var Image = "<img height=\"70px\" width=\"70px\" src="+comp_Image+" alt=\"\">";
                        divId.innerHTML =Image;
                    }
                    else if(isComp ===  0)
                    {
                        divId.setAttribute("class","CircleDefault NCwheel compIconColor");
                       var colorDiv = "background:"+messageObj.COMPONANT_ICON_BACKGROUND_COLOR_DISABLE+ ";"+messageObj.COMPONANT_NC_COLOR;
                       divId.setAttribute("style",colorDiv);
                        var Image = "<img style=\"transform:rotateZ(-45deg);\" height=\"70px\" width=\"70px\" src="+comp_Image+" alt=\"\">";
                        divId.innerHTML =Image;
                    }
                    else
                    {
                        divId.setAttribute("class","CircleDefault NAwheel iconColor");
                        var colorDiv = "background:"+messageObj.COMPONANT_ICON_BACKGROUND_COLOR_DISABLE+ ";"+messageObj.COMPONANT_NA_COLOR;
                        divId.setAttribute("style",colorDiv);
                        var Image = "<img height=\"70px\" width=\"70px\" src="+comp_Image+" alt=\"\">";
                        divId.innerHTML =Image;
                     }
                
            }
            function handleLearningItemClick(varId, varType,name,data)
            {
             
                var obj = new Object();
                obj.uid = varId;
                obj.type = varType;
                obj.name = name;
                obj.data = data;
                var jsonString = JSON.stringify(obj);
                    
                if(OSType == "IOS")
                {
                    
                    iOSInterface.send(jsonString);
                }
                else
                {
                    JSInterface.setScnCatLogResp(jsonString);
                }
            }
            
            
            
