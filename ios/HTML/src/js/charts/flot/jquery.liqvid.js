function liqChartBarGraphRed(rawData, ticks, container, clickfunc ) {
	liqChartBarGraph(rawData,ticks,container,"rgba(211,30,17,0.5)",clickfunc);
}

function liqChartBarGraphGreen(rawData, ticks, container, clickfunc ) {
	liqChartBarGraph(rawData,ticks,container,"rgba(142,193,101,0.5)",clickfunc);
}

function liqChartIRGraphouter(vals1,vals2,chartLabel1,chartLabel2,pointLabel,container,module)
{
    liqChartIRGraph(vals1,vals2,chartLabel1,chartLabel2,pointLabel,container,module);
}
  
function liqChartBarGraph(rawData, myTicks, container,fc, clickfunc) {
	  var data2 = [
	    {
		data: rawData,
		bars: {
		    horizontal: true,
		    show: true,
		    fill: true,
		    barWidth : 0.25,
		    fillColor:  fc
		},
		color: fc
	    }];
	$(container).length && $.plot($(container), data2, {
	      xaxis: {
		tickLength: 0			
	      },
	      yaxis: {
	          ticks : myTicks
	      },
	      grid: {
	          hoverable: true,
	          clickable: (clickfunc!=null),
	          borderWidth: 0
	      },
	      legend: {
	          labelBoxBorderColor: "none",
	          position: "left"
	      },
	      series: {
	          shadowSize: 1
	      },
	      tooltip: true,
		    tooltipOpts: {
		      content: "%x"
		    }
	  });
     	if(clickfunc!=null) {
	$(container).length && $(container).bind("plotclick", function (event, pos, item) {
    		if (item) {
        		var tickClicked = item.series.yaxis.ticks[item.dataIndex].label;         
			clickfunc(tickClicked);
		}
	});
	$(container).length && $(container).bind("plothover", function(event, pos, item) {
	    if(item) {
		document.body.style.cursor = 'pointer';
	    } else {
		document.body.style.cursor = 'default';
	    }
	});
	}
}

function liqChart2ValuePi(val1, val2, label1, label2,container,legendcon) {
	if(val1==0 || val2==0)
		return;
	var da = [];
	da[0] = {
      		label:val1+" "+label1,
      		data: val1,
    	}
	da[1] = {
      		label:val2+" "+label2,
      		data: val2
    	}

	var colorGreen = "#008040";
	var colorRed = "#ff3b30";
	$(container).length && $.plot($(container), da, {
    series: {
      pie: {
        show: true,
	innerRadius : 0.4,
	label: {
                    show: true,
                    radius: 1,
                    formatter: function(label, series){
                        return '<div style="font-size:12pt;text-align:center;color:black;">'+Math.round(series.percent)+'%</div>';
                    },
                    background: { opacity: 0.0 }
                }
      }
    },
    colors: [colorGreen,colorRed],
    legend: {
      show: true,
      container : legendcon,
    },
    grid: {
        hoverable: true,
        clickable: false
    },
    tooltip: true,
    label : {
	show : true,
	radius: 2 / 3,
        threshold: 0.1
    },
    tooltipOpts: {
      content: "%s: %p.0%"
    }
  });

}
function liqChart2LineGraph(vals1,vals2,chartLabel1,chartLabel2,pointLabel,container) {
	var todayDt= (new Date()).getTime();
	var d1 = [];
	var d2 = [];
	var startDt = todayDt - 24*60*60*1000*vals1.length;
	var sum =0;
	for(i=1;i<=vals1.length;i++) {
		var arr = new Array();
		arr[0] =startDt+24*60*60*1000*i;	
		arr[1] =vals1[i-1];
		d1.push(arr);
		var arr2 = new Array();
		arr2[0] =startDt+24*60*60*1000*i;	
		arr2[1] =vals2[i-1];
		d2.push(arr2);
	}
	
	var s1 = new Smooth(d1, { method: 'cubic' });
	var s2 = new Smooth(d2, { method: 'cubic' });
	var d3 = [];
	var d4 = [];
	for(i=0;i<=vals1.length;i=i+0.1) {
		d3.push(s1(i));
		d4.push(s2(i));
	}
	var colorGreen = "#008040";
	var colorRed = "#ff3b30";
  $(container).length && $.plot($(container), [{
          data: d3,
          label: chartLabel1,
	  lines : {show:true, fill:true, lineWidth:0},
	  points : {show: 10, radius: 2},
	  color :colorGreen
      }, {
          data: d4,
	  color : colorRed,
          label: chartLabel2,
	  lines : {show:true, fill:true, lineWidth:0},
	  points : {show: 10, radius: 2},
      }] ,
      {
	series : {
		stack : true
	},
        grid: {
            hoverable: true,
            clickable: true,
            tickColor: "#f0f0f0",
            borderWidth: 1,
            color: '#f0f0f0'
        },
        colors: ["#00B6D6"],
        xaxis:{
		mode:"time",
		tickLength: 0
        },
        yaxis: {
          ticks: (function (axis) {
		var res =[];
		var space = axis.max - axis.min;
		space /=5;
		for(var i=0;i<5;i++) { res[i] = space*i;}
		return res;
        }) },
	legend : {
		backgroundOpacity : 1,
	},
        tooltip: true,
        tooltipOpts: {
          content: pointLabel+" = %y.4",
          defaultTheme: false,
          shifts: {
            x: 0,
            y: 20
          }
        }
      }
  );
}

