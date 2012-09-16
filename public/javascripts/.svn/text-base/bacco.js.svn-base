function toggle_visibility(id) {
  element = document.getElementById(id);
  if(element.style.visibility == 'hidden') {
    element.style.visibility = 'visible';
  } else {
    element.style.visibility = 'hidden';
  }
}

function toggle_display(id) {
  element = document.getElementById(id);
  if(element.style.display == 'none') {
    element.style.display = 'block';
  } else {
    element.style.display = 'none';
  }
}

function toggle_display_based_on(base_id, id) {
  element = document.getElementById(id);
  base_element = document.getElementById(base_id);
  if(base_element.style.display == 'none') {
    element.style.display = 'block';
  } else {
    element.style.display = 'none';
  }
}

function make_visible(id) {
  element = document.getElementById(id);
  element.style.visibility = 'visible';
}

function make_invisible(id) {
  element = document.getElementById(id);
  element.style.visibility = 'hidden';
}

function change_text_color(id,color) {
  element = document.getElementById(id);
  element.style.color = color;
}

function form_reset(id) {
  element = document.getElementById(id);
  element.reset();
}

function change_image(id,new_image){
  document.getElementById(id).src = new_image;
}

function move(id, dx, dy) {
  element = document.getElementById(id);
  style = element.style;
  style.left=parseInt(style.left)+dx+"px"
  style.top=parseInt(style.top)+dy+"px"
}

function copy_value(receiver_id, giver_id) {
  document.getElementById(receiver_id).value = document.getElementById(giver_id).value;
}

function send(form_id) {
  document.getElementById(form_id).submit();
}

function get_projeto_id(text, li) {
  if (li.id != '') {
    id = li.id;
    document.getElementById('bacco_projeto_mes_id').value = id;
    foto = document.getElementById('foto_preview');
    if(li.title != '') {
      foto.src = li.title;
      foto.alt = 'Destaque de '+text.value;
    } else {
      foto.src = '';
      foto.alt = text.value+' não tem foto destaque';
    }
  }
}

function change_foto_principal (id_campo_destaque, foto_id, foto_path) {
  old_foto_id = document.getElementById(id_campo_destaque).value;
  document.getElementById(id_campo_destaque).value = foto_id;
  change_image('foto_grande', foto_path);
  image = document.getElementById('foto_'+old_foto_id);
  if(image != null) {
    image.className = "normal";
  }
  new_image = document.getElementById('foto_'+foto_id);
  new_image.className = "highlighted";
}

function atualiza_pos() {
  point = my_marker.getPoint();
  map.savePosition();
  document.getElementById('latitude').value = point.lat();
  document.getElementById('longitude').value = point.lng();
  return false;
}
