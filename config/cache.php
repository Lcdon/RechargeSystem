<?php

// +----------------------------------------------------------------------
// | Static Plugin for ThinkAdmin
// +----------------------------------------------------------------------
// | 版权所有 2014~2024 ThinkAdmin [ thinkadmin.top ]
// +----------------------------------------------------------------------
// | 官方网站: https://thinkadmin.top
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// | 免责声明 ( https://thinkadmin.top/disclaimer )
// +----------------------------------------------------------------------
// | gitee 代码仓库：https://gitee.com/zoujingli/think-plugs-static
// | github 代码仓库：https://github.com/zoujingli/think-plugs-static
// +----------------------------------------------------------------------

return [
    // 默认缓存驱动
    'default' => 'redis',
    // 缓存连接配置
    'stores'  => [
        'file' => [
            // 驱动方式
            'type'       => 'File',
            // 缓存保存目录
            'path'       => '',
            // 缓存名称前缀
            'prefix'     => '',
            // 缓存有效期 0 表示永久缓存
            'expire'     => 0,
            // 缓存标签前缀
            'tag_prefix' => 'tag:',
            // 序列化机制
            'serialize'  => [],
        ],
        'safe' => [
            // 驱动方式
            'type'       => 'File',
            // 缓存保存目录
            'path'       => syspath('safefile/cache/'),
            // 缓存名称前缀
            'prefix'     => '',
            // 缓存有效期 0 表示永久缓存
            'expire'     => 0,
            // 缓存标签前缀
            'tag_prefix' => 'tag:',
            // 序列化机制
            'serialize'  => [],
        ],
        'redis'   => [
            // 驱动方式
            'type'   => 'redis',
            // 服务器地址
            'host'   => env('redis.host', '127.0.0.1'),
            // 端口
            'port'   => env('redis.port', 6379),
            // 密码
            'password' => env('redis.password', ''),
            // 缓存有效期
            'expire'  => 0,
            // 缓存前缀
            'prefix'  => env('cache.prefix', ''),
            // 数据库索引
            'select'  => intval(env('redis.select', 0)),
            // 连接超时
            'timeout' => 0,
            // 是否持久化连接
            'persistent' => false,
        ],
    ],
];