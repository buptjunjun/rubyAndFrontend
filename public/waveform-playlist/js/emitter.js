/*
 * This script is provided to give an example how the playlist can be controlled using the event emitter.
 * This enables projects to create/control the useability of the project.
*/
var ee = playlist.getEventEmitter();
var $container = $("body");
var $timeFormat = $container.find('.time-format');
var $audioStart = $container.find('.audio-start');
var $audioEnd = $container.find('.audio-end');
var $time = $container.find('.audio-pos');

var format = "thousandths";
var startTime = 0;
var endTime = 0;
var audioPos = 0;

function toggleActive(node) {
  var active = node.parentNode.querySelectorAll('.active');
  var i = 0, len = active.length;

  for (; i < len; i++) {
    active[i].classList.remove('active');
  }

  node.classList.toggle('active');
}

function cueFormatters(format) {

  function clockFormat(seconds, decimals) {
      var hours,
          minutes,
          secs,
          result;

      hours = parseInt(seconds / 3600, 10) % 24;
      minutes = parseInt(seconds / 60, 10) % 60;
      secs = seconds % 60;
      secs = secs.toFixed(decimals);

      result = (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (secs < 10 ? "0" + secs : secs);

      return result;
  }

  var formats = {
      "seconds": function (seconds) {
          return seconds.toFixed(0);
      },
      "thousandths": function (seconds) {
          return seconds.toFixed(3);
      },
      "hh:mm:ss": function (seconds) {
          return clockFormat(seconds, 0);   
      },
      "hh:mm:ss.u": function (seconds) {
          return clockFormat(seconds, 1);   
      },
      "hh:mm:ss.uu": function (seconds) {
          return clockFormat(seconds, 2);   
      },
      "hh:mm:ss.uuu": function (seconds) {
          return clockFormat(seconds, 3);   
      }
  };

  return formats[format];
}

function updateSelect(start, end) {

  console.log(start + "->" + end )
//  if (start < end) {
//    $('.btn-trim-audio').removeClass('disabled');
//  }
//  else {
//    $('.btn-trim-audio').addClass('disabled');
//  }
//
//  $audioStart.val(cueFormatters(format)(start));
//  $audioEnd.val(cueFormatters(format)(end));

  startTime = start;
  endTime = end;

  var $radio = $('input:radio[name="position"]:checked');
  if (!!$radio == true)
  {
     var $postion_start =  $radio.parent().parent().find(".postion_start");
     var $postion_end =  $radio.parent().parent().find(".postion_end");
      $postion_start.val(cueFormatters(format)(start));
      $postion_end.val(cueFormatters(format)(end));
  }

}

function updateTime(time) {
  $time.html(cueFormatters(format)(time));

  audioPos = time;
}

updateSelect(startTime, endTime);
updateTime(audioPos);



/*
* Code below sets up events to send messages to the playlist.
*/
$container.on("click", ".btn-playlist-state-group", function() {
  //reset these for now.
  $('.btn-fade-state-group').addClass('hidden');
  $('.btn-select-state-group').addClass('hidden');

  if ($('.btn-select').hasClass('active')) {
    $('.btn-select-state-group').removeClass('hidden');
  }

  if ($('.btn-fadein').hasClass('active') || $('.btn-fadeout').hasClass('active')) {
    $('.btn-fade-state-group').removeClass('hidden');
  }
});

$container.on("click", ".btn-play", function() {
  ee.emit("play");
  console.log("play");
});

$container.on("click", ".btn-pause", function() {
  ee.emit("pause");
  console.log("play");
});

$container.on("click", ".btn-stop", function() {
  ee.emit("stop");
});

$container.on("click", ".btn-rewind", function() {
  ee.emit("rewind");
  console.log("rewind");
});

$container.on("click", ".btn-fast-forward", function() {
  ee.emit("fastforward");
});

$container.on("click", ".btn-record", function() {
  ee.emit("record");
});

//track interaction states
$container.on("click", ".btn-cursor", function() {
  ee.emit("statechange", "cursor");
  toggleActive(this);
    console.log("111");
});

$container.on("click", ".btn-select", function() {
  ee.emit("statechange", "select");
  toggleActive(this);
  console.log("22");
});

$container.on("click", ".btn-shift", function() {
  ee.emit("statechange", "shift");
  toggleActive(this);
});

$container.on("click", ".btn-fadein", function() {
  ee.emit("statechange", "fadein");
  toggleActive(this);
});

$container.on("click", ".btn-fadeout", function() {
  ee.emit("statechange", "fadeout");
  toggleActive(this);
});

//fade types
$container.on("click", ".btn-logarithmic", function() {
  ee.emit("fadetype", "logarithmic");
  toggleActive(this);
});

$container.on("click", ".btn-linear", function() {
  ee.emit("fadetype", "linear");
  toggleActive(this);
});

$container.on("click", ".btn-scurve", function() {
  ee.emit("fadetype", "sCurve");
  toggleActive(this);
});

$container.on("click", ".btn-exponential", function() {
  ee.emit("fadetype", "exponential");
  toggleActive(this);
});

//zoom buttons
$container.on("click", ".btn-zoom-in", function() {
  ee.emit("zoomin");
});

$container.on("click", ".btn-zoom-out", function() {
  ee.emit("zoomout");
});

$container.on("click", ".btn-trim-audio", function() {
  ee.emit("trim");
});

$container.on("click", ".btn-info", function() {
  console.log(playlist.getInfo());
});

//track drop
$container.on("dragenter", ".track-drop", function(e) {
  e.preventDefault();
  e.target.classList.add("drag-enter");
});

$container.on("dragover", ".track-drop", function(e) {
  e.preventDefault();
});

$container.on("dragleave", ".track-drop", function(e) {
  e.preventDefault();
  e.target.classList.remove("drag-enter");
});

$container.on("drop", ".track-drop", function(e) {
  e.preventDefault();
  e.target.classList.remove("drag-enter");

  var dropEvent = e.originalEvent;

  for (var i = 0; i < dropEvent.dataTransfer.files.length; i++) {
    ee.emit("newtrack", dropEvent.dataTransfer.files[i]);
  }
});

$container.on("change", ".time-format", function(e) {
  format = $timeFormat.val();

  updateSelect(startTime, endTime);
  updateTime(audioPos);
});



/*
* Code below receives updates from the playlist.
*/
ee.on("select", updateSelect);
ee.on("timeupdate", updateTime);

$(function(){
    setTimeout(function(){
        ee.emit("zoomin");
        ee.emit("zoomin");
        $(".btn-select").click();
    },500);

    $(".play_range").on("click",function(){

       var $parent = $(this).parent();
       $parent.find(".select_radio").prop("checked",true);
       var start = $parent.find(".postion_start").val();
       var end =   $parent.find(".postion_end").val();

       console.log("play selected:"+start+"->"+end);

        var start_num = parseFloat(start);
        var end_num = parseFloat(end);

       if (Boolean(start_num) == false || Boolean(end_num) == false )
       {
            return;
       }

       start_num+=0.0001;
       ee.emit("select", start_num, end_num, playlist.tracks[0]);
       ee.emit("play");
    });
})