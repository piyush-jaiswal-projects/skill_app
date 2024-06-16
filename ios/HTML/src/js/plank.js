var wordsArray = ["amit","amit kumar","amit kumar 2","punctuated ! yes ..."];
var keys = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
var solutions = new Array();
var ind = 0;
var totalPlayed = 0;
var totalWon = 0;
var guesstem = 8;
var qdiv;
var attleft;
var open  = 0;
function updateWord() {
	var word = wordsArray[ind].toUpperCase();
	for(var i=0; i< solutions.length; i++) {
		var sol = solutions[i];
		sol = sol.toLowerCase();
		solr = sol.toUpperCase();
		var re = new RegExp(solr, 'g');
		word = word.replace(re,sol);
	}
	var displayWord = word;
	if(attleft > 0)
		displayWord = displayWord.replace(/[A-Z]/g,"_");
	displayWord = displayWord.toUpperCase();
	qdiv.innerHTML = displayWord;
	if(displayWord.indexOf("_")==-1) {
		declareVictory();
	}
}

function  loadWord() {
        getWord(); 
	ind = Math.floor(Math.random() * (wordsArray.length )) ;
	attleft = 8;
	document.getElementById("startnew").style.display="none";
	document.getElementById("guessrem").innerHTML = attleft;
	open = 1;
	qdiv = document.getElementById("dd");
	updateWord("dd");
	document.getElementById("totwon").innerHTML = totalWon;
        document.getElementById("totplayed").innerHTML = totalPlayed;
	loadKeyboard("kb");
	totalPlayed++;
}

 function loadKeyboard(kb) {
     	for (var i = 0; i < keys.length; i++) {
		var iDiv = document.createElement('a');
		iDiv.className = 'button';
		iDiv.id = "kb"+i;
		iDiv.setAttribute("href","javascript:pressed("+i+")");
		iDiv.innerHTML=keys[i];
		document.getElementById(kb).appendChild(iDiv);	
	}
	document.getElementById("kb").style.display="block";
 }
 
 function pressed(ch) {
	 if(!open)
		 return;
	document.getElementById("kb"+ch).style.display="none";
	/* check if the letter is there in the word */
	var word = wordsArray[ind].toUpperCase();
	if(word.indexOf(keys[ch])== -1) {
		attleft--;
		document.getElementById("guessrem").innerHTML = attleft;
	}
	solutions.push(keys[ch]);
	updateWord();
	if(attleft == 0) {
		document.getElementById("guessrem").innerHTML = "You Lost";
		closeGame();
	}
 }

function closeGame() {
	open=0;
	solutions = new Array();
	var node =document.getElementById("kb");
	while (node.hasChildNodes()) {
	    node.removeChild(node.lastChild);
	}
	node.style.display="none";
	document.getElementById("startnew").style.display="block";
	document.getElementById("totwon").innerHTML = totalWon;
        document.getElementById("totplayed").innerHTML = totalPlayed;
}
	
function declareVictory() {
	if(attleft==0) {
		closeGame();
		return;
	}
	document.getElementById("guessrem").innerHTML = "You Won";
	totalWon++;
	document.getElementById("totwon").innerHTML = totalWon;
        document.getElementById("totplayed").innerHTML = totalPlayed;
	closeGame();
}
	
function getWord() { 
  var data  = JSInterface.getGameWords();
  
  var json= JSON.parse(data);
  
  var a = json.gameArray;
  wordsArray = a;
  //alert(JSON.stringify(a));
  //var a = new Array('abate','aberrant','abscond','accolade','acerbic','acumen','adulation','adulterate','aesthetic','aggrandize','alacrity','alchemy','amalgamate','ameliorate','amenable','anachronism','anomaly','approbation','archaic','arduous','ascetic','assuage','astringent','audacious','austere','avarice','aver','axiom','bolster','bombast','bombastic','bucolic','burgeon','cacophony','canon','canonical','capricious','castigation','catalyst','caustic','censure','chary','chicanery','cogent','complaisance','connoisseur','contentious','contrite','convention','convoluted','credulous','culpable','cynicism','dearth','decorum','demur','derision','desiccate','diatribe','didactic','dilettante','disabuse','discordant','discretion','disinterested','disparage','disparate','dissemble','divulge','dogmatic','ebullience','eccentric','eclectic','effrontery','elegy','eloquent','emollient','empirical','endemic','enervate','enigmatic','ennui','ephemeral','equivocate','erudite','esoteric','eulogy','evanescent','exacerbate','exculpate','exigent','exonerate','extemporaneous','facetious','fallacy','fawn','fervent','filibuster','flout','fortuitous','fulminate','furtive','garrulous','germane','glib','grandiloquence','gregarious','hackneyed','halcyon','harangue','hedonism','hegemony','heretical','hubris','hyperbole','iconoclast','idolatrous','imminent','immutable','impassive','impecunious','imperturbable','impetuous','implacable','impunity','inchoate','incipient','indifferent','inert','infelicitous','ingenuous','inimical','innocuous','insipid','intractable','intransigent','intrepid','inured','inveigle','irascible','laconic','laud','loquacious','lucid','luminous','magnanimity','malevolent','malleable','martial','maverick','mendacity','mercurial','meticulous','misanthrope','mitigate','mollify','morose','mundane','nebulous','neologism','neophyte','noxious','obdurate','obfuscate','obsequious','obstinate','obtuse','obviate','occlude','odious','onerous','opaque','opprobrium','oscillation','ostentatious','paean','parody','pedagogy','pedantic','penurious','penury','perennial','perfidy','perfunctory','pernicious','perspicacious','peruse','pervade','pervasive','phlegmatic','pine','pious','pirate','pith','pithy','placate','platitude','plethora','plummet','polemical','pragmatic','prattle','precipitate','precursor','predilection','preen','prescience','presumptuous','prevaricate','pristine','probity','proclivity','prodigal','prodigious','profligate','profuse','proliferate','prolific','propensity','prosaic','pungent','putrefy','quaff','qualm','querulous','query','quiescence','quixotic','quotidian','rancorous','rarefy','recalcitrant','recant','recondite','redoubtable','refulgent','refute','relegate','renege','repudiate','rescind','reticent','reverent','rhetoric','salubrious','sanction','satire','sedulous','shard','solicitous','solvent','soporific','sordid','sparse','specious','spendthrift','sporadic','spurious','squalid','squander','static','stoic','stupefy','stymie','subpoena','subtle','succinct','superfluous','supplant','surfeit','synthesis','tacit','tenacity','terse','tirade','torpid','torque','tortuous','tout','transient','trenchant','truculent','ubiquitous','unfeigned','untenable','urbane','vacillate','variegated','veracity','vexation','vigilant','vilify','virulent','viscous','vituperate','volatile','voracious','waver','zealous');
  
}

function submitScore() 
{
    //alert("test");
        var won = totalWon; 
	var lost = totalPlayed - totalWon;
        
        var obj = new Object();
        obj.won = won;
        obj.loss = lost;
        var jsonString= JSON.stringify(obj);
        JSInterface.setGameScore(jsonString);
	
}
