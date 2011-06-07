  document.getElementById('commenterrors').style.visibility = 'hidden';
 function checkCommet(){
    alert();
     if(document.all['comment_body'].value==""){
      document.getElementById('comment_errors').style.display='block';
     }else{
      document.getElementById('comment_errors').style.display='none';
     }
  }