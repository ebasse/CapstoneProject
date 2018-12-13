//import {Sortable, Plugins} from '@shopify/draggable';
//= require jquery
//= require jquery_ujs
//import Rails from 'rails.ujs';
//Rails.start();

function MakeBoardsClickable(){
    var elements = document.getElementsByClassName('ExistingBoards');
    var i;
    for (i = 0; i < elements.length; i++) {
        var element = elements[i];
        element.addEventListener('click', function() {
            var href = parseInt(this.dataset.id);
            
            
            if (href) {
                console.log("hello1");
                window.location = `boards/${href}`;
            }
        });
    }
}