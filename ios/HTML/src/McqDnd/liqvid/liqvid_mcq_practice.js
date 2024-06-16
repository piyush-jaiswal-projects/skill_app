
function createDiv(className) {
    var thisfi = document.createElement("div");
    thisfi.className = className;
    return thisfi;
}

function createUl(className) {
    var thisfi = document.createElement("ul");
    thisfi.className = className;
    return thisfi;
}

function createLi(className) {
    var thisfi = document.createElement("li");
    thisfi.className = className;
    return thisfi;
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

//!function ($) {

function jsInitialise(){
  $('.liqvid_practice_mcq').each(function(){
        /* Number of Stars to be Shown - constant */
        if ($(document).height() >= 960)
           {
              var metaTag = document.getElementsByTagName('meta');
                for (var i=0; i < metaTag.length; i++) {
                    if (metaTag[i].getAttribute("name")=='viewport')
                        metaTag[i].content = 'width=device-width , initial-scale=1, maximum-scale=1.5';
                } 
            
           }
           else
           {
               
           }
           
        this.NUMSTARS = 5;

        this.edgeId = liqTestGetEdgeId();
        var xmlString = liqTestGetPracticeXMLString(this.edgeId);
        //var parser=new DOMParser();
         this.edgeId =   xmlString.uid;     
         //var practiceJSON=parser.parseFromString(xmlString.path,"text/xml");
         //practiceJSON = xml2json.parser(xmlString.path);
        practiceJSON= xmlString.path;
        
        
        if(practiceJSON.assess.question.length == undefined)
        {
          this.assess = new Object();
          this.assess.uniqid = practiceJSON.assess.uniqid;
          var Lques = new Array();
          Lques.push(practiceJSON.assess.question);
          this.assess.question = Lques;
          
          
        }
        else
        {
          this.assess = practiceJSON.assess;  
        }
        
        
        
        
        this.test_uniqid = this.assess.uniqid;

        /* Create Sound elements */ 
        
        
        
        
//        this.right_answer_sound = new Audio("./liqvid/correct_answer.mp3");
//        
//        this.right_answer_sound.
//        this.wrong_answer_sound = new Audio("./liqvid/wrong_answer.mp3");
//        this.wrong_answer_sound.load();
//        this.click_sound = new Audio("./liqvid/click.mp3");
//        this.click_sound.load();
//        this.next_click_sound = new Audio("./liqvid/next_click.mp3");
//        this.next_click_sound.load();
//        this.dd_sound = new Audio("./liqvid/dd.mp3");  
//        this.dd_sound.load();
              
             
        this.right_answer_sound = createSound("./liqvid/correct_answer.mp3");
        this.wrong_answer_sound = createSound("./liqvid/wrong_answer.mp3");
        this.click_sound = createSound("./liqvid/click.mp3");
        this.next_click_sound = createSound("./liqvid/next_click.mp3");
        this.dd_sound = createSound("./liqvid/dd.mp3");

        /* Create response elements */
        this.responseObject = new Object();
        this.responseObject.param = new Array();
        this.responseObject.score =0;
        this.responseObject.edgeId = this.edgeId;

        /* Create Three Basic parts of the question area */
        this.progressDiv = createDiv("assess_progress");
        this.qaArea = createDiv("assess_qaarea");
        this.navDiv = createDiv("assess_nav");
        $(this).append(this.progressDiv);
        $(this).append(this.qaArea);
        $(this).append(this.navDiv);

        /*Create basic parts of the progress Div */
        //add the progress stars (5 in number) 
        this.totalNumberOfQuestions = this.assess.question.length;
        this.questionsTaken = 0;
        this.correctQuestions = 0;
        this.currentQuestion = -1;

        this.progressDiv.starDiv = createDiv("assess_stars");
        this.progressDiv.barDiv = createDiv("assess_progress_bar");
        //$(this.progressDiv).append(this.progressDiv.starDiv);
        $(this.progressDiv).append(this.progressDiv.barDiv);

        this.progressDiv.barDiv.left = createDiv("assess_progress_bar_left");
        this.progressDiv.barDiv.right = createDiv("assess_progress_bar_right");
        $(this.progressDiv.barDiv).append(this.progressDiv.barDiv.left);
        $(this.progressDiv.barDiv).append(this.progressDiv.barDiv.right);

        /* add the submit button */
        var submitButton;
        if ($(document).height() == 960)
        {
           submitButton = createDiv("submit_button_iPad btn btn-s-md"); 
        }
        else
        {
          submitButton = createDiv("submit_button btn btn-s-md");  
        }
        
        submitButton.root = this;
        $(submitButton).click(handleSubmitButtonClick);
        $(submitButton).html(liqGetStaticMessages("SUBMIT"));
        $(this.navDiv).append(submitButton);

        /* Add modal div for correct answer */
        this.correctAnswerDiv = createDiv("correct_answer");
        $(this.correctAnswerDiv).hide();
        $(this).append(this.correctAnswerDiv);

        this.correctAnswerDiv.meat = createDiv('correct_answer_meat');
        $(this.correctAnswerDiv).append(this.correctAnswerDiv.meat);

        this.correctAnswerDiv.meat.progress = createDiv("correct_answer_meat_progress");
        $(this.correctAnswerDiv.meat).append(this.correctAnswerDiv.meat.progress);

        this.correctAnswerDiv.meat.titleDiv = createDiv("correct_answer_meat_title");
        $(this.correctAnswerDiv.meat).append(this.correctAnswerDiv.meat.titleDiv);

        this.correctAnswerDiv.meat.answer = createDiv("correct_answer_meat_answer");
        $(this.correctAnswerDiv.meat).append(this.correctAnswerDiv.meat.answer);

        this.correctAnswerDiv.meat.coins = createDiv("correct_answer_meat_coins");
        $(this.correctAnswerDiv.meat).append(this.correctAnswerDiv.meat.coins);
        if ($(document).height() == 960)
        {
           this.correctAnswerDiv.meat.next_button = createDiv("correct_answer_next_button_iPad btn btn-s-md");
        }
        else
        {
        this.correctAnswerDiv.meat.next_button = createDiv("correct_answer_next_button btn btn-s-md");
        }
        this.correctAnswerDiv.meat.next_button.root = this;
        $(this.correctAnswerDiv.meat).append(this.correctAnswerDiv.meat.next_button);
        $(this.correctAnswerDiv.meat.next_button).html(liqGetStaticMessages("NEXT"));
        $(this.correctAnswerDiv.meat.next_button).click(handleNextButtonClick);

        
        
        /********* FUNCTIONS ***********/
        this.updateProgress = function() {
            /* This function updates the progress bar with the current scores */
            /* Update the number of stars */
            if(this.questionsTaken == 0) {
                /* fill the div with empty stars */
                var strHtml = "";
                for(var i=0;i< this.NUMSTARS; i++) {
                    strHtml+="<i class='fa fa-star empty_star'></i>";
                }
            } else {
                var correctPct = (this.correctQuestions / this.totalNumberOfQuestions) * this.NUMSTARS;
                var strHtml = "";
                for(var i=1;i<= this.NUMSTARS; i++) {
                    if(correctPct >= i) {
                        strHtml+="<i class='fa fa-star full_star'></i>";
                    } else if(correctPct < i && correctPct > (i-1)) {
                        strHtml+="<i class='fa fa-star-half-o full_star'></i>";
                    } else {
                        strHtml+="<i class='fa fa-star empty_star '></i>";
                    }
                }
            }
            $(this.progressDiv.starDiv).html(strHtml);

            /*Update the progress bar */
            var pctCompleted = ((this.questionsTaken+1) / this.totalNumberOfQuestions) * 100;
            $(this.progressDiv.barDiv.left).html("<div class=\"assess_progress_bar_empty progress progress-xs m-t-sm \"> <div class=\"progress-bar assess_progress_bar_filled\" data-toggle=\"tooltip\" data-original-title=\""+pctCompleted+"%\" style=\"width: "+pctCompleted+"%\"></div></div>");
            //alert(this.questionsTaken);
            //alert(this.questionTaken);
            if(this.questionsTaken < this.totalNumberOfQuestions) 
                $(this.progressDiv.barDiv.right).html((this.questionsTaken+1)+" of "+(this.totalNumberOfQuestions));
            else
                $(this.progressDiv.barDiv.right).html((this.questionsTaken)+" of "+(this.totalNumberOfQuestions));
        };
        
        this.loadNextQuestion =function() {
            this.currentQuestion++;
            if(this.currentQuestion >= this.assess.question.length) {
                this.showCompletion();
            }
            var question = this.assess.question[this.currentQuestion];
            if(question.format.delivery.text == "mc") {
                this.renderMultipleChoiceQuestion(question);
            } else if(question.format.delivery.text == "dd") {
                this.renderDragAndDropQuestion(question);
            } else if(question.format.delivery.text == "ro") {
                this.renderReorderQuestion(question);
            }
            this.renderTime = (new Date()).getTime();
        }

        this.renderReorderQuestion = function(question) {
            this.currentQuestionObject = question;
            /* First clear the question area */
            $(this.qaArea).empty();
            /* Now add question div*/
            
            this.qaArea.questionNumber = createDiv("questionNumber ");
             this.qaArea.questionNumber.innerHTML= ((this.questionsTaken+1).toString())+ "." ;
            $(this.qaArea).append(this.qaArea.questionNumber);
            
            
            this.qaArea.questionDiv = createDiv("qadiv_question ");
            //this.qaArea.questionDiv.style.height = 
            this.qaArea.optionDiv = createUl("drag_and_drop_container sortable");
            this.qaArea.optionDiv.root= this;
            this.qaArea.optionDiv.question = question;
           
            $(this.qaArea).append(this.qaArea.questionDiv);
            $(this.qaArea).append(this.qaArea.optionDiv);
            $(this.qaArea.questionDiv).html(question.content.text);
            this.currentOptionsArray = new Array();
            for(var i=0; i< question.answers.answer.length; i++) {
                var opt = createLi("drag_and_drop_item");
                $(opt).html(question.answers.answer[i].content.text);
                $(this.qaArea.optionDiv).append(opt);
                opt.answer_position=question.answers.answer[i].position;
            }
            $('.sortable').sortable({
                stop: function( event, ui ) {
                    playSound(this.root.dd_sound);
                }
            }) ;
        };

        this.evaluateReorderQuestion = function() { 
            this.questionsTaken++;
            /* Loop through the list and check if the options are correct */
            var uli = this.qaArea.optionDiv;
            var listItems = uli.getElementsByTagName("li");
            var is_correct = true;
            var correctString = new Array();
            for(var i=0;i< listItems.length; i++) {    
                if(i+1 != listItems[i].answer_position) {
                    is_correct = false;
                }
                
                correctString[listItems[i].answer_position-1] = $(listItems[i]).html();
            }
            var str="";
            for(var i=0;i< correctString.length; i++)
                str = str+" "+correctString[i].text;
            this.showAnswerScreen(is_correct,str);
            /* update the response array */
            var response = new Object();
            response.test_uniqid = this.test_uniqid;
            response.ques_uniqid= uli.question.uniqid;
            response.ans_uniqid = (is_correct) ? 1 : 0;
            var dt = (new Date()).getTime();
            response.date_ms = (dt - this.renderTime);
            this.responseObject.param.push(response);
        };

        this.renderDragAndDropQuestion= function(question) {
            this.currentQuestionObject = question;
            this.orderedOptionArray = new Array();
            /* First clear the question area */
            $(this.qaArea).empty();
            /* Now add question div*/
            
            
            this.qaArea.questionNumber = createDiv("questionNumber ");
             this.qaArea.questionNumber.innerHTML= ((this.questionsTaken+1).toString())+ "." ;
            $(this.qaArea).append(this.qaArea.questionNumber);
            
            
            this.qaArea.questionDiv = createDiv("qadiv_question");
            this.qaArea.touchDDAnswer = createDiv("qadiv_ddanswer ");
            this.qaArea.touchDDClearCross = createDiv("qadiv_ddclear_cross");
            this.qaArea.touchDDOptions = createDiv("qadiv_ddoptions");
            $(this.qaArea).append(this.qaArea.questionDiv);
            $(this.qaArea).append(this.qaArea.touchDDAnswer);
            $(this.qaArea).append(this.qaArea.touchDDClearCross);
            $(this.qaArea).append(this.qaArea.touchDDOptions);
            $(this.qaArea.touchDDClearCross).html("<i class=\"fa fa-refresh\"></i>");
            $(this.qaArea.touchDDClearCross).hide();
            this.qaArea.touchDDClearCross.root = this;
            $(this.qaArea.touchDDClearCross).click(handleDDCrossClicked);
            var questionText = question.content.text;
            $(this.qaArea.questionDiv).html(questionText);
            /* Add options to the Option Area */
            this.qaArea.optionDiv = createUl("drag_and_drop_container");
            $(this.qaArea.touchDDOptions).append(this.qaArea.optionDiv);
            this.currentOptionsArray = new Array();
            
            var ran =getRandomOption(1,4);
            //alert(ran);
            for(var i=0; i< question.answers.answer.length; i++) {
                
                var k;
                if(question.answers.answer.length > ran+i )
                {
                    k =ran+i;
                }
                else 
                {
                   k =   (ran+i)-question.answers.answer.length;
                }
                var opt = createLi("drag_item");
                $(opt).html(question.answers.answer[k].content.text);
                $(opt).click(handleDragAndDropToggle);
                opt.root = this;
                opt.stat =1 ;
                $(this.qaArea.optionDiv).append(opt);
                opt.answer_position=question.answers.answer[k].position.text;
            }
            
        };

        this.clearDDOptions = function() {
            for(var i=0;i< this.orderedOptionArray.length; i++) {
                this.orderedOptionArray[i].stat= 1;
                this.orderedOptionArray[i].className = "drag_item";
                $(this.orderedOptionArray[i]).show();
            }
            this.orderedOptionArray = new Array();
            this.renderDragAndDropAnswer();
        }

        this.toggleDDOption = function(opt) {
            if(opt.stat==1) {
                opt.stat = 0;
                opt.className= "drag_and_drop_item_disabled";
                $(opt).hide();
                this.orderedOptionArray.push(opt);
            } else {
                opt.stat = 1;
                opt.className= "drag_item";
                $(opt).show();
                var idx_to_remove = -1;
                for(var i=0;i< this.orderedOptionArray.length; i++) {
                    if(this.orderedOptionArray[i]==opt)
                        idx_to_remove = i;
                }
                if(idx_to_remove >= 0) 
                    this.orderedOptionArray.splice(idx_to_remove,1);
            }
        }
        this.renderDragAndDropAnswer = function() {
            /* Add the option text to the string */
            var str = "";
            $(this.qaArea.touchDDAnswer).empty();
            for(var i=0;i< this.orderedOptionArray.length; i++) {
                var dropItem = createDiv("drop_item drag_item");
                $(dropItem).click(handleDropItemClick);
                $(dropItem).html($(this.orderedOptionArray[i]).html());
                dropItem.opt = this.orderedOptionArray[i];
                $(this.qaArea.touchDDAnswer).append(dropItem);
            }
            /* Show the cross button */
            if(this.orderedOptionArray.length > 0) {
                $(this.qaArea.touchDDClearCross).show();
            } else {
                $(this.qaArea.touchDDClearCross).hide();
            }
        
        };
        this.handleDragAndDropClick=function(opt) {
            /* First toggle this options class */
            this.toggleDDOption(opt);
            this.renderDragAndDropAnswer();
        };
        

        this.evaluateDragAndDropQuestion = function() {
            this.questionsTaken++;
            var is_correct = true;
            var correctString = new Array();
            if(this.orderedOptionArray.length < this.currentQuestionObject.answers.answer.length)
            {
                is_correct=false;
                
                for(var i=0;i< this.currentQuestionObject.answers.answer.length; i++) {
                    //alert(JSON.stringify(this.currentQuestionObject.answers.answer[i].content));
                    //correctString[i] = JSON.stringify(this.currentQuestionObject.answers.answer[i].content);
                    //alert(correctString[i]);
                    correctString[parseInt(this.currentQuestionObject.answers.answer[i].position.text,10) - 1] = this.currentQuestionObject.answers.answer[i].content.text;
                }
            }
            else
            {
                for(var i=0;i< this.orderedOptionArray.length; i++) {
                    if(i+1 != this.orderedOptionArray[i].answer_position)
                        is_correct = false;
                    correctString[this.orderedOptionArray[i].answer_position-1] = $(this.orderedOptionArray[i]).html();
                }
            }
            var str="";
            for(var i=0;i< correctString.length; i++)
                str = str+" "+correctString[i];
            this.showAnswerScreen(is_correct,str);
            
            
            /* update the response array */
            var response = new Object();
            response.test_uniqid = this.test_uniqid;
            response.ques_uniqid= this.currentQuestionObject.uniqid;
            response.ans_uniqid = (is_correct) ? 1 : 0;
            var dt = (new Date()).getTime();
            response.date_ms = (dt - this.renderTime);
            this.responseObject.param.push(response);
        }
        this.renderMultipleChoiceQuestion=function(question) {
            this.currentQuestionObject = question;
            /* First clear the question area */
            $(this.qaArea).empty();
            /* Now add question div*/
            this.qaArea.questionNumber = createDiv("questionNumber ");
            //var textVal = (this.questionsTaken+1).toString();
            this.qaArea.questionNumber.innerHTML= ((this.questionsTaken+1).toString())+ "." ;
            $(this.qaArea).append(this.qaArea.questionNumber);
            
            this.qaArea.questionDiv = createDiv("qadiv_question");
            this.qaArea.optionDiv = createDiv("qadiv_mcq_options");
            $(this.qaArea).append(this.qaArea.questionDiv);
            $(this.qaArea).append(this.qaArea.optionDiv);
            $(this.qaArea.questionDiv).html(question.content.text);
            this.currentOptionsArray = new Array();
            for(var i=0; i< question.answers.answer.length; i++) {
                var opt = document.createElement("a");
                opt.parentGroup = this;
                opt.className = "qadiv_mcq_option list-group-item";
                opt.cboxspan = document.createElement("span");
                opt.contentspan = document.createElement("span");
                opt.cboxspan.className = "cbox_unselected";
                $(opt.cboxspan).append("<i class='fa fa-circle'></i>");
                opt.contentspan.className = "qa_option_text";
                opt.i=i;
                opt.isSelected =0;
                $(opt.contentspan).html(question.answers.answer[i].content.text);
                $(opt).append(opt.cboxspan);
                $(opt).append(opt.contentspan);
                $(opt).click(handleMCQOptionClicked);
                $(this.qaArea.optionDiv).append(opt);
                this.currentOptionsArray[i] = opt;
            }
        };

        this.evaluateMultipleChoiceQuestion =function(){
            this.questionsTaken++;
            /*Find the given answer */
            var givenAnswerIdx = 10000; //Large enough to match no option selected
            for(var i=0; i< this.currentOptionsArray.length;i++) {
                if(this.currentOptionsArray[i].isSelected == 1) {
                    givenAnswerIdx = i;
                    break;
                }
            }

            /* Find the correct answer */
            var correctAnswerIdx;
            var question = this.currentQuestionObject;
            for(var i=0; i< question.answers.answer.length;i++) {
                if(question.answers.answer[i].is_correct.text == "true") {
                    correctAnswerIdx = i;
                }
            }
            var guidelines = null;
            var lguidelines = null;
            lguidelines = question.guidelines;
            //alert(JSON.stringify(lguidelines));
            if(lguidelines == undefined || lguidelines==null || JSON.stringify(lguidelines) == "" ) {
                guidelines = question.answers.answer[correctAnswerIdx].content.text;
            }
            else
            {
              guidelines =  lguidelines.text; 
            }
            this.showAnswerScreen((correctAnswerIdx == givenAnswerIdx), guidelines);
            /* update the response array */
            var response = new Object();
            response.ques_uniqid= question.uniqid;
            response.ans_uniqid = question.answers.answer[correctAnswerIdx].uniqid;
            response.test_uniqid=this.test_uniqid;
            var dt = (new Date()).getTime();
            response.date_ms = (dt - this.renderTime);
            this.responseObject.param.push(response);
        };



 


        this.showAnswerScreen = function(isCorrect, answerText) {
            if(isCorrect) {
                this.correctQuestions++;
                $(this.correctAnswerDiv.meat.titleDiv).html("<span class=\"correct_tick\"><i class=\"fa fa-check-circle\"style = 'font-size:50px;'></i></span>"+liqGetStaticMessages("MCQ_RIGHT_ANS"));
                //$(this.correctAnswerDiv.meat.coins).html("<img src=./liqvid/jumpstar.gif></img>");
      $(this.correctAnswerDiv.meat.coins).html("<img src=./liqvid/win_cup.gif></img>");
                //$(this.correctAnswerDiv.meat.coins).html("<p class=fader><img src=./liqvid/correct_answer.png></img></p>");
           		   $(this.correctAnswerDiv.meat.answer).html(answerText);
           
            } else {
                $(this.correctAnswerDiv.meat.titleDiv).html("<span class=\"wrong_cross\"><i class=\"fa fa-times-circle \" style = 'font-size:50px;'></i></span>"+liqGetStaticMessages("MCQ_WRONG_ANS"));
      $(this.correctAnswerDiv.meat.coins).html("<p class=fader><img src=./liqvid/wrong_answer.gif></img></p>");
           		   $(this.correctAnswerDiv.meat.answer).html(liqGetStaticMessages("MCQ_RIGHT_ANS_HAI")+ " : &nbsp;" + answerText);
            }
            $(this.correctAnswerDiv).show();
         
            var pctage = (this.correctQuestions / this.totalNumberOfQuestions);
            pctage |= 0;
            //var progHtml = "<div class=\"full_star answer_progress_star\"><i class='fa fa-star'></i></div>";
            progHtml = "<div class=answer_progress_graph><p class=\"full_star  answer_progress_star\"><i class='fa fa-star' style = 'font-size:20px;'></i></p><div class=answer_progress_bar style=\"width:"+pctage+"%\">";
            progHtml += "<p>"+this.correctQuestions+"/"+this.totalNumberOfQuestions+"</p></div></div>";
            $(this.correctAnswerDiv.meat.progress).html(progHtml);
            //this.updateProgress();
            if(isCorrect)
                playSound(this.right_answer_sound);
            else
                playSound(this.wrong_answer_sound);
        };

        this.evaluateCurrentAnswer = function() {   
            if(this.currentQuestionObject.format.delivery.text == "mc") {
                this.evaluateMultipleChoiceQuestion();
            } else if(this.currentQuestionObject.format.delivery.text == "ro") {
                this.evaluateReorderQuestion();
            } else {
                this.evaluateDragAndDropQuestion();
            }
        }

        this.showCompletion = function() {  
            this.responseObject.score =(this.correctQuestions / this.totalNumberOfQuestions) * this.NUMSTARS;
            $(this).hide();
            showPopup(liqTestGetTitle(),this.correctQuestions,this.totalNumberOfQuestions,(this.responseObject.score|0));
        }
        /***************** INITIALIZATION *******************/
        this.updateProgress();
        this.loadNextQuestion();
  });
}(window.jQuery);

function handleMCQOptionClicked(e) {
    var root = this.parentGroup;
    playSound(root.click_sound);
    $(this.cboxspan).empty();
    if(this.isSelected) {
        this.cboxspan.className = "cbox_unselected";
        $(this.cboxspan).append("<i class='fa fa-circle'></i>");
        this.isSelected=0;
    } else {
        this.cboxspan.className = "cbox_selected";
        $(this.cboxspan).append("<i class='fa fa-dot-circle-o'></i>");
        this.isSelected=1;
        /* Toggle any other selected option */
        for(var i=0;i< root.currentOptionsArray.length; i++) {
            if(i!=this.i) {
                if(root.currentOptionsArray[i].isSelected == 1) {
                    $(root.currentOptionsArray[i].cboxspan).empty();
                    root.currentOptionsArray[i].cboxspan.className = "cbox_unselected";
                    $(root.currentOptionsArray[i].cboxspan).append("<i class='fa fa-circle'></i>");
                    root.currentOptionsArray[i].isSelected=0;
                }
            }
        }
    }
}

function handleSubmitButtonClick() {
    
            
    var root = this.root;
    root.evaluateCurrentAnswer();
    $(root.navDiv).hide();
}

function handleNextButtonClick() {
    var root = this.root;
    playSound(root.next_click_sound);
    $(root.correctAnswerDiv).hide();
    $(root.navDiv).show();
    
    root.loadNextQuestion();
    root.updateProgress();
}
    
function handleDragAndDropToggle() {
    var root = this.root;
    root.handleDragAndDropClick(this);
    playSound(this.root.dd_sound);
}

function handleDDCrossClicked() {
    var root = this.root;
    root.clearDDOptions();
}

function handleDropItemClick() {
    var opt = this.opt;
    var root = opt.root;
    root.handleDragAndDropClick(opt);
    playSound(root.dd_sound);
}
function getRandomOption(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function createHTML(audio,video,image,text)
{
    if(audio == null && audio == "" && video == null && video == "" && image != null && image != "")
    {
       // image and text  
    }
    else if(audio == null && audio == "" && video != null && video != "" && image == null && image == "")
    {
         // Video and text  
    }
    else if(audio != null && audio != "" && video == null && video == "" && image != null && image != "")
    {
         // audio image and text  
    }
    else if(audio != null && audio != "" && video == null && video == "" && image == null && image == "")
    {
        //  audio and text  
    }
    else if(audio == null && audio == "" && video == null && video == "" && image == null && image == "")
    {
        //text
    }
    
    return text;
}
