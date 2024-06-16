/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var JSInterface;

var ConceptXmlData;
var conceptName;
window.onerror = function (err) {
                //log('window.onerror: ' + err)
            }

            function connectWebViewJavascriptBridge(callback) {
                if (window.WebViewJavascriptBridge) {
                    callback(WebViewJavascriptBridge)
                } else {
                    document.addEventListener('WebViewJavascriptBridgeReady', function () {
                        callback(WebViewJavascriptBridge)
                    }, false)
                }
            }

            connectWebViewJavascriptBridge(function (bridge) {
                 JSInterface = bridge;
                     
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
                
                bridge.init (function (message, responseCallback) {
                    //alert(message);
                  var data  = LiqNative.recieve(JSON.parse(message),responseCallback);
                    //alert(message);
                    //log('JS responding with', data)
                    //responseCallback(data)
                })
                //bridge.recieve= LiqNative.recieve;
                

                bridge.registerHandler('testJavascriptHandler', function (data, responseCallback) {
                   
                    var responseData = {'Javascript Says': 'Right back atcha!'}
                   
                    responseCallback(responseData)
                })
                
                 var jsObject = new Object();
                   jsObject.event = "ccvid_getXmlFileData";
                   jsObject.eventData ="";
                   var dataval = JSON.stringify(jsObject);
                   bridge.send(dataval,function (responseData) {
                       
                       
                       var data = JSON.parse(responseData);
                       //alert(data.xmlText);
                       //var parser=new DOMParser();
                       
                       ConceptXmlData = JSON.stringify(data.xmlText);
                       conceptName = data.name;
                       //alert(conceptName);
                      //ConceptXmlData=parser.parseFromString(JSON.stringify(data.xmlText),"text/xml");
                       var stEv = new Object();
                       
                        stEv.event="liqStartOperation";
                        stEv.eventData = null;
                        LiqNative.recieve(stEv);   
                          
                     })    
                   
                
                }); 