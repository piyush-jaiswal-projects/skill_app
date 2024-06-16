/*
liqvid basic communication with native platform 
(c) Liqvid E-Learning Services Pvt. Ltd. 2014-15

This is the pure javascript implementation of the Native platform - as if the native platform is Javascript 
This implementation can be used for online flavors of CAP 
*/
var resp;
LiqNative = {
    loadFileIntoString: function(fileUrl) {
        /* Loads any file into String */
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp=new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.open("GET","http://dev.englishedge.in/live/xmlfetch.php?file="+fileUrl,false);
        //xmlhttp.open("GET",fileUrl,false);
        xmlhttp.send();
        xmlDoc=xmlhttp.responseText;
        return xmlDoc;
    },

    convertFileLocToUrl: function(fileLoc) {
        //var url = fileLoc.replace(/PracticeApp\/course/g, "http://dev.englishedge.in/live/unzips/course.au");
        return fileLoc;
    },

    send : function(eventObj) {
       if(LiqCommon.isDefined(JSInterface))
            JSInterface.send(JSON.stringify(eventObj));
    },

    recieve : function(eventObj,cbkFoo) {
       // alert("recieve message :"+eventObjStr+"\n"+JSON.stringify(eventObjStr));
       // var eventObj = jQuery.parseJSON( eventObjStr )
       
        
       LiqCommon.trigger(eventObj);
       
        if(LiqCommon.isDefined(cbkFoo))
        {
            //resp= "Amit gupta";
            cbkFoo(resp);
        }
        
            
             //return resp;
    }
};
