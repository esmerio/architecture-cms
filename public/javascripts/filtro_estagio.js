var mapa_estagios = {}

function adiciona_projeto(projeto_id, estagios) {
  mapa_estagios[projeto_id] = estagios;
}

function filtra_projetos(projetos) {
  var i;
  for(i = 0; i < projetos.length; i++) {
    if(pode_mostrar(projetos[i])) {
      mostra(projetos[i]);
    }
    else {
      esconde(projetos[i]);
    }
  }
  var tabela = document.getElementById("conteudo_tabela");
  if(tabela.scrollUpdate)
    tabela.scrollUpdate();
}

function pode_mostrar(projeto_id) {
  var i;
  estagios = mapa_estagios[projeto_id];
  for(i = 0; i < estagios.length; i++) {
    if(!aparece(estagios[i])) {
      return false;
    }
  }
  return true;
}

function aparece(id) {
  element = document.getElementById(id);
  return element.style.display != 'none';
}

function mostra(id) {
  element = document.getElementById(id);
  element.style.display = 'block';
}

function esconde(id) {
  element = document.getElementById(id);
  element.style.display = 'none';
}
