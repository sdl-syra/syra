$(document).ready(function(){
	$("#avanced").click(function() {
	  $( this ).css({
	    cursor: "wait"
	  });
	  $( "#avancedClose" ).css("cursor", "pointer" );
	  $( "#avancedparams" ).slideDown( "fast", function() {
	    $("#recherche").hide();
	    $( "#avanced" ).hide();
	    $( "#avancedClose" ).show();
	    $( "#avancedClose" ).css("display", "block" );
	  });
	});
});

$(document).ready(function(){
	$("#avancedClose").click(function() {
	  $( this ).css({
	    cursor: "wait"
	  });
	  $( "#avanced" ).css("cursor", "pointer" );
	  $( "#avanced" ).css("display", "block" );
	  $( "#avancedClose" ).hide();
	
	  // on vide les attributs avancés
	
	  // on decoche tout
	   var cases = $("#check").find(':checkbox');
	   cases.attr('checked', false);
	
	  // on supprime la ville
	  $("#ville_textfield:text").val('');
	
	  // on place le select à 'select'
	  $("#q_address_region_cont option:first").attr("selected", "selected");
	
	  // les valeurs min et max du prix
	   $("#slider_prix").slider({
	        range:  true,
	        min:    0,          // valeur min
	        max:    100,       // valeur max
	        values: [0, 40],   // position des 2 curseurs à l'initialisation
	         
	        // Action à effectuer lorsqu'on déplace l'un des curseur
	        slide: function(event, ui){
	            $('#prix_min').html(ui.values[0]);
	            $('#prix_max').html(ui.values[1]);
	            $('#q_price_gteq').val(ui.values[0]);
	            $('#q_price_lteq').val(ui.values[1]);
	        }
	    });
	    $('#prix_min').html($("#slider_prix").slider("values", 0));
	    $('#prix_max').html($("#slider_prix").slider("values", 1));
	    $('#q_price_gteq').val($("#slider_prix").slider("values", 0));
	    $('#q_price_lteq').val($("#slider_prix").slider("values", 1));
	
	
	  $( "#avancedparams" ).slideUp( "fast", function() {
	    $("#recherche").show();
	    $( "#avancedClose" ).hide();
	    $( "#avanced" ).show();
	  });
	});
});

$(document).ready(function(){
	$("#regionB").click(function() {
	  $( this ).css({
	    cursor: "wait"
	  });
	  $("#regionB").hide();
	  // on supprime la ville
	  $("#ville_textfield:text").val('');
	  if ( $( "#ville" ).is( ":hidden" ) ) {
	  } else {
	    $( "#ville" ).hide();
	    $( "#villeB" ).css("cursor", "pointer" );
	    $( "#villeB" ).show();
	  }
	  $( "#region" ).slideDown( "fast", function() {
	  });
	});
});

$(document).ready(function(){
	$("#villeB").click(function() {
	  $( this ).css({
	    cursor: "wait"
	  });
	  $("#villeB").hide();
	  // on supprime la région
	  $("#q_address_region_cont option:first").attr("selected", "selected");

	  if ( $( "#region" ).is( ":hidden" ) ) {
	  } else {
	    $( "#region" ).hide();
	    $( "#regionB" ).css("cursor", "pointer" );
	    $( "#regionB" ).show();
	  }
	  $( "#ville" ).slideDown( "fast", function() {   
	    
	  });
	});
});

$(document).ready(function($){
    // On vide le champs Ville
    //$("#ville_textfield:text").val('');

    // Création d'un slider dans l'élément id slider_prix
    $("#slider_prix").slider({
        range:  true,
        min:    0,          // valeur min
        max:    100,       // valeur max
        values: [0, 40],   // position des 2 curseurs à l'initialisation
         
        // Action à effectuer lorsqu'on déplace l'un des curseur
        slide: function(event, ui){
            $('#prix_min').html(ui.values[0]);
            $('#prix_max').html(ui.values[1]);
            $('#q_price_gteq').val(ui.values[0]);
            $('#q_price_lteq').val(ui.values[1]);
        }
    });
     
    // Initialisation des valeurs numériques au chargement de la page
    //$('#prix_min').html($("#slider_prix").slider("values", 0));
    $('#prix_max').html($("#slider_prix").slider("values", 1));
    //$('#q_price_gteq').val($("#slider_prix").slider("values", 0));
    $('#q_price_lteq').val($("#slider_prix").slider("values", 1));
});

$(document).ready(function(){
	if ($("#lessuggestionsdemandes").length!=1) {
		$.ajax({
			  url: "/get_suggestions_demandes",
			  type: "get"
			});
	}
});
