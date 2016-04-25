backend mean {
     .host = "localhost";
     .port = "3000";
 }
 backend drupal {
      .host = "localhost";
      .port = "8080";
 }
 sub vcl_recv {
    if (req.http.host == "local.myelx.com") {
        #You will need the following line only if your backend has multiple virtual host names
        set req.http.host = "mean";
        set req.backend = mean;
        return (lookup);
    }
    if (req.http.host == "localmyelx.cloudapp.net") {
        #You will need the following line only if your backend has multiple virtual host names
        set req.http.host = "drupal";
        set req.backend = drupal;
        return (lookup);
    }
 }