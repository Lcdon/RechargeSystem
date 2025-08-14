<?php
// 文件路径：app/job/MyJob.php
namespace app\job;

class MyJob
{
    /**
     * 任务处理逻辑
     * @param mixed $data 任务数据
     */
    public function handle($data)
    {
        // 执行具体的任务逻辑
        // 例如：处理充值订单、发送通知等
        echo "处理任务数据：" . json_encode($data);
    }
}
