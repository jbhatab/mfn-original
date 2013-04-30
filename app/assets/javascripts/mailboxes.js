$(function() {
	// Check all the checkboxes when the head one is selected
	$("tr").delegate(".checkall", "click", function() {
	    $("input[type='checkbox']").attr('checked', $(this).is(':checked'));   
	});
	
	// change current active tabs styles
	$('.ui-state-default a').click(function(){
		$('.ui-state-default').removeClass("ui-tabs-selected");
		$('.ui-state-default').removeClass("ui-state-active");
		$(this).parent().addClass("ui-tabs-selected");
		$(this).parent().addClass("ui-state-active");
		history.pushState(null, document.title, this.href);
	});
	
	// handle pagination through ajax
	$("#tabs-messages .pagination a").on("click", function(e) {
		$.getScript(this.href);
		history.pushState(null, document.title, this.href);
		e.preventDefault();
	});
	
	//bind window for postate
	$(window).bind("popstate", function() {
		$.getScript(location.href);
	});
		
});
