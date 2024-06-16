/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function loadjscssfile(filename, filetype) {
    if (filetype === "js") { //if filename is a external JavaScript file
        var fileref = document.createElement('script');
        fileref.setAttribute("type", "text/javascript");
        fileref.setAttribute("src", filename);
    }
    else if (filetype === "css") { //if filename is an external CSS file
        var fileref = document.createElement("link");
        fileref.setAttribute("rel", "stylesheet");
        fileref.setAttribute("type", "text/css");
        fileref.setAttribute("href", filename);
    }
    if (typeof fileref !== "undefined")
        document.getElementsByTagName("head")[0].appendChild(fileref);
}

function osCall()
{
    //loadjscssfile("jquery.easy-pie-chart.js", "js");
    $('#submitBtn').addClass("btnDisable");
    document.getElementById('submitBtn').disabled = true;
    $("#nextBtnDiv").hide();
    el = document.getElementById('showquesAttempt');
    var deviceheight = $(window).height();
    var devicewidth = $(window).width();
    //alert(deviceheight);
    //alert(devicewidth);


    if (deviceheight > 420) {
        $(".contentMidAnsDiv").css("padding-top", "15px");
    }
    if (deviceheight >= 960) {
        $(".showAnsDiv").css("height", "60%");
    }
    else if (deviceheight >= 504) {
        $(".showAnsDiv").css("height", "60%");
    }


    //nxt = document.getElementById('nextBtnDiv');
    fontAdjustment = 60 / document.documentElement.clientWidth;
    window.onresize();
    /////);
    ///// start hide local
//    var msg = "{\"SUBMIT\":\"Submit\",\"NEXT\":\"Continue\",\"MCQ_RIGHT_ANS_HAI\":\"Right Ans is \",\"MCQ_CONT\":\"Continue\"}";
//    var str = "{\"uid\" : \"31841\",\"path\" : {\"assess\" : {\"name\" : {\"text\" : \"Practice MCQ\"},\"question\" : [{\"uniqid\" : \"practice_sc_867.4\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the most suitable word.\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"fb\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"India Gate is located in FITB?\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : {\"uniqid\" : \"practice_sc_867.4.1\",\"text\" : \"Delhi\"}},\"image\" : {\"text\" : \"media\/test.jpeg\",\"is_filled\" : \"true\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_867.5\",\"audio\" : {\"text\" : \"media\/test.mp3\",\"is_filled\" : \"true\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the most suitable word.\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"pw\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Question stem goes here?\"},\"random_options\" : {\"text\" : \"\",\"option\" : [{\"position\" : \"0\",\"text\" : \"ABCDEFGH\"},{\"position\" : \"2\",\"text\" : \"ABCDEFGH\"},{\"position\" : \"0\",\"text\" : \"ABCDEFGH\"},{\"position\" : \"0\",\"text\" : \"ABCDEFGH\"},{\"position\" : \"0\",\"text\" : \"ABCDEFGH\"},{\"position\" : \"0\",\"text\" : \"ABCDEFGH\"}]},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"uniqid\" : \"practice_sc_867.5.1\",\"content\" : {\"text\" : \"ABCDEFGH\",\"is_filled\" : \"true\"},\"text\" : \"\"},{\"uniqid\" : \"practice_sc_867.5.2\",\"content\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\"},{\"uniqid\" : \"practice_sc_867.5.3\",\"content\" : {\"text\" : \"ABCDEFGH\",\"is_filled\" : \"true\"},\"text\" : \"\"},{\"uniqid\" : \"practice_sc_867.5.4\",\"content\" : {\"text\" : \"ABCDEFGH\",\"is_filled\" : \"true\"},\"text\" : \"\"},{\"uniqid\" : \"practice_sc_867.5.5\",\"content\" : {\"text\" : \"ABCDEFGH\",\"is_filled\" : \"true\"},\"text\" : \"\"},{\"uniqid\" : \"practice_sc_867.5.5\",\"content\" : {\"text\" : \"ABCDEFGH\",\"is_filled\" : \"true\"},\"text\" : \"\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.8\",\"audio\" : {\"text\" : \"media\/test.mp3\",\"is_filled\" : \"true\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"dd\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Arrange the following rivers in descending order of the length\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"position\" : {\"text\" : \"3\"},\"content\" : {\"text\" : \"Yangtze\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.8.1\"},{\"position\" : {\"text\" : \"2\"},\"content\" : {\"text\" : \"Amazon\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.8.2\"},{\"position\" : {\"text\" : \"1\"},\"content\" : {\"text\" : \"Nile\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.8.3\"},{\"position\" : {\"text\" : \"4\"},\"content\" : {\"text\" : \"Mississippi\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.8.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.1\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"One of the following is not a place of religious importance\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"Puri\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.1.1\"},{\"content\" : {\"text\" : \"The Vatican\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.1.2\"},{\"content\" : {\"text\" : \"Jerusalem\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.1.3\"},{\"content\" : {\"text\" : \"Riyadh\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.1.4\"}]},\"image\" : {\"text\" : \"media\/test.jpeg\",\"is_filled\" : \"true\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.2\",\"audio\" : {\"text\" : \"media\/test.mp3\",\"is_filled\" : \"true\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Scuba diving is a part of\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"Farm Tourism\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.2.1\"},{\"content\" : {\"text\" : \"Heritage Tourism\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.2.2\"},{\"content\" : {\"text\" : \"Adventure Tourism\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.2.3\"},{\"content\" : {\"text\" : \"Religious Tourism\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.2.4\"}]},\"image\" : {\"text\" : \"media\/test.jpeg\",\"is_filled\" : \"true\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.3\",\"audio\" : {\"text\" : \"media\/test.mp3\",\"is_filled\" : \"true\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Parasailing means\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"Flying in air\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.3.1\"},{\"content\" : {\"text\" : \"Flying above sea\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.3.2\"},{\"content\" : {\"text\" : \"taking help of a motor boat\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.3.3\"},{\"content\" : {\"text\" : \"Gliding in the air\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.3.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.4\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Which is the largest island in the world?\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"GreenlandGreenlandGreenlandGreenland\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.4.1\"},{\"content\" : {\"text\" : \"Madagascar\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.4.2\"},{\"content\" : {\"text\" : \"Great Britain\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.4.3\"},{\"content\" : {\"text\" : \"New Guinea\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.4.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"media\/test.mp4\",\"is_filled\" : \"true\"}},{\"uniqid\" : \"practice_sc_724.5\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"'To enjoy a camel safari, you need to visit'\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"Rann of Kutch\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.5.1\"},{\"content\" : {\"text\" : \"Kolkata\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.5.2\"},{\"content\" : {\"text\" : \"Pondicherry\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.5.3\"},{\"content\" : {\"text\" : \"Jaisalmer\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.5.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.6\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Kaziranga National Park is located in\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"Tamil Nadu\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.6.1\"},{\"content\" : {\"text\" : \"Uttar Pradesh\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.6.2\"},{\"content\" : {\"text\" : \"Assam\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.6.3\"},{\"content\" : {\"text\" : \"Kerela\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.6.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.7\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Leisure is ____________ activity\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"important\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.7.1\"},{\"content\" : {\"text\" : \"fun-filled\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.7.2\"},{\"content\" : {\"text\" : \"peaceful\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.7.3\"},{\"content\" : {\"text\" : \"all of these\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.7.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.9\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"mc\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Fatehpur Sikhri is close to\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"content\" : {\"text\" : \"Agra\"},\"is_correct\" : {\"text\" : \"true\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.9.1\"},{\"content\" : {\"text\" : \"Puri\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.9.2\"},{\"content\" : {\"text\" : \"Varanasi\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.9.3\"},{\"content\" : {\"text\" : \"Srinagar\"},\"is_correct\" : {\"text\" : \"false\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.9.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}},{\"uniqid\" : \"practice_sc_724.10\",\"audio\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"text\" : \"\",\"instruction\" : {\"text\" : \"Choose the correct answer\"},\"format\" : {\"text\" : \"\",\"qform\" : {\"text\" : \"t\"},\"delivery\" : {\"text\" : \"dd\"},\"aform\" : {\"text\" : \"t\"}},\"content\" : {\"text\" : \"Arrange the following in ascending order\"},\"answers\" : {\"choice\" : \"single\",\"served\" : \"random\",\"display_time\" : \"0\",\"text\" : \"\",\"answer\" : [{\"position\" : {\"text\" : \"4\"},\"content\" : {\"text\" : \"Continent\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.10.1\"},{\"position\" : {\"text\" : \"3\"},\"content\" : {\"text\" : \"Country\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.10.2\"},{\"position\" : {\"text\" : \"1\"},\"content\" : {\"text\" : \"City\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.10.3\"},{\"position\" : {\"text\" : \"2\"},\"content\" : {\"text\" : \"State\"},\"text\" : \"\",\"uniqid\" : \"practice_sc_724.10.4\"}]},\"image\" : {\"text\" : \"\",\"is_filled\" : \"false\"},\"video\" : {\"text\" : \"\",\"is_filled\" : \"false\"}}],\"text\" : \"\",\"description\" : {\"text\" : \"Description\"},\"delivery\" : {\"selection\" : {\"text\" : \"10\"},\"text\" : \"\",\"max_minutes\" : {\"text\" : \"30\"},\"flow\" : {\"text\" : \"random\"}},\"uniqid\" : \"practice_sc_724\"}},\"name\" : \"Completed\"}";
//    //    //alert(str);
//    messageObj = JSON.parse(msg);
//    var data = JSON.parse(str);
//    xmlObject = data.path;
//    practiceName = data.name;
//    parseXmlData(xmlObject);
    ///// end hide local
    
    
    
    
    
    (function($) {
     $.fn.hasScrollBar = function() {
     return this.get(0).scrollHeight > this.height();
     }
     })(jQuery);
    
    if($('#midMCQAnsTypeDiv').hasScrollBar()){
        $("#midMCQAnsTypeDiv").addClass("shadow-bottom");
    }
    
    var lastScrollTop = 0;
    $(".ansType").scroll(function() {
                         var scroll = $(".ansType").scrollTop();
                         if (scroll > lastScrollTop) {
                         $(".ansType").addClass("shadow-top");
                         $("#midMCQAnsTypeDiv").removeClass("shadow-bottom");
                         }
                         else {
                         $(".ansType").removeClass("shadow-top");
                         $("#midMCQAnsTypeDiv").addClass("shadow-bottom");
                         }
                         lastScrollTop = scroll;
                         })

}

