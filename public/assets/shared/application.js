(function(){$(function(){var a;return a=window.location.hostname,$("a").each(function(b,c){if(c.hostname!==a&&!c.href.match("javascript"))return $(c).attr({target:"_blank","data-skip-pjax":"true"})})})}).call(this)