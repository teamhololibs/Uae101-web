<?php
require_once '../admin.common.prepend.php';
?>

</div>
<div class="footer">
    <a href="#top" class="a_top"><img src="/images/top-arrow.png" width="40"></a>
    Page load took: <?
    global $page_load_time;
    echo round(microtime(true) - $page_load_time, 3)
    ?> seconds.
</div>
</div>
</body>
</html>