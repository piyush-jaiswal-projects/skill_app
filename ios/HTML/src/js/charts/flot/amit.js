/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function liqChartIRGraph(vals1,vals2,chartLabel1,chartLabel2,pointLabel,container,module) {
    //var todayDt= (new Date()).getTime();
    var d1 = [];
    var d2 = [];
    //var startDt = todayDt - 24*60*60*1000*vals1.length;
    //var sum =0;
    var num_modules = module ;//<GET FROM DB>;
    for(i=1;i<num_modules;i++) {
        var arr = new Array();
        arr[0] =i;
        arr[1] =vals1[i-1];
        d1.push(arr);
        var arr2 = new Array();
        arr2[0] =i;
        arr2[1] =vals2[i-1];
        d2.push(arr2);
    }
    var colorGreen = "#008040";
    var colorRed = "#ff3b30";
  $(container).length && $.plot($(container), [{
          data: d1,
          label: chartLabel1,
      lines : {show:true, fill:false, lineWidth:2},
      points : {show: 10, radius: 2},
      color :colorGreen
      }, {
          data: d2,
      color : colorRed,
          label: chartLabel2,
      lines : {show:true, fill:false, lineWidth:2},
      points : {show: 10, radius: 2}
      }] ,
      {
    series : {
        stack : false
    },
        grid: {
            hoverable: true,
            clickable: true,
            tickColor: "#f0f0f0",
            borderWidth: 1,
            color: '#f0f0f0'
        },
        colors: ["#00B6D6"],
        xaxis: { mode: "time",minTickSize: [1, "day"],
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
        backgroundOpacity : 1
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