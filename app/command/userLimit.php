<?php
declare (strict_types = 1);

namespace app\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use app\service\User; // 引入User服务

class UserLimit extends Command
{
    // 配置命令名称和描述
    protected function configure()
    {
        $this->setName('user_limit')
            ->setDescription('更新用户每日限额剩余量');
    }

    // 执行命令逻辑
    protected function execute(Input $input, Output $output)
    {
        $output->writeln('开始更新用户限额...');

        // 实例化User服务并调用更新方法
        $userService = new User();
        $userService->updateUserLimit();

        $output->writeln('用户限额更新完成');
    }
}
