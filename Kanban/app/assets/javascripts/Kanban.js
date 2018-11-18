
//import {Sortable, Plugins} from '@shopify/draggable';
//= require jquery
//= require jquery_ujs
//import Rails from 'rails.ujs';
//Rails.start();

function newTaskFunction(x,y,id_num, taskInfo) {
    
  if (x==-1){
      x = 10;
      y = 30;
  }
  
  var mousePosition;
var offset = [0,0];
var div;
var isDown = false;
var wasDragged = false;

div = document.createElement("div");
div.style.position = "absolute";
div.style.left = x + "%";
div.style.top = y + "%";
div.style.width = "100px";
div.style.height = "100px";
div.style.background = "yellow";
div.style.color = "blue";
div.setAttribute("id",id_num);
div.innerHTML = taskInfo; 
div.style.zIndex = 10;
//window.alert(id_num.toString());
document.getElementById("board").appendChild(div);

div.addEventListener('click', function(e) {
    if (wasDragged === false){
        //This block is for single click action
        var boardID;
        
        //Make an AJAX cll to retrieve the board id of this task (need board id to go to correct url to
        //display task)
        jQuery.ajax({
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
        //When the task is released, update the position values in the database through AJAX call
        jQuery.ajax({
                    type: "post",
                    url: "/tasks/update_pos",
                    dataType: "text",
                    data: {newX: parseFloat(div.style.left), newY: parseFloat(div.style.top), id: id_num},
                    success: function(exception){}, 
                    error: function(exception){}
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
        div.style.left = (((mousePosition.x + offset[0])/window.innerWidth)*100) + '%';
        div.style.top  = (((mousePosition.y + offset[1])/window.innerHeight)*100) + '%';
        //alert((document.getElementById("board").getBoundingClientRect().top/window.innerHeight)*100);
        //alert(div.style.top);
        if (parseFloat(div.style.top) < parseFloat((document.getElementById("board").getBoundingClientRect().top/window.innerHeight)*100)){
            div.style.top = (document.getElementById("board").getBoundingClientRect().top/window.innerHeight)*100 + '%';
        }
    }
}, true);


//This function causes the board to update task positions every 300 milliseconds
//Allows users to see changes made by other team members without having to refresh page
window.setInterval(
    function(){
        
        if (isDown == false && wasDragged == false){
            jQuery.ajax({
            type: "get",
            url: "/tasks/get_pos",
            dataType: "json",
            data: {id: id_num},
            success: function(json){
                div.style.left=json.new_x +'%';
                div.style.top = json.new_y + '%';
            },
            error: function(exception){
            }
        });
            if (parseFloat(div.style.top) < parseFloat((document.getElementById("board").getBoundingClientRect().top/window.innerHeight)*100)){
                div.style.top = (document.getElementById("board").getBoundingClientRect().top/window.innerHeight)*100 + '%';
            }
        }
        else{
            jQuery.ajax({
                    type: "post",
                    url: "/tasks/update_pos",
                    dataType: "text",
                    data: {newX: parseFloat(div.style.left), newY: parseFloat(div.style.top), id: id_num},
                    success: function(exception){}, 
                    error: function(exception){}
                    });
        }
    }, 3000);
}
//dragElement(document.getElementById("taskBox"));