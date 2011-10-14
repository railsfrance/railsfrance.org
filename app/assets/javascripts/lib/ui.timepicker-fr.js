jQuery(function($){
	$.datepicker.regional['fr'] = {clearText: 'Effacer', clearStatus: '',
		prevText: '<Préc', prevStatus: 'Voir le mois précédent',
		nextText: 'Suiv>', nextStatus: 'Voir le mois suivant',
		monthNames: ['Janvier','Février','Mars','Avril','Mai','Juin',
		'Juillet','Août','Septembre','Octobre','Novembre','Décembre'],
		monthNamesShort: ['Jan','Fév','Mar','Avr','Mai','Jun',
		'Jul','Aoû','Sep','Oct','Nov','Déc'],
		weekHeader: 'Sm', weekStatus: '',
		dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
		dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'],
		dayNamesMin: ['Di','Lu','Ma','Me','Je','Ve','Sa'],
		dateFormat: 'dd/mm/yy', firstDay: 0,
		initStatus: 'Choisir la date', isRTL: false};
	$.datepicker.setDefaults($.datepicker.regional['fr']);
});