////// ########## CodeshowQuesAttempt






function showQuesAttempt() {
    
    if (isQuiz == 3)
    {
        return;
    }
      
    $("#nextBtnDiv").show();
    $("#submitDiv").hide();

    document.getElementById("nextBtn").innerHTML = messageObj.MCQ_CONT;
    var response = new Object();
    response.test_uniqid = edgeId;
    response.ques_uniqid = currentObject.uniqid;

    var dt = (new Date()).getTime();
    response.date_ms = (dt - renderTime);
    updateIfExistObj(response);



    if (currentObject.format.delivery.text == "mc") {

        if (currentObject.iscorrect == 'true')
        {
            response.ans_uniqid = 1;
            playSound(right_answer_sound);
            totelNumberofRightQuestion++;
            $(".showquesAttempt").show();
            $(".showCorrectAnsDiv").show();
            $(".showWrongAnsDiv").hide();

            document.getElementById("ansRightPara").innerHTML = currentObject.text;

            //$("#ansRightPara").text(currentObject.text);
        }
        else if (currentObject.iscorrect == 'false')
        {
            // totelNumberofRightQuestion ++;
            response.ans_uniqid = 0;
            playSound(wrong_answer_sound);
            $(".showquesAttempt").show();
            $(".showWrongAnsDiv").show();
            $(".showCorrectAnsDiv").hide();

            document.getElementById("ansWrongPara").innerHTML = messageObj.MCQ_RIGHT_ANS_HAI + ": " + currentObject.text;


            //$("#ansWrongPara").text(messageObj.MCQ_RIGHT_ANS_HAI +": "+ currentObject.text);
        }
        else
        {

        }
    }
    else if (currentObject.format.delivery.text == "dd")
    {
        var str = "";
        for (var i = 0; i < currentObject.answers.answer.length; i++) {
            str = str + " " + currentObject.answers.answer[i].content.text;
            ;
        }


        if (currentObject.reprintObj.ddAnsArray.length < currentObject.answers.answer.length)
        {
            response.ans_uniqid = 0;
            playSound(wrong_answer_sound);
            $(".showquesAttempt").show();
            $(".showWrongAnsDiv").show();
            $(".showCorrectAnsDiv").hide();

            document.getElementById("ansWrongPara").innerHTML = messageObj.MCQ_RIGHT_ANS_HAI + ": " + str;

            //$("#ansWrongPara").text(messageObj.MCQ_RIGHT_ANS_HAI +": "+str);
        }
        else
        {
            var sequence = 0;
            for (var i = 0; i < currentObject.reprintObj.ddAnsArray.length; i++) {
                var opt = currentObject.reprintObj.ddAnsArray[i];
                var strNum = i + 1;
                if (opt.answer_postion.text == strNum.toString())
                {

                }
                else
                {
                    sequence = 1;
                    break;
                }
            }

            if (sequence == 0)
            {
                response.ans_uniqid = 1;
                playSound(right_answer_sound);
                totelNumberofRightQuestion++;
                $(".showquesAttempt").show();
                $(".showCorrectAnsDiv").show();
                $(".showWrongAnsDiv").hide();

                document.getElementById("ansRightPara").innerHTML = str;


                //$("#ansRightPara").text(str);
            }
            else
            {
                response.ans_uniqid = 0;
                playSound(wrong_answer_sound);
                $(".showquesAttempt").show();
                $(".showWrongAnsDiv").show();
                $(".showCorrectAnsDiv").hide();

                document.getElementById("ansWrongPara").innerHTML = messageObj.MCQ_RIGHT_ANS_HAI + ": " + str;
                //$("#ansWrongPara").text(messageObj.MCQ_RIGHT_ANS_HAI +": "+ str); 
            }
        }




    } else if (currentObject.format.delivery.text == "pw")
    {
        if (typeof(currentObject.reprintObj.globaloption.answer_postion) != 'undefined' &&  currentObject.reprintObj.globaloption.answer_postion.toString() == currentObject.reprintObj.globaloption.postion.toString())
        {
            response.ans_uniqid = 1;
            playSound(right_answer_sound);
            totelNumberofRightQuestion++;
            $(".showquesAttempt").show();
            $(".showCorrectAnsDiv").show();
            $(".showWrongAnsDiv").hide();

            document.getElementById("ansRightPara").innerHTML = currentObject.text;
            //$("#ansRightPara").text(currentObject.text);  
        }
        else
        {
            response.ans_uniqid = 0;
            playSound(wrong_answer_sound);
            $(".showquesAttempt").show();
            $(".showWrongAnsDiv").show();
            $(".showCorrectAnsDiv").hide();
            document.getElementById("ansWrongPara").innerHTML = messageObj.MCQ_RIGHT_ANS_HAI + ": " + currentObject.text;

            // $("#ansWrongPara").text(messageObj.MCQ_RIGHT_ANS_HAI +": "+ currentObject.text);  
        }
    }
    else if (currentObject.format.delivery.text == "fb")
    {
        var value = document.getElementById("inputId").value;
        if (value == null || value == "")
        {
            return;
        }
        else
        {
            //alert(currentObject.answers.answer.text) ; 
            if (currentObject.answers.answer.text == value)
            {
                response.ans_uniqid = 1;

                totelNumberofRightQuestion++;
                setTimeout(function () {
                    $(".showquesAttempt").show();
                    $(".showCorrectAnsDiv").show();
                    $(".showWrongAnsDiv").hide();
                    playSound(right_answer_sound);
                }, 500);
                document.getElementById("ansRightPara").innerHTML = currentObject.answers.answer.text;

                //$("#ansRightPara").text(currentObject.answers.answer.text);  
            }
            else
            {
                response.ans_uniqid = 0;

                setTimeout(function () {
                    $(".showquesAttempt").show();
                    $(".showWrongAnsDiv").show();
                    $(".showCorrectAnsDiv").hide();
                    playSound(wrong_answer_sound);
                }, 500);

                document.getElementById("ansWrongPara").innerHTML = messageObj.MCQ_RIGHT_ANS_HAI + ": " + currentObject.answers.answer.text

                //$("#ansWrongPara").text(messageObj.MCQ_RIGHT_ANS_HAI +": "+ currentObject.answers.answer.text);
            }
        }
    }

    $("#starcountid").text(totelNumberofRightQuestion + '/' + totelNumberOfQuestion);
    stopAudioVideo();
    CloseAudioVideo();
}




