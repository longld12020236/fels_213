function new_answer(link, association, content) {
  numberAnswer = $('.answer').length
  if (numberAnswer >= 6) {
    alert("You only can create 2 - 4 answers for each word");
    return;
  }
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id));
}
