<?php $w=[];for($i=fgets(STDIN)-0;$i>0;$i--){$x=trim(fgets(STDIN));if($w[$x])$w[$x]++;else$w[$x]=1;}ksort($w);$s=$c='';foreach($w as$k=>&$v){$r=strrev($k);if(!$w[$r])continue;$m=min($v,$w[$r]);$v=0;if($k==$r){$m%2==1&&(!$c||$k<$c)&&$c=$k;$m/=2;}$s.=str_repeat($k,$m);}echo$s.$c.strrev($s);