var states= new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
        url: '/search_state/%QUERY',
        wildcard: '%QUERY',
        cache: false
    }
});
$(document).ready(function(){
  
    $('.typeahead').typeahead(null, {
        name: 'id',
        display: 'name',
        source: states
       });
$('.typeahead').on('typeahead:selected', function(evt, item) {
    console.log("on select event fired" + $('.typeahead')[1].value);
    let name = $('.typeahead')[1].value;
    console.log (name);
    $.get( "/get_counties_for_statename/" + name, function(data) {
    console.log("Vegetables are good for you!");
    });
    // remote: {
    //     url: '/get_counties_for_statename/%item',
    //     wildcard: '%item',
    //     cache: false
    // }
});

 });

