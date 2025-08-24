<?php

namespace app\admin\controller;

use think\admin\Controller;
use app\admin\model\EquipmentUserBindModel as EUB;
use app\admin\model\EquipmentModel;
use app\admin\model\RechargeTaskModel as RT;
use think\admin\model\SystemUser;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Cache;
use think\response\Json;
use think\facade\View;

class Addtaskapi extends Controller
{
    /**
     * 添加任务
     * @return Json
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function addTaskApi(): Json
    {
        $data = $this->_vali([
            'msisdn.require'=>'msisdn is null',
            'er_amount.require'=>'er_amount is null',
            'username.require'=>'username is null',
            'password.require'=>'password is null',
        ]);

        $map = ['username' => $data['username'], 'is_deleted' => 0];
        $user = SystemUser::mk()->where($map)->findOrEmpty();
        if($user->isEmpty()){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'username is not exist';
            return json($response);
        }

        if($user->status==0){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'user is disabled';
            return json($response);
        }

        $user_id = $user->id;

        if(md5($data['password'])!=$user->password){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'password is incorrect';
            return json($response);
        }

        if($data['er_amount']<5 or $data['er_amount']>200){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'recharge er_amount needs to be between 5 and 200';
            return json($response);
        }

        $equipment_id = EUB::where('system_user_id',$user_id)->find()->equipment_id;
//        $data['equipment_name'] = EquipmentModel::where(['id'=>$equipment_id])->find()->equipment_name;
        $data['system_user_id'] = $user_id;
        $data['state'] = 0;
        $data['state_msg'] = '待分配';
        $data['equipment_id'] = $equipment_id;

        $data['recharge_tel'] = $data['msisdn'];
        $data['amount'] = $data['er_amount'];
        unset($data['msisdn']);
        unset($data['er_amount']);

        $add = new RT;
        $add->save($data);
        $response['code'] = CodeMsg('success');
        $response['msg'] = 'success';
        return json($response);
    }

    /**
     * 任务派发
     * @return Json
     */
    public function pop_task_api(): Json
    {
        $equipment_id = input('equipment_id');
        $redis = Cache::store('redis')->handler();
        $queue_name = 'equipment_'.$equipment_id;
        $task = $redis->rpop($queue_name);
        if($task){
            return json(['code'=>1,'msg'=>'success','data'=>$task]);
        }else{
            return json(['code'=>0,'msg'=>'no task']);
        }
    }


    /**
     * 查看Redis队列状态
     */
    public function getRedisQueues(): string
    {

        $redis = Cache::store('redis')->handler();

        // 获取所有设备相关队列
        $equipmentKeys = $redis->keys('equipment_*');
        $rechargeMethodKeys = $redis->keys('*_equipment_*');

        // 合并并去重队列键
        $allKeys = array_unique(array_merge($equipmentKeys, $rechargeMethodKeys));

        $queues = [];
        foreach ($allKeys as $key) {
            $queues[] = [
                'queue_name' => $key,
                'length' => $redis->llen($key),
                'update_time' => date('Y-m-d H:i:s')
            ];
        }

        // 按队列名称排序
        usort($queues, function($a, $b) {
            return strcmp($a['queue_name'], $b['queue_name']);
        });

        View::assign('queues',$queues);
        return View::fetch('addtaskapi/get_redis_queues');
    }

    /**
     * 清空指定Redis队列
     * @return Json
     */
    public function clearRedisQueue(): Json
    {
        // 获取队列名称参数
        $queueName = input('queue_name');

        // 参数验证
        if (empty($queueName)) {
            return json([
                'code' => CodeMsg('fail'),
                'msg' => 'queue_name is required'
            ]);
        }

        try {
            $redis = Cache::store('redis')->handler();

            // 检查队列是否存在
            if (!$redis->exists($queueName)) {
                return json([
                    'code' => CodeMsg('fail'),
                    'msg' => 'queue does not exist'
                ]);
            }

            // 清空队列
            $redis->del($queueName);

            return json([
                'code' => CodeMsg('success'),
                'msg' => 'queue cleared successfully'
            ]);
        } catch (\Exception $e) {
            return json([
                'code' => CodeMsg('fail'),
                'msg' => 'clear queue failed: ' . $e->getMessage()
            ]);
        }
    }
}