function liqChartAverageLineGraph(vals,chartLabel,divName) {
	var todayDt= (new Date()).getTime();
	var d1 = [];
	var d2 = [];
	var sum =0;
	var startDt = todayDt - 24*60*60*1000*vals.length;
	for(i=1;i<=vals.length;i++) {
		var arr = new Array();
		arr[0] =startDt+24*60*60*1000*i;	
		arr[1] =vals[i-1];
		sum+=vals[i-1];
		d1.push(arr);
	}
	sum/=(vals.length);
	sum = sum.toFixed(2);
	for(i=1;i<=vals.length;i++) {
		var arr = new Array();
		arr[0] =startDt+24*60*60*1000*i;	
		arr[1] =sum;
		d2.push(arr);
	}
	
	//alert(d1);
  $(divName).length && $.plot($(divName), [{
          data: d1,
          label: chartLabel,
	  splines : {
		 show :true,
		 tension : 0.5,
		 lineWidth:0.1 ,
		 fill:0.3,
	       },
	  lines : {show:false, fill:true ,  curvedLines: { apply: true},
 		fillColor :{
                    colors: [{
                        opacity: 0.0
                    },{
                        opacity: 0.3
                    }, {
                        opacity: 0.5
                    }]
                }
 	  },
	  points : {show:true, radius: 2},
	  color : "#f7941d"
      }, {
          data: d2,
	  color : "#999999",
          label: "Daily Average",
	  lines : {show:true, lineWidth: 0.2, fill: false},
	  points : {show:false}
      }], 
      {
        grid: {
            hoverable: true,
            clickable: true,
            tickColor: "#f0f0f0",
            borderWidth: 1,
            color: '#f0f0f0'
        },
        colors: ["#00B6D6"],
        xaxis:{
		mode:"time",
		timeformat: "%b-%d",
    		monthNames: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
    		minTickSize: [1, "day"],
		tickLength: 0			
        },
        yaxis: {
          ticks: (function (axis) {
		var res =[];
		if(chartLabel == "No Session Centers") 
			var space = axis.max;
		else 
			var space = axis.max - axis.min;
		space /=5;
		for(var i=0;i<5;i++) { res[i] = space*i;}
		return res;
        }) },
	legend : {
		backgroundOpacity : 1,
	},
        tooltip: true,
        tooltipOpts: {
          content: chartLabel+" = %y.4",
          defaultTheme: false,
          shifts: {
            x: 0,
            y: 20
          }
        }
      }
  );
}


/*
 * Smooth.js version 0.1.7
 *
 * Turn arrays into smooth functions.
 *
 * Copyright 2012 Spencer Cohen
 * Licensed under MIT license (see "Smooth.js MIT license.txt")
 * */

/*Constants (these are accessible by Smooth.WHATEVER in user space)
 * */

