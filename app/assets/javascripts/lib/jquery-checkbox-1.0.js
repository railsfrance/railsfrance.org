/**
 * jQuery custom checkboxes
 * 
 * Copyright (c) 2010 Tomasz Wójcik (bthlabs.pl)
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * @version 1.0
 * @category visual
 * @package jquery
 * @subpakage ui.checkbox
 * @author Tomasz Wójcik <tomek@bthlabs.pl>
**/
jQuery.fn.checkbox = function(options) {
	var defaults = {
		className: 'jquery-checkbox',
		checkedClass: 'jquery-checkbox-on'
	};
	
	var settings = jQuery.extend(defaults, options || {});
	
	return this.each(function() {
		var _this = jQuery(this);
		
		var _replacement = jQuery(
			'<div class="' + settings.className + '-wrapper">' +
				'<a class="' + settings.className + '" href="#" name="' + _this.attr('id') + '"></a>' + 
			'</div>'
		);
		
		if (_this.prop('checked') == true) {
			jQuery('a', _replacement).addClass(settings.checkedClass);
		} // eof if()
		
		jQuery('a', _replacement).click(function() {
			var _input = jQuery('input#' + jQuery(this).attr('name'), _replacement.parent());
			if (_input.prop('checked') == true) {
				_input.removeAttr('checked');
			} else {
				_input.attr('checked', true);
			} // eof if()
			_input.change();
			
			return false;
		});
		jQuery(_this).change(function() {
			var _input = jQuery(this);
			if (_input.prop('checked') == true) {
				jQuery('a[name=' + _input.attr('id') + ']', _replacement.parent()).addClass(settings.checkedClass);
			} else {
				jQuery('a[name=' + _input.attr('id') + ']', _replacement.parent()).removeClass(settings.checkedClass);
			} // eof if()
		});
		
		_this.css({ 'position': 'absolute', 'top': '-200px', 'left': '-200px'}).before(_replacement);
		_replacement.parent().css('overflow', 'hidden');
	});
};