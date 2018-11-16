
//import {Sortable, Plugins} from '@shopify/draggable';
//= require jquery
//= require jquery_ujs
//import Rails from 'rails.ujs';
//Rails.start();

function newTaskFunction(x,y,id_num, taskInfo) {
    
  if (x==-1){
      x = 15;
      y = 582;
  }
  var mousePosition;
var offset = [0,0];
var div;
var isDown = false;
var wasDragged = false;

div = document.createElement("div");
div.style.position = "absolute";
div.style.left = x + "px";
div.style.top = y + "px";
div.style.width = "100px";
div.style.height = "100px";
div.style.background = "yellow";
div.style.color = "blue";
div.setAttribute("id",id_num);
div.innerHTML = taskInfo; 
//window.alert(id_num.toString());

document.body.appendChild(div);

div.addEventListener('click', function(e) {
    if (wasDragged === false){
        //This block is for single click action
        var boardID;
        jQuery.ajax({
            async: false,
            type: "get",
            url: "/tasks/ajax_show",
            dataType: "json",
            data: {id: id_num},
            success: function(json){
                boardID=parseInt(json.board_id,10);
                window.location = `${json.board_id}/tasks/${id_num}`;
            },
            error: function(exception){alert("didn't fetch task correctly");}
        });
        
        /*
        jQuery.ajax({
            type: "get",
            url: "/boards/1/tasks/18",
            
            success: function(exception){},
            error: function(exception){alert("didn't fetch task correctly");}
        });*/
        
        
    }
    wasDragged = false;
}, true);

div.addEventListener('mousedown', function(e) {
    isDown = true;
    
    offset = [
        div.offsetLeft - e.clientX,
        div.offsetTop - e.clientY
    ];
}, true);

document.addEventListener('mouseup', function() {
    if (isDown){
        jQuery.ajax({
                    type: "post",
                    url: "/tasks/update_pos",
                    dataType: "text",
                    data: {newX: parseInt(div.style.left,10), newY: parseInt(div.style.top, 10), id: id_num},
                    success: function(exception){}, 
                    error: function(exception){alert("Unable to save new position!");}
                    });
    }
    isDown = false;
    
}, true);

document.addEventListener('mousemove', function(event) {
    event.preventDefault();
     
    if (isDown) {
        wasDragged = true;
        mousePosition = {
            

            x : event.clientX,
            y : event.clientY

        };
        div.style.left = (mousePosition.x + offset[0]) + 'px';
        div.style.top  = (mousePosition.y + offset[1]) + 'px';
    }
}, true);
}
//dragElement(document.getElementById("taskBox"));