//  for next Question

function showAssessmentQuesAttemptNext() {
    
    if(currentQuestion == totelNumberOfQuestion) return;

    var response = new Object();
    response.test_uniqid = edgeId;
    response.ques_uniqid = currentObject.uniqid;
    response.ans_uniqid = 0;

    var dt = (new Date()).getTime();
    response.date_ms = (dt - renderTime);
    
    updateIfExistObj(response);
    currentObject.reprintObj.isAns = true;




    if (currentObject.format.delivery.text == "mc") {
        currentObject.reprintObj.mcObj = currentObject.userAnswerObj;
        if (currentObject.iscorrect == 'true')
        {
            response.ans_uniqid = 1;
            totelNumberofRightQuestion++;
        }
        else if (currentObject.iscorrect == 'false')
        {
            response.ans_uniqid = 0;
        }
        else
        {

        }
    }
    else if (currentObject.format.delivery.text == "dd")
    {
        var str = "";
        for (var i = 0; i < currentObject.answers.answer.length; i++) {
            str = str + " " + currentObject.answers.answer[i].content.text;
            ;
        }



        if (currentObject.reprintObj.ddAnsArray.length < currentObject.answers.answer.length)
        {
            response.ans_uniqid = 0;

        }
        else
        {
            var sequence = 0;
            for (var i = 0; i < currentObject.reprintObj.ddAnsArray.length; i++) {
                var opt = currentObject.reprintObj.ddAnsArray[i];
                var strNum = i + 1;
                if (opt.answer_postion.text == strNum.toString())
                {

                }
                else
                {
                    sequence = 1;
                    break;
                }
            }

            if (sequence == 0)
            {
                response.ans_uniqid = 1;
                totelNumberofRightQuestion++;

            }
            else
            {
                response.ans_uniqid = 0;

            }
        }




    } else if (currentObject.format.delivery.text == "pw")
    {
        //currentObject.reprintObj.postion = currentObject.reprintObj.globaloption.answer_postion.toString(); 
        if (typeof(currentObject.reprintObj.globaloption.answer_postion) != 'undefined' && currentObject.reprintObj.globaloption.answer_postion.toString() == currentObject.reprintObj.globaloption.postion.toString())
        {
            response.ans_uniqid = 1;
            totelNumberofRightQuestion++;

        }
        else
        {
            response.ans_uniqid = 0;

        }
    }
    else if (currentObject.format.delivery.text == "fb")
    {
        var value = document.getElementById("inputId").value;
        currentObject.reprintObj.fillValue = value;

        if (value == null || value == "")
        {
            if(isQuiz == 3)
            {
                
            }
            else
            {
                return;
            }
        }
        else
        {
            if (currentObject.answers.answer.text == value)
            {
                response.ans_uniqid = 1;

                totelNumberofRightQuestion++;
                setTimeout(function () {
                    //$(".showquesAttempt").show();

                }, 500);

            }
            else
            {
                response.ans_uniqid = 0;

                setTimeout(function () {

                }, 500);

            }
        }
    }

    $("#starcountid").text(totelNumberofRightQuestion + '/' + totelNumberOfQuestion);
    stopAudioVideo();
    CloseAudioVideo();


    currentQuestion += 1;
    if (currentQuestion <= totelNumberOfQuestion) {


        sizeWidth += (1 / totelNumberOfQuestion) * 100;
        $(".progressField").show();
        $(".progressField").css('width', sizeWidth + '%');
        document.getElementById("attmAnsNo").innerHTML = currentQuestion;
        playSound(next_click_sound);
        $(".showquesAttempt").hide();
        updateNextQuestion();

    }
    else
    {

    }




}

function showAssessmentQuesAttemptSubmit() {       


   var response = new Object();
    response.test_uniqid = edgeId;
    response.ques_uniqid = currentObject.uniqid;
    response.ans_uniqid = 0;

    var dt = (new Date()).getTime();
    response.date_ms = (dt - renderTime);
    
    updateIfExistObj(response);
    currentObject.reprintObj.isAns = true;




    if (currentObject.format.delivery.text == "mc") {
        currentObject.reprintObj.mcObj = currentObject.userAnswerObj;
        if (currentObject.iscorrect == 'true')
        {
            response.ans_uniqid = 1;
            totelNumberofRightQuestion++;
        }
        else if (currentObject.iscorrect == 'false')
        {
            response.ans_uniqid = 0;
        }
        else
        {

        }
    }
    else if (currentObject.format.delivery.text == "dd")
    {
        var str = "";
        for (var i = 0; i < currentObject.answers.answer.length; i++) {
            str = str + " " + currentObject.answers.answer[i].content.text;
            ;
        }



        if (currentObject.reprintObj.ddAnsArray.length < currentObject.answers.answer.length)
        {
            response.ans_uniqid = 0;

        }
        else
        {
            var sequence = 0;
            for (var i = 0; i < currentObject.reprintObj.ddAnsArray.length; i++) {
                var opt = currentObject.reprintObj.ddAnsArray[i];
                var strNum = i + 1;
                if (opt.answer_postion.text == strNum.toString())
                {

                }
                else
                {
                    sequence = 1;
                    break;
                }
            }

            if (sequence == 0)
            {
                response.ans_uniqid = 1;
                totelNumberofRightQuestion++;

            }
            else
            {
                response.ans_uniqid = 0;

            }
        }




    } else if (currentObject.format.delivery.text == "pw")
    {
        //currentObject.reprintObj.postion = currentObject.reprintObj.globaloption.answer_postion.toString(); 
        if (typeof(currentObject.reprintObj.globaloption.answer_postion) != 'undefined' && currentObject.reprintObj.globaloption.answer_postion.toString() == currentObject.reprintObj.globaloption.postion.toString())
        {
            response.ans_uniqid = 1;
            totelNumberofRightQuestion++;
            

        }
        else
        {
            response.ans_uniqid = 0;

        }
    }
    else if (currentObject.format.delivery.text == "fb")
    {
        var value = document.getElementById("inputId").value;
        currentObject.reprintObj.fillValue = value;

        if (value == null || value == "")
        {
            if(isQuiz == 3)
            {
                
            }
            else
            {
                return;
            }
        }
        else
        {
            if (currentObject.answers.answer.text == value)
            {
                response.ans_uniqid = 1;

                totelNumberofRightQuestion++;
                setTimeout(function () {
                    $(".showquesAttempt").show();

                }, 500);

            }
            else
            {
                response.ans_uniqid = 0;

                setTimeout(function () {

                }, 500);

            }
        }
    }

    $("#starcountid").text(totelNumberofRightQuestion + '/' + totelNumberOfQuestion);
    stopAudioVideo();
    CloseAudioVideo();


    currentQuestion += 1;
    if (currentQuestion <= totelNumberOfQuestion) {


        sizeWidth += (1 / totelNumberOfQuestion) * 100;
        $(".progressField").show();
        $(".progressField").css('width', sizeWidth + '%');
        document.getElementById("attmAnsNo").innerHTML = currentQuestion;
        playSound(next_click_sound);
        $(".showquesAttempt").hide();
    }


    $(".showquesAttempt").hide();
    $(".modalWindowBg").show();
    updatetrackingAndScore();
}


