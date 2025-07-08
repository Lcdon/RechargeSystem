<?php
declare (strict_types = 1);

namespace app\middleware;

class Check
{
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure       $next
     * @return Response
     */
    public function handle($request, \Closure $next)
    {
        $lang = $request->header('Accept-Language', 'en'); // 默认英文
        app()->setLocale($lang);
        return $next($request);
    }
}
