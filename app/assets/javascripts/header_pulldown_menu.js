$(document).on('turbolinks:load', function(){
	$("ul.menu li").hover(function(){
		$(">ul:not(:animated)",this).slideDown("fast");
		const setTop = $(">ul",this).offset({
			top: 100,
		});
	},
	function(){
		$(">ul",this).slideUp("fast");
	});
});