function showAssessmentQuesAttemptPrev() {
    
    if(currentQuestion == 1) return;

    var response = new Object();
    response.test_uniqid = edgeId;
    response.ques_uniqid = currentObject.uniqid;
    response.ans_uniqid = 0;

    var dt = (new Date()).getTime();
    response.date_ms = (dt - renderTime);
    updateIfExistObj(response);
    currentObject.reprintObj.isAns = true;




    if (currentObject.format.delivery.text == "mc") {
        currentObject.reprintObj.mcObj = currentObject.userAnswerObj;
        if (currentObject.iscorrect == 'true')
        {
            response.ans_uniqid = 1;
            totelNumberofRightQuestion++;
        }
        else if (currentObject.iscorrect == 'false')
        {
            response.ans_uniqid = 0;
        }
        else
        {

        }
    }
    else if (currentObject.format.delivery.text == "dd")
    {
        var str = "";
        for (var i = 0; i < currentObject.answers.answer.length; i++) {
            str = str + " " + currentObject.answers.answer[i].content.text;
        }

        //currentObject.reprintObj.ddAns = ddAnsArray;

        if (currentObject.reprintObj.ddAnsArray.length < currentObject.answers.answer.length)
        {
            response.ans_uniqid = 0;

        }
        else
        {
            var sequence = 0;
            for (var i = 0; i < currentObject.reprintObj.ddAnsArray.length; i++) {
                var opt = currentObject.reprintObj.ddAnsArray[i];
                var strNum = i + 1;
                if (opt.answer_postion.text == strNum.toString())
                {

                }
                else
                {
                    sequence = 1;
                    break;
                }
            }

            if (sequence == 0)
            {
                response.ans_uniqid = 1;
                totelNumberofRightQuestion++;

            }
            else
            {
                response.ans_uniqid = 0;

            }
        }




    } else if (currentObject.format.delivery.text == "pw")
    {
        //currentObject.reprintObj.postion = currentObject.reprintObj.globaloption.answer_postion.toString(); 
        
        if (typeof(currentObject.reprintObj.globaloption.answer_postion) != 'undefined' && currentObject.reprintObj.globaloption.answer_postion.toString() == currentObject.reprintObj.globaloption.postion.toString())
        {
            response.ans_uniqid = 1;
            totelNumberofRightQuestion++;

        }
        else
        {
            response.ans_uniqid = 0;

        }
    }
    else if (currentObject.format.delivery.text == "fb")
    {
        var value = document.getElementById("inputId").value;
        currentObject.reprintObj.fillValue = value;

        if (value == null || value == "")
        {
            if(isQuiz == 3)
            {
                
            }
            else
            {
                return;
            }
        }
        else
        {
            if (currentObject.answers.answer.text == value)
            {
                response.ans_uniqid = 1;

                totelNumberofRightQuestion++;
                setTimeout(function () {
                    //$(".showquesAttempt").show();

                }, 500);

            }
            else
            {
                response.ans_uniqid = 0;

                setTimeout(function () {

                }, 500);

            }
        }
    }

    $("#starcountid").text(totelNumberofRightQuestion + '/' + totelNumberOfQuestion);
    stopAudioVideo();
    CloseAudioVideo();


    currentQuestion -= 1;
    if (currentQuestion > 0) {


        sizeWidth -= (1 / totelNumberOfQuestion) * 100;
        $(".progressField").show();
        $(".progressField").css('width', sizeWidth + '%');
        document.getElementById("attmAnsNo").innerHTML = currentQuestion;
        playSound(next_click_sound);
        $(".showquesAttempt").hide();
        updateNextQuestion();

    }
    else
    {

    }
}
function createDiv(className) {
    var thisfi = document.createElement("div");
    thisfi.className = className;
    return thisfi;
}
function createSound(fpath)
{
    var aud = document.createElement("audio");
    aud.src = fpath;
    aud.load();
    return aud;
}

function playSound(sndTag)
{
    sndTag.play();
}

function parseXmlData(xmlData)
{


    right_answer_sound = createSound("./media/correct_answer.mp3");
    wrong_answer_sound = createSound("./media/wrong_answer.mp3");
    click_sound = createSound("./media/click.mp3");
    next_click_sound = createSound("./media/next_click.mp3");
    dd_sound = createSound("./media/dd.mp3");
    totelNumberOfQuestion = xmlData.assess.question.length;
    if(totelNumberOfQuestion == 1 || typeof (totelNumberOfQuestion) == 'undefined'){
       questionArray = new Array(xmlData.assess.question);
       totelNumberOfQuestion =1;
      
    }
    else
    {
      questionArray = xmlData.assess.question;  
    }
   
    
    document.getElementById("tQuesNo").innerHTML = totelNumberOfQuestion;
   sizeWidth = (1/totelNumberOfQuestion)*100;


    responseObject = new Object();
    responseObject.param = new Array();
    responseObject.score = 0;
    responseObject.edgeId = xmlData.assess.uniqid;


    updateNextQuestion();


}
function updateGlobalVariable()
{

}

