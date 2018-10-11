<!DOCTYPE html>

<html>
  <head>
    <title>Variables</title>
  </head>
  
  <body>


    <pre>
     <script language="php">
       print_r($_REQUEST); 
       print_r($GLOBALS);
    </script>
    </pre>


    <?php echo $_SERVER['HTTP_USER_AGENT']; ?>
    <?php 
      foreach ($_SERVER as $key => $value)
      {
      echo $key . " => " . $value . "<br />";
      }
     ?>


    <?php 
      phpinfo(INFO_ENVIRONMENT);
      phpinfo(INFO_VARIABLES);
      // phpinfo();
     ?>


    <?php 
      $var1="Hallo";
      $$var1=20;
      echo "\$var1: ", $var1, "<br />". "\$Hallo: $Hallo <br />";
     ?>


  </body>

</html>

