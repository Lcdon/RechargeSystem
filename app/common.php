<?php
function CodeMsg($msg){
    $arr = [
        'fail'      =>201,
        'success'   =>1
    ];
    return $arr[$msg];
}