//  ///   Update Next Button
function updateNextQuestion()
{

    stat = 0;
    currentObject = questionArray[currentQuestion - 1];
    if (currentObject.reprintObj == null || typeof (currentObject.reprintObj) == 'udefined') {
        currentObject.reprintObj = new Object();
        currentObject.reprintObj.isAns = false;
    }
   if(totelNumberOfQuestion == 1)
   {
     $("#submitpre").removeClass('buttonStyle');
        $("#submitpre").addClass('buttonStyleDisable');
        $("#submitnext").removeClass('buttonStyle');
        $("#submitnext").addClass('buttonStyleDisable');
        
        
   }
    else if (currentQuestion == 1)
    {
        $("#submitpre").removeClass('buttonStyle');
        $("#submitpre").addClass('buttonStyleDisable');
        
        $("#submitnext").removeClass('buttonStyleDisable');
        $("#submitnext").addClass('buttonStyle');
        
       
        
//        document.getElementById("submitpre").style.enabled = false;
//        //document.getElementById("submitpre").hide();
//        document.getElementById("submit").style.enabled = true;
//        document.getElementById("submitnext").style.enabled = true;
    }
    else if (currentQuestion == totelNumberOfQuestion)
    {
        $("#submitpre").removeClass('buttonStyleDisable');
        $("#submitpre").addClass('buttonStyle');
        
        
//        document.getElementById("submitpre").style.enabled = true;
//        document.getElementById("submit").style.enabled = true;
//        document.getElementById("submitnext").style.enabled = false;
        
        $("#submitnext").removeClass('buttonStyle');
        $("#submitnext").addClass('buttonStyleDisable');
        
        //document.getElementById("submitnext").hide();
    }
    else
    {
        $("#submitpre").removeClass('buttonStyleDisable');
        $("#submitpre").addClass('buttonStyle');
        
        $("#submitnext").removeClass('buttonStyleDisable');
        $("#submitnext").addClass('buttonStyle');
        
        
    }

    renderTime = (new Date()).getTime();  ///   ##########local time hide
    document.getElementById("submitBtn").innerHTML = messageObj.SUBMIT;
    ///   ########### local time hide
    var quesText = currentObject.content.text.replace(/(\r\n|\n|\r)/gm, '<br />');
    document.getElementById("quesDiv").innerHTML = quesText;
    // var question = this.assess.question[this.currentQuestion];

    $("#quesOptionDiv").empty();
    $("#quesOptionDiv").show();
    $(".contentTopDiv").css("height", "30%");
    if (currentObject.image != null && currentObject.audio != null && currentObject.video != null && currentObject.image.is_filled == 'true' && currentObject.audio.is_filled == 'false' && currentObject.video.is_filled == 'false')
    {
        getFilePathfromNative("1", currentObject.image.text, "");

    }
    else if (currentObject.image != null && currentObject.audio != null && currentObject.video != null && currentObject.image.is_filled == 'true' && currentObject.audio.is_filled == 'true' && currentObject.video.is_filled == 'false')
    {
        getFilePathfromNative("4", currentObject.image.text, currentObject.audio.text);
    }
    else if (currentObject.image != null && currentObject.audio != null && currentObject.video != null && currentObject.image.is_filled == 'false' && currentObject.audio.is_filled == 'false' && currentObject.video.is_filled == 'true')
    {
        getFilePathfromNative("3", currentObject.video.text, "");
    }
    else if (currentObject.image != null && currentObject.audio != null && currentObject.video != null && currentObject.image.is_filled == 'false' && currentObject.audio.is_filled == 'true' && currentObject.video.is_filled == 'false')
    {
        getFilePathfromNative("2", currentObject.audio.text, "");
    }
    else if (currentObject.image != null && currentObject.audio != null && currentObject.video != null && currentObject.image.is_filled == 'false' && currentObject.audio.is_filled == 'false' && currentObject.video.is_filled == 'false')
    {


        $("#quesOptionDiv").hide();
        $(".contentTopDiv").css("height", "80%");

    }
    else
    {

        $("#quesOptionDiv").hide();
        $(".contentTopDiv").css("height", "80%");


    }





    //   ########### end local time hide


    if (currentObject.format.delivery.text == "mc") {


        document.getElementById("midMCQAnsTypeDiv").style.display = "block";
        document.getElementById("midDnDTypeDiv").style.display = "none";
        document.getElementById("midDnDBoxFillDiv").style.display = "none";
        document.getElementById("fillblanks").style.display = "none";
        document.getElementById("quesNoDiv").innerHTML = currentQuestion + ".";
        var quesText = currentObject.content.text.replace(/(\r\n|\n|\r)/gm, '<br />');
        document.getElementById("quesDiv").innerHTML = quesText;
        $("#midMCQAnsTypeDiv").empty();
        for (var i = 0; i < currentObject.answers.answer.length; i++) {
            var opt = createDiv("div");
            opt.id = currentObject.answers.answer[i].uniqid;

            var listName = currentObject.answers.answer[i].content.text; //.split(' ').join('&nbsp;')
            if (currentObject.answers.answer[i].is_correct.text == 'true')
            {
                currentObject.text = currentObject.answers.answer[i].content.text;
            }
            var va1 = currentObject.answers.answer[i].uniqid;
            var va2 = listName.replace(/'/g, "\\'");
            var va3 = currentObject.answers.answer[i].is_correct.text;


            //currentObject.reprintObj.iscorrect = false;

            if (currentObject.reprintObj.isAns) {


                if (currentObject.reprintObj.mcObj == opt.id) {
                    opt.innerHTML = "<a id=\"" + currentObject.answers.answer[i].uniqid + "\" onclick=\"selectAns(this,'" + va1 + "','" + va2 + "','" + va3 + "');\"> <div class=\"ansCircle pull-left\"><i class=\"fa fa-dot-circle-o\"></i></div> <div id=\"" + i + "\" class=\"form-control ansSelect ansSelected pull-left \"> <span>" + listName + "</span> </div> </a>";

                }
                else
                {
                    opt.innerHTML = "<a id=\"" + currentObject.answers.answer[i].uniqid + "\" onclick=\"selectAns(this,'" + va1 + "','" + va2 + "','" + va3 + "');\"> <div class=\"ansCircle pull-left\"><i class=\"fa fa-circle\"></i></div> <div id=\"" + i + "\" class=\"form-control ansSelect pull-left \"> <span>" + listName + "</span> </div> </a>";

                }

            }
            else
            {
                opt.innerHTML = "<a id=\"" + currentObject.answers.answer[i].uniqid + "\" onclick=\"selectAns(this,'" + va1 + "','" + va2 + "','" + va3 + "');\"> <div class=\"ansCircle pull-left\"><i class=\"fa fa-circle\"></i></div> <div id=\"" + i + "\" class=\"form-control ansSelect pull-left \"> <span>" + listName + "</span> </div> </a>";
            }
            document.getElementById("midMCQAnsTypeDiv").appendChild(opt);

        }

    } else if (currentObject.format.delivery.text == "dd") {
        //currentObject.reprintObj.ddAns = ddAnsArray;
        document.getElementById("midDnDTypeDiv").style.display = "block";
        document.getElementById("midMCQAnsTypeDiv").style.display = "none";
        document.getElementById("midDnDBoxFillDiv").style.display = "none";
        document.getElementById("fillblanks").style.display = "none";
        document.getElementById("quesNoDiv").innerHTML = currentQuestion + ".";
        var quesText = currentObject.content.text.replace(/(\r\n|\n|\r)/gm, '<br />');
        document.getElementById("quesDiv").innerHTML = quesText;
        $("#ansDndDiv").empty();
        $("#refreshId").hide();
        if (currentObject.reprintObj.isAns) {
            if (currentObject.reprintObj.ddAnsArray.length > 0)
            {
                $("#refreshId").show();
                $('#submitBtn').removeClass("btnDisable");
                document.getElementById('submitBtn').disabled = false;
            }
            else
            {
                $("#refreshId").hide();
                $('#submitBtn').addClass("btnDisable");
                document.getElementById('submitBtn').disabled = true;
            }

        } else {

            currentObject.reprintObj.ddAnsArray = new Array();
            currentObject.reprintObj.ansArr = new Array();
            var ran = getRandomOption(1, 4);

            for (var i = 0; i < currentObject.answers.answer.length; i++) {

                //currentObject.answers.answer[i].stat = 0;

                var k;
                if (currentObject.answers.answer.length > ran + i)
                {
                    k = ran + i;
                }
                else
                {
                    k = (ran + i) - currentObject.answers.answer.length;
                }


                var opt = createDiv("drag_item");

                opt.stat = 0;
                opt.answer_postion = currentObject.answers.answer[k].position;
                opt.setAttribute("onclick", "handleDragAndDropToggle(this)");
                opt.innerHTML = currentObject.answers.answer[k].content.text;




                currentObject.reprintObj.ansArr.push(opt);

            }


        }
        reDrawDDOption();
    } else if (currentObject.format.delivery.text == "pw") {

        //currentObject.reprintObj.postion = ""; 


        document.getElementById("midDnDTypeDiv").style.display = "none";
        document.getElementById("midMCQAnsTypeDiv").style.display = "none";
        document.getElementById("midDnDBoxFillDiv").style.display = "block";
        document.getElementById("fillblanks").style.display = "none";
        document.getElementById("quesNoDiv").innerHTML = currentQuestion + ".";
        var quesText = currentObject.content.text.replace(/(\r\n|\n|\r)/gm, '<br />');
        document.getElementById("quesDiv").innerHTML = quesText;
        $(".quesAudioType").height("20%");
        $("#ansDndBoxFillDiv").empty();
        $("#upperDivId").empty();


        


            currentObject.reprintObj.ansArr = new Array();
            for (var i = 0; i < currentObject.random_options.option.length; i++) {

                //currentObject.answers.answer[i].stat = 0;
                var opt = createDiv("drag_item");
                opt.stat = 0;
                opt.answer_postion = currentObject.random_options.option[i].position;
                if (currentObject.random_options.option[i].position.toString() != '0')
                {
                    currentObject.text = currentObject.random_options.option[i].text;
                }
                
                opt.setAttribute("onclick", "dropOnblankDiv(this);");
                opt.innerHTML = currentObject.random_options.option[i].text;
                currentObject.reprintObj.ansArr.push(opt);
                document.getElementById("ansDndBoxFillDiv").appendChild(opt);


            }
            currentObject.reprintObj.ddAnsArray = new Array();
            for (var i = 0; i < currentObject.answers.answer.length; i++) {

                var opt;
                //opt.stat = 0;
                //
                if (currentObject.answers.answer[i].content.is_filled == 'true')
                {
                    opt = createDiv("drag_item");
                    opt.innerHTML = currentObject.answers.answer[i].content.text;
                }
                else
                {
                    
                    if (currentObject.reprintObj.isAns)
                    {
                        if(currentObject.reprintObj.globaloption.innerHTML != "&nbsp;"){  
                        opt = createDiv("drag_item_blank drag_item_blankNotempty");
                        opt.postion = i + 1;
                        //currentObject.reprintObj.globaloption = opt;
                        opt.innerHTML = currentObject.reprintObj.globaloption.innerHTML;
                     }
                     else
                     {
                       opt = createDiv("drag_item_blank");
                        opt.postion = i + 1;
                        currentObject.reprintObj.globaloption = opt;
                        currentObject.reprintObj.globaloption.innerHTML = "&nbsp;";  
                     }
                    }
                    else
                    {
                        opt = createDiv("drag_item_blank");
                        opt.postion = i + 1;
                        currentObject.reprintObj.globaloption = opt;
                        currentObject.reprintObj.globaloption.innerHTML = "&nbsp;";
                    }


                }

                currentObject.reprintObj.ddAnsArray.push(opt);
                document.getElementById("upperDivId").appendChild(opt);

            }
      

    }
    else if (currentObject.format.delivery.text == "fb") {
        //currentObject.reprintObj.fillValue = "";
        document.getElementById("midDnDTypeDiv").style.display = "none";
        document.getElementById("midMCQAnsTypeDiv").style.display = "none";
        document.getElementById("midDnDBoxFillDiv").style.display = "none";
        document.getElementById("fillblanks").style.display = "block";

        document.getElementById("quesNoDiv").innerHTML = currentQuestion + ".";
        var quesText = currentObject.content.text.replace(/(\r\n|\n|\r)/gm, '<br />');
        document.getElementById("quesDiv").innerHTML = quesText;
        $("#fillblanksfield").empty();
        var html = "<input onclick=\"pauseVideo()\"placeholder=\"Fill in the blank\" onfocus=\"focusOn()\" onPaste =\"return false;\" onCopy=\"return false;\" type=\"text\" id=\"inputId\" class='form-control' onkeyup=\"fillBlank();\"/>";//currentObject.content.text;
        document.getElementById("fillblanksfield").innerHTML = html;

        if (currentObject.reprintObj.isAns)
        {

            document.getElementById("inputId").value = currentObject.reprintObj.fillValue;

        }
        else
        {

        }


    }

    $("#quesParentDiv").scrollTop(0);
    $(".progressField").show();
    $(".progressField").css('width', sizeWidth + '%');
}
function focusOn()
{
    //alert("Amit"); 
}

////// ##########Native  Code
// currentObject.userAnswerId = 
function getFilePathfromNative(type, path, path1)
{
    var jsObject = new Object();
    jsObject.type = type;
    jsObject.path1 = path;
    jsObject.path2 = path1;
    var dataval = JSON.stringify(jsObject);
    JSInterface.send(dataval, function (responseData) {
        var jsonObj = JSON.parse(responseData);
        //alert(responseData);
        var localHTML;
        if (type == 1)
        {
            // image and text 
            localHTML = "<div class=\"quesImageType\"><img src=\"" + jsonObj.path1 + "\" alt=\"\" /></div>";
            document.getElementById("quesOptionDiv").innerHTML = localHTML;


            // localHTML = "<div class=\"quesImageType\"><img src=\"" + jsonObj.path1 + "\" alt=\"\" /></div>"
        }
        else if (type == 3)
        {
            // Video and text
            localHTML = "<div class=\"quesVideoType\" ><video id =\"videoId\" controls=\"controls\" playsinline  class='videoShow'><source src=\"" + jsonObj.path1 + "\" type=\"video/mp4\"></video></div>";
            document.getElementById("quesOptionDiv").innerHTML = localHTML;
            document.getElementById("videoId").load();
            //localHTML =  "<video width=\"400\" controls><source src=\""+jsonObj.path1+"\" type=\"video/mp4\"></video>";
            //localHTML = "<div class=\"quesVideoType\"><img src=\"images/playIcon.png\" alt=\"\" /><video src=\"" + jsonObj.path1 + "\" type=\"video/mp4\"></video></div>";
        }
        else if (type == 4)
        {
            // audio, image and text\
            localHTML = "<div class=\"quesImageAudioType\"> <img src=\"" + jsonObj.path1 + "\"  class=\"img\" onclick=\"clickImg();\" /> <div  id=\"audioProgress\" class=\"easyPieChart playAudioBg\"   onclick=\"pausePlay();hideShow();\"><span class=\"faIcon fa \"><i class=\"fa fa-play\"></i></span><div class=\"playBg\"> <audio onended=\"endPlay()\" id=\"playAudioId\"  class=\"playAudio\"><source src=\"" + jsonObj.path2 + "\"  type=\"audio/mp3\"></audio><input id=\"cAudioPlayTime\" type=\"hidden\" value=\"0\" /><input id=\"totalAudioDuration\"  type=\"hidden\" value=\"0\" /></div></div><span class=\"txt\">Listen and answer</span></div>";
            //localHTML = "<div class=\"quesImageAudioType\"> <img   src=\"" + jsonObj.path1 + "\" alt=\"\" class=\"img\" /> <div class='playAudioBg'><div onclick =\"pausePlay();\" id='iconId' class =\"playClass playImg\" alt=\"\" > <audio onended=\"endPlay()\" id='playAudioId' class='playAudio'><source src=\"" + jsonObj.path2  + "\" type=\"audio/mp3\"></audio></div></div></div>";
            document.getElementById("quesOptionDiv").innerHTML = localHTML;
            document.getElementById("playAudioId").load();
            // localHTML = "<div class=\"quesImageAudioType\" onclick=\"playAudio();\"> <img src=\"" + jsonObj.path1 + "\" alt=\"\" class=\"img\" /> <img src=\"images/playIcon.png\" alt=\"\" class=\"audioImg\" /> <audio src=\"" + jsonObj.path2 + "\"></audio></div>";
        }
        else if (type == 2)
        {
            // audio and text\
            //localHTML = "<audio><source src=\"" + jsonObj.path1  + "\" type=\"audio/mp3\"></audio>"
            localHTML = "<div class=\"quesAudioType\" ><div id=\"audioProgress \" class=\"easyPieChart text-center\" onclick=\"pausePlay();\"><span class=\"faIcon fa \"><i class=\"fa fa-play\"></i></span><div class=\"playBg\"><audio onended=\"endPlay()\" id=\"playAudioId\" class=\"playAudio\"><source src=\"" + jsonObj.path1 + "\"  type=\"audio/mp3\"></audio><input id=\"cAudioPlayTime\" type=\"hidden\" value=\"0\" /><input id=\"totalAudioDuration\"  type=\"hidden\" value=\"0\" /></div></div><span class=\"txt\">Listen and answer</span></div>";
            document.getElementById("quesOptionDiv").innerHTML = localHTML;
            document.getElementById("playAudioId").load();
            //localHTML = "<div class=\"quesAudioType\" onclick=\"playAudio();\"><img src=\"images/playIcon.png\" alt=\"\" /> <audio src=\"" + jsonObj.path1 + "\></audio></div>";
        }
        else if (audio == null && audio == "" && video == null && video == "" && image == null && image == "")
        {
            //text
            document.getElementById("quesOptionDiv").innerHTML = localHTML;
        }



    });
}

//clickNext code
function clickNext()
{
    $("#nextBtnDiv").hide();
    $("#submitDiv").show();
    document.getElementById('submitBtn').disabled = true;
    $('#submitBtn').addClass("btnDisable");
    currentQuestion += 1;
    if (currentQuestion <= totelNumberOfQuestion) {


        sizeWidth += (1 / totelNumberOfQuestion) * 100;
        $(".progressField").show();
        $(".progressField").css('width', sizeWidth + '%');
    }
    else {
        currentQuestion = totelNumberOfQuestion;
        $(".showquesAttempt").hide();
        $(".modalWindowBg").show();
        updatetrackingAndScore();
    }
    document.getElementById("attmAnsNo").innerHTML = currentQuestion;
    playSound(next_click_sound);
    $(".showquesAttempt").hide();
    updateNextQuestion();
}

//updatetrackingAndScore code
function updatetrackingAndScore()
{
    addIfNotExistObj();
    var success = "<div class=\"welldone\" id=\"wellDoneDiv\"><h1>Well done !</h1><p>Keep  going !</p></div>";
    var failure = "<div class=\"welldone\" id=\"ohNoDiv\"><h1>Oh no !</h1><p>You need to score !</p></div>";


    if (isQuiz == 3)
    {
       totelNumberofRightQuestion =0;
       for(var j =0 ;j< responseObject.param.length;j++) {
            if(responseObject.param[j].ans_uniqid == 1 ) {
               totelNumberofRightQuestion ++; 
            }
         } 
         responseObject.score = parseInt((totelNumberofRightQuestion / totelNumberOfQuestion) * MARKS);
    }
    else
    {
        responseObject.score = parseInt((totelNumberofRightQuestion / totelNumberOfQuestion) * MARKS);
    }
    
    //alert(JSON.stringify(responseObject));
    //console.log(responseObject);
    document.getElementById("nameId").innerHTML = practiceName;
    //document.getElementById("rightScoreID").innerHTML = totelNumberofRightQuestion + '/' + totelNumberOfQuestion;
    document.getElementById("rightScoreID").innerHTML = totelNumberofRightQuestion;
    document.getElementById("totalScoreID").innerHTML = totelNumberOfQuestion;
    document.getElementById("starScoreID").innerHTML = responseObject.score;
    if (responseObject.score >= 1)
    {
        document.getElementById("pillowImageId").innerHTML = success;
    }
    else
    {
        document.getElementById("pillowImageId").innerHTML = failure;
    }
}
//submitAnswer
function submitAnswer()
{
    var jsObject = new Object();
    jsObject.type = "submitScore";
    jsObject.data = responseObject;
    JSInterface.send(JSON.stringify(jsObject));
}



//   ###### MCQ select answer  #############
function selectAns(elem, opId, optext, opisCorrect) {
    //  get  main id 
    // var currentId = $(elem).attr("id");  
    var alreadySelected = 0;
    var ans = $(elem).children(".ansSelect").hasClass('ansSelected');
    var circle = $(elem).children(".ansCircle").find("i").hasClass('fa-dot-circle-o');
    //  unselect answer  
    if ((ans) || (circle)) {
        alreadySelected = 1;
        currentObject.userAnswerObj = nil;
        //alert(currentObject.userAnswerId);
    }
    $(".ansSelect").removeClass("ansSelected");
    $(".ansCircle > i").removeClass('fa-dot-circle-o');
    $(".ansCircle > i").addClass('fa-circle');
    //  select answer  
    if (alreadySelected == 0) {
        playSound(click_sound);
        $(elem).children(".ansSelect").addClass("ansSelected");
        $(elem).children(".ansCircle").find("i").addClass('fa-dot-circle-o');
        $(elem).children(".ansCircle").find("i").removeClass('fa-circle');
        currentObject.userAnswerObj = opId;
        //currentObject.text = optext;
        currentObject.iscorrect = opisCorrect;
        //alert(currentObject.userAnswerId);
        $('#submitBtn').removeClass("btnDisable");
        document.getElementById('submitBtn').disabled = false;
    }
}

//    ###### DND select answer  #############
function handleDragAndDropToggle(opt)
{

    playSound(dd_sound);
    toggleDDOption(opt);
    reDrawDDOption();
    if (currentObject.reprintObj.ddAnsArray.length > 0)
    {
        $("#refreshId").show();
        $('#submitBtn').removeClass("btnDisable");
        document.getElementById('submitBtn').disabled = false;
    }
    else
    {
        $("#refreshId").hide();
        $('#submitBtn').addClass("btnDisable");
        document.getElementById('submitBtn').disabled = true;
    }
}
//reDrawDDOption
function reDrawDDOption()
{
    $("#ansDndDiv").empty();
    $("#ansDndWhiteDiv").empty();
    for (var i = 0; i < currentObject.reprintObj.ansArr.length; i++)
    {

        document.getElementById("ansDndDiv").appendChild(currentObject.reprintObj.ansArr[i]);


    }

    for (var j = 0; j < currentObject.reprintObj.ddAnsArray.length; j++)
    {
        document.getElementById("ansDndWhiteDiv").appendChild(currentObject.reprintObj.ddAnsArray[j]);
    }


}
//  toggleDDOption
function toggleDDOption(opt) {
    if (opt.stat == 1) {
        opt.stat = 0;
        currentObject.reprintObj.ansArr.push(opt);
        currentObject.reprintObj.ddAnsArray = removeObj(opt, currentObject.reprintObj.ddAnsArray);
        //alert(ansArr.length);
    } else {
        opt.stat = 1;
        currentObject.reprintObj.ddAnsArray.push(opt);
        currentObject.reprintObj.ansArr = removeObj(opt, currentObject.reprintObj.ansArr);
        //alert(ddAnsArray.length);
    }
}
// removeObj
function removeObj(Object, arr)
{
    var sortArr = new Array();
    for (var k = 0; k < arr.length; k++)
    {
        if (Object.innerHTML == arr[k].innerHTML)
        {

        }
        else
        {
            sortArr.push(arr[k]);
        }

    }
    return sortArr;
}

//reArrage /refresh
function reArrage()
{
    for (var j = currentObject.reprintObj.ddAnsArray.length; j > 0; j--)
    {
        var opt = currentObject.reprintObj.ddAnsArray[j - 1];
        opt.stat = 0;
        currentObject.reprintObj.ansArr.push(opt);

    }
    currentObject.reprintObj.ddAnsArray = new Array();
    reDrawDDOption();
    if (currentObject.reprintObj.ddAnsArray.length > 0)
    {
        $("#refreshId").show();
        $('#submitBtn').removeClass("btnDisable");
        document.getElementById('submitBtn').disabled = false;

    } else
    {
        $("#refreshId").hide();
        $('#submitBtn').addClass("btnDisable");
        document.getElementById('submitBtn').disabled = true;
    }
}


//   ###### DND Box select answer  #############
function dropOnblankDiv(opt)
{
    playSound(dd_sound);
    currentObject.reprintObj.globaloption.innerHTML = opt.innerHTML;
    //currentObject.reprintObj.globaloption.postion = "-1"
    currentObject.reprintObj.globaloption.answer_postion = opt.answer_postion;
    var value = $(".drag_item_blank").html();
    fillBoxValue = value.trim();
    if ((fillBoxValue !== '') || (fillBoxValue == null)) {
        $('#submitBtn').removeClass("btnDisable");
        document.getElementById('submitBtn').disabled = false;
        $(".drag_item_blank").addClass("drag_item_blankNotempty");
    }
    else {
        $(".drag_item_blank").removeClass("drag_item_blankNotempty");
        $('#submitBtn').addClass("btnDisable");
        document.getElementById('submitBtn').disabled = true;
    }

}

//   ###### image click and touch show and hide audio  #############
function clickImg() {
    $("#audioProgress").show();
    $(".quesImageAudioType .txt").show();
}
function hideShow() {

    if (stat == 0)
        return;

    if ($('#audioProgress').css('display') == 'block') {
        // $('#audioProgress').hide();
        setTimeout(function () {
            $("#audioProgress").fadeOut(1500);
        }, 500);
        setTimeout(function () {
            $(".quesImageAudioType .txt").fadeOut(1500);
        }, 500);
    }

}
//   ###### pie chart audio progress  #############


function audioPeiChart() {

    $('.easyPieChart').easyPieChart({
        percent: 0,
        // The color of the curcular bar. You can pass either a css valid color string like rgb, rgba hex or string colors. But you can also pass a function that accepts the current percentage as a value to return a dynamically generated color.
        barColor: '#4D99DC',
        // The color of the track for the bar, false to disable rendering.
        trackColor: '#f2f2f2',
        // The color of the scale lines, false to disable rendering.
        scaleColor: 'transparent',
        // Defines how the ending of the bar line looks like. Possible values are: butt, round and square.
        lineCap: 'butt',
        // Width of the bar line in px.
        lineWidth: 3,
        // Size of the pie chart in px. It will always be a square.
        size: 75,
        // Time in milliseconds for a eased animation of the bar growing, or false to deactivate.
        //animate: 1000,
        // Callback function that is called at the start of any animation (only if animate is not false).
        onStart: $.noop,
        // Callback function that is called at the end of any animation (only if animate is not false).
        onStop: $.noop

    });

}
//var deviceheight= $(window).height();
//    if(deviceheight > 420){
//        $(function() {
//          $('.easyPieChart').easyPieChart({
//            size: 120
//          });
//       });
//    }
//   ###### pausePlay  #############
function pausePlay()
{
    if (document.getElementById("playAudioId").paused) {
        stat = 1;
        $(".faIcon > i.fa").removeClass("fa-play");
        $(".faIcon > i.fa").addClass("fa-pause");
        //alert("pauseD");
        document.getElementById("playAudioId").play();
        //alert("play");
        var audio = document.getElementById("playAudioId");
        //$("#cAudioPlayTime").text(audio.currentTime);
        audio.addEventListener("timeupdate", function () {
            seektimeupdate();
        });
        function seektimeupdate() {
            var nt = Math.floor(audio.currentTime * (100 / audio.duration));
            //alert("update")
            var curmins = Math.floor(audio.currentTime / 60);
            var cursecs = Math.floor(audio.currentTime - curmins * 60);
            var durmins = Math.floor(audio.duration / 60);
            var dursecs = Math.floor(audio.duration - durmins * 60);
            if (cursecs < 10) {
                cursecs = "0" + cursecs;
            }
            if (dursecs < 10) {
                dursecs = "0" + dursecs;
            }
            if (curmins < 10) {
                curmins = "0" + curmins;
            }
            if (durmins < 10) {
                durmins = "0" + durmins;
            }
            document.getElementById('cAudioPlayTime').innerHTML = curmins + ":" + cursecs;
            document.getElementById('totalAudioDuration').innerHTML = durmins + ":" + dursecs;
            var cTime = $('#cAudioPlayTime').text();
            var tDuration = $('#totalAudioDuration').text();
            //alert(nt)
            //$('.easyPieChart').data('easyPieChart').update(nt);
            $('.easyPieChart').data('easyPieChart', nt);
            //alert(nt)
            //alert("update value")
            if (cTime == tDuration) {
                $(".faIcon > i.fa").removeClass("fa-pause");
                $(".faIcon > i.fa").addClass("fa-play");
                //alert("end");
                $("#audioProgress").click(function () {
                    document.getElementById("playAudioId").play();
//                         alert("hello"); 
//                         $('.easyPieChart').data('easyPieChart').update(percent);
                });
            }
        }

    }

    else { //alert("pause");
        stat = 0;
        $(".faIcon > i.fa").removeClass("fa-pause");
        $(".faIcon > i.fa").addClass("fa-play");
        document.getElementById("playAudioId").pause();

    }
}

//   endPlay
function endPlay()
{
    $(".faIcon > i.fa").removeClass("fa-pause");
    $(".faIcon > i.fa").addClass("fa-play");
    //alert("end");

}

//   getRandomOption
function getRandomOption(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

//   keyUp fill blank input box
function fillBlank() {
//    alert("Amit");
//    var videoPlayer = document.getElementById('videoId');
//    if (typeof videoId != 'undefined' && videoId != null && videoId != '')
//    {
//        videoPlayer.pause();
//        videoPlayer.currentTime = 0;
//    }
    var value = document.getElementById("inputId").value;
    fillValue = value.trim();
    if ((fillValue !== '') || (fillValue == null)) {
        $('#submitBtn').removeClass("btnDisable");
        document.getElementById('submitBtn').disabled = false;
    }
    else {
        $('#submitBtn').addClass("btnDisable");
        document.getElementById('submitBtn').disabled = true;
    }

    //document.getElementById("footerDiv").focus();
}



function updateIfExistObj(obj)
{
   var available = true;  
  for(var i =0 ;i< responseObject.param.length;i++) 
  {
     if(responseObject.param[i].ques_uniqid == obj.ques_uniqid ) {
         responseObject.param.splice( i, 1 );
         responseObject.param.push(obj);
         available = false;
         break;
         
     }
  }
  
  if(available)
  {
     responseObject.param.push(obj); 
  }
    
   
}


function addIfNotExistObj(){
   
  for(var i =0 ;i< questionArray.length;i++) {
      var l_Obj = questionArray[i];
      var avaiable = true;
      for(var j =0 ;j< responseObject.param.length;j++) {
            if(responseObject.param[j].ques_uniqid == l_Obj.uniqid ) {
                avaiable = false;
                break;
            }
         }
      if(avaiable) {
          var response = new Object();
          response.test_uniqid = edgeId;
          response.ques_uniqid = l_Obj.uniqid;
          response.date_ms = 0;
          response.ans_uniqid = 0;
          responseObject.param.push(response); 
      }  
         
   } 
}



function paste()
{
//    $('#submitBtn').removeClass("btnDisable");
//document.getElementById('submitBtn').disabled = false; 
}
function CloseAudioVideo()
{
    if (document.getElementById("playAudioId") != null)
        document.getElementById("playAudioId").pause();
    if (document.getElementById("videoId") != null)
        document.getElementById("videoId").pause();
}


function stopAudioVideo() {
    var audioPlayer = document.getElementById('playAudioId');
    if (typeof audioPlayer != 'undefined' && audioPlayer != null && audioPlayer != '')
    {
        audioPlayer.pause();
        audioPlayer.currentTime = 0;
        $(".faIcon > i.fa").removeClass("fa-pause");
        $(".faIcon > i.fa").addClass("fa-play");
    }
    var videoPlayer = document.getElementById('videoId');
    if (typeof videoId != 'undefined' && videoId != null && videoId != '')
    {
        videoPlayer.pause();
        videoPlayer.currentTime = 0;
    }
}
function pauseVideo()
{
   var videoPlayer = document.getElementById('videoId');
    if (typeof videoId != 'undefined' && videoId != null && videoId != '')
    {
        videoPlayer.pause();
        videoPlayer.currentTime = 0;
    } 
}
loadjscssfile("js/jquery.easy-pie-chart.js", "js");
audioPeiChart();

