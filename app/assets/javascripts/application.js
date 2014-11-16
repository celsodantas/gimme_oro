// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-datepicker
//= require best_in_place
//= require jquery.tagsinput
//= require jquery-ui
//= require_tree .

$(document).ready(function() {
  /* Activating Best In Place */
  $(".best_in_place").best_in_place();

  $('.budget-tags').tagsInput({
    autocomplete_url: 'budgets/autocomplete',
    autocomplete: {
      selectFirst:true,
      width:'100px',
      autoFill:true
    },
    defaultText: 'add...',
    height: '30px',
    width: '240px',
    onAddTag: updateEntryBudget,
    onRemoveTag: updateEntryBudget,
  });

  function updateEntryBudget (budget) {
    var row = $(this).parents("tr")
    var url = $(this).data("remote")
    var budgets = this.value

    var flashRow = function() {
      $(this).parents("td").effect("highlight", {color: "#4BADF5"} ,1000)
    };

    $.ajax(url, {
        type: 'PUT',
        data: {
          entry: { budgets_list: budgets }
        },
        context: this
    }).done(flashRow)
  }
});