(function() {
  var AbstractInterpolator, CubicInterpolator, Enum, LinearInterpolator, NearestInterpolator, PI, SincFilterInterpolator, Smooth, clipClamp, clipMirror, clipPeriodic, defaultConfig, getColumn, getType, isValidNumber, k, makeLanczosWindow, makeScaledFunction, makeSincKernel, normalizeScaleTo, shallowCopy, sin, sinc, v, validateNumber, validateVector,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Enum = {
    /*Interpolation methods
 *     */
    METHOD_NEAREST: 'nearest',
    METHOD_LINEAR: 'linear',
    METHOD_CUBIC: 'cubic',
    METHOD_LANCZOS: 'lanczos',
    METHOD_SINC: 'sinc',
    /*Input clipping modes
 *     */
    CLIP_CLAMP: 'clamp',
    CLIP_ZERO: 'zero',
    CLIP_PERIODIC: 'periodic',
    CLIP_MIRROR: 'mirror',
    /* Constants for control over the cubic interpolation tension
 *     */
    CUBIC_TENSION_DEFAULT: 0,
    CUBIC_TENSION_CATMULL_ROM: 0
  };

  defaultConfig = {
    method: Enum.METHOD_CUBIC,
    cubicTension: Enum.CUBIC_TENSION_DEFAULT,
    clip: Enum.CLIP_CLAMP,
    scaleTo: 0,
    sincFilterSize: 2,
    sincWindow: void 0
  };

  /*Index clipping functions
 *   */

  clipClamp = function(i, n) {
    return Math.max(0, Math.min(i, n - 1));
  };

  clipPeriodic = function(i, n) {
    i = i % n;
    if (i < 0) i += n;
    return i;
  };

  clipMirror = function(i, n) {
    var period;
    period = 2 * (n - 1);
    i = clipPeriodic(i, period);
    if (i > n - 1) i = period - i;
    return i;
  };

  /*
 *   Abstract scalar interpolation class which provides common functionality for all interpolators
 *     
 *       Subclasses must override interpolate().
 *         */

  AbstractInterpolator = (function() {

    function AbstractInterpolator(array, config) {
      this.array = array.slice(0);
      this.length = this.array.length;
      if (!(this.clipHelper = {
        clamp: this.clipHelperClamp,
        zero: this.clipHelperZero,
        periodic: this.clipHelperPeriodic,
        mirror: this.clipHelperMirror
      }[config.clip])) {
        throw "Invalid clip: " + config.clip;
      }
    }

    AbstractInterpolator.prototype.getClippedInput = function(i) {
      if ((0 <= i && i < this.length)) {
        return this.array[i];
      } else {
        return this.clipHelper(i);
      }
    };

    AbstractInterpolator.prototype.clipHelperClamp = function(i) {
      return this.array[clipClamp(i, this.length)];
    };

    AbstractInterpolator.prototype.clipHelperZero = function(i) {
      return 0;
    };

    AbstractInterpolator.prototype.clipHelperPeriodic = function(i) {
      return this.array[clipPeriodic(i, this.length)];
    };

    AbstractInterpolator.prototype.clipHelperMirror = function(i) {
      return this.array[clipMirror(i, this.length)];
    };

    AbstractInterpolator.prototype.interpolate = function(t) {
      throw 'Subclasses of AbstractInterpolator must override the interpolate() method.';
    };

    return AbstractInterpolator;

  })();

  NearestInterpolator = (function(_super) {

    __extends(NearestInterpolator, _super);

    function NearestInterpolator() {
      NearestInterpolator.__super__.constructor.apply(this, arguments);
    }

    NearestInterpolator.prototype.interpolate = function(t) {
      return this.getClippedInput(Math.round(t));
    };

    return NearestInterpolator;

  })(AbstractInterpolator);

  LinearInterpolator = (function(_super) {

    __extends(LinearInterpolator, _super);

    function LinearInterpolator() {
      LinearInterpolator.__super__.constructor.apply(this, arguments);
    }

    LinearInterpolator.prototype.interpolate = function(t) {
      var k;
      k = Math.floor(t);
      t -= k;
      return (1 - t) * this.getClippedInput(k) + t * this.getClippedInput(k + 1);
    };

    return LinearInterpolator;

  })(AbstractInterpolator);

  CubicInterpolator = (function(_super) {

    __extends(CubicInterpolator, _super);

    function CubicInterpolator(array, config) {
      this.tangentFactor = 1 - Math.max(0, Math.min(1, config.cubicTension));
      CubicInterpolator.__super__.constructor.apply(this, arguments);
    }

    CubicInterpolator.prototype.getTangent = function(k) {
      return this.tangentFactor * (this.getClippedInput(k + 1) - this.getClippedInput(k - 1)) / 2;
    };

    CubicInterpolator.prototype.interpolate = function(t) {
      var k, m, p, t2, t3;
      k = Math.floor(t);
      m = [this.getTangent(k), this.getTangent(k + 1)];
      p = [this.getClippedInput(k), this.getClippedInput(k + 1)];
      t -= k;
      t2 = t * t;
      t3 = t * t2;
      return (2 * t3 - 3 * t2 + 1) * p[0] + (t3 - 2 * t2 + t) * m[0] + (-2 * t3 + 3 * t2) * p[1] + (t3 - t2) * m[1];
    };

    return CubicInterpolator;

  })(AbstractInterpolator);

  sin = Math.sin, PI = Math.PI;

  sinc = function(x) {
    if (x === 0) {
      return 1;
    } else {
      return sin(PI * x) / (PI * x);
    }
  };

  makeLanczosWindow = function(a) {
    return function(x) {
      return sinc(x / a);
    };
  };

  makeSincKernel = function(window) {
    return function(x) {
      return sinc(x) * window(x);
    };
  };

  SincFilterInterpolator = (function(_super) {

    __extends(SincFilterInterpolator, _super);

    function SincFilterInterpolator(array, config) {
      SincFilterInterpolator.__super__.constructor.apply(this, arguments);
      this.a = config.sincFilterSize;
      if (!config.sincWindow) throw 'No sincWindow provided';
      this.kernel = makeSincKernel(config.sincWindow);
    }

    SincFilterInterpolator.prototype.interpolate = function(t) {
      var k, n, sum, _ref, _ref2;
      k = Math.floor(t);
      sum = 0;
      for (n = _ref = k - this.a + 1, _ref2 = k + this.a; _ref <= _ref2 ? n <= _ref2 : n >= _ref2; _ref <= _ref2 ? n++ : n--) {
        sum += this.kernel(t - n) * this.getClippedInput(n);
      }
      return sum;
    };

    return SincFilterInterpolator;

  })(AbstractInterpolator);

  getColumn = function(arr, i) {
    var row, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      row = arr[_i];
      _results.push(row[i]);
    }
    return _results;
  };

  makeScaledFunction = function(f, baseScale, scaleRange) {
    var scaleFactor, translation;
    if (scaleRange.join === '0,1') {
      return f;
    } else {
      scaleFactor = baseScale / (scaleRange[1] - scaleRange[0]);
      translation = scaleRange[0];
      return function(t) {
        return f(scaleFactor * (t - translation));
      };
    }
  };

  getType = function(x) {
    return Object.prototype.toString.call(x).slice('[object '.length, -1);
  };

  validateNumber = function(n) {
    if (isNaN(n)) throw 'NaN in Smooth() input';
    if (getType(n) !== 'Number') throw 'Non-number in Smooth() input';
    if (!isFinite(n)) throw 'Infinity in Smooth() input';
  };

  validateVector = function(v, dimension) {
    var n, _i, _len;
    if (getType(v) !== 'Array') throw 'Non-vector in Smooth() input';
    if (v.length !== dimension) throw 'Inconsistent dimension in Smooth() input';
    for (_i = 0, _len = v.length; _i < _len; _i++) {
      n = v[_i];
      validateNumber(n);
    }
  };

  isValidNumber = function(n) {
    return (getType(n) === 'Number') && isFinite(n) && !isNaN(n);
  };

  normalizeScaleTo = function(s) {
    var invalidErr;
    invalidErr = "scaleTo param must be number or array of two numbers";
    switch (getType(s)) {
      case 'Number':
        if (!isValidNumber(s)) throw invalidErr;
        s = [0, s];
        break;
      case 'Array':
        if (s.length !== 2) throw invalidErr;
        if (!(isValidNumber(s[0]) && isValidNumber(s[1]))) throw invalidErr;
        break;
      default:
        throw invalidErr;
    }
    return s;
  };

  shallowCopy = function(obj) {
    var copy, k, v;
    copy = {};
    for (k in obj) {
      if (!__hasProp.call(obj, k)) continue;
      v = obj[k];
      copy[k] = v;
    }
    return copy;
  };

  Smooth = function(arr, config) {
    var baseDomainEnd, dimension, i, interpolator, interpolatorClass, interpolators, k, n, properties, smoothFunc, v;
    if (config == null) config = {};
    properties = {};
    config = shallowCopy(config);
    properties.config = shallowCopy(config);
    if (config.scaleTo == null) config.scaleTo = config.period;
    if (config.sincFilterSize == null) {
      config.sincFilterSize = config.lanczosFilterSize;
    }
    for (k in defaultConfig) {
      if (!__hasProp.call(defaultConfig, k)) continue;
      v = defaultConfig[k];
      if (config[k] == null) config[k] = v;
    }
    if (!(interpolatorClass = {
      nearest: NearestInterpolator,
      linear: LinearInterpolator,
      cubic: CubicInterpolator,
      lanczos: SincFilterInterpolator,
      sinc: SincFilterInterpolator
    }[config.method])) {
      throw "Invalid method: " + config.method;
    }
    if (config.method === 'lanczos') {
      config.sincWindow = makeLanczosWindow(config.sincFilterSize);
    }
    if (arr.length < 2) throw 'Array must have at least two elements';
    properties.count = arr.length;
    smoothFunc = (function() {
      var _i, _j, _len, _len2;
      switch (getType(arr[0])) {
        case 'Number':
          properties.dimension = 'scalar';
          if (Smooth.deepValidation) {
            for (_i = 0, _len = arr.length; _i < _len; _i++) {
              n = arr[_i];
              validateNumber(n);
            }
          }
          interpolator = new interpolatorClass(arr, config);
          return function(t) {
            return interpolator.interpolate(t);
          };
        case 'Array':
          properties.dimension = dimension = arr[0].length;
          if (!dimension) throw 'Vectors must be non-empty';
          if (Smooth.deepValidation) {
            for (_j = 0, _len2 = arr.length; _j < _len2; _j++) {
              v = arr[_j];
              validateVector(v, dimension);
            }
          }
          interpolators = (function() {
            var _results;
            _results = [];
            for (i = 0; 0 <= dimension ? i < dimension : i > dimension; 0 <= dimension ? i++ : i--) {
              _results.push(new interpolatorClass(getColumn(arr, i), config));
            }
            return _results;
          })();
          return function(t) {
            var interpolator, _k, _len3, _results;
            _results = [];
            for (_k = 0, _len3 = interpolators.length; _k < _len3; _k++) {
              interpolator = interpolators[_k];
              _results.push(interpolator.interpolate(t));
            }
            return _results;
          };
        default:
          throw "Invalid element type: " + (getType(arr[0]));
      }
    })();
    if (config.clip === 'periodic') {
      baseDomainEnd = arr.length;
    } else {
      baseDomainEnd = arr.length - 1;
    }
    config.scaleTo || (config.scaleTo = baseDomainEnd);
    properties.domain = normalizeScaleTo(config.scaleTo);
    smoothFunc = makeScaledFunction(smoothFunc, baseDomainEnd, properties.domain);
    properties.domain.sort();
    /*copy properties
 *     */
    for (k in properties) {
      if (!__hasProp.call(properties, k)) continue;
      v = properties[k];
      smoothFunc[k] = v;
    }
    return smoothFunc;
  };

  for (k in Enum) {
    if (!__hasProp.call(Enum, k)) continue;
    v = Enum[k];
    Smooth[k] = v;
  }

  Smooth.deepValidation = true;

  (typeof exports !== "undefined" && exports !== null ? exports : window).Smooth = Smooth;

}).call(this);


