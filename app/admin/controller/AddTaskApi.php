<?php

namespace app\admin\controller;

use think\admin\Controller;
use app\admin\model\EquipmentUserBindModel as EUB;
use app\admin\model\EquipmentModel;
use app\admin\model\RechargeTaskModel as RT;
use app\admin\model\RechargeTaskTelModel as RTT;
use think\admin\model\SystemUser;

class AddTaskApi extends Controller
{
        # 添加任务API
    public function addTaskApi()
    {
        $data = $this->_vali([
            'msisdn.require'=>'msisdn is null',
            'er_amount.require'=>'er_amount is null',
            'username.require'=>'username is null',
            'password.require'=>'password is null',
            'task_type.require'=>'task_type is null',
        ]);
        if($data['task_type']!='app' and $data['task_type']!='call'){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'task_type is incorrect';
            return json($response);
        }

        $map = ['username' => $data['username'], 'is_deleted' => 0];
        $user = SystemUser::mk()->where($map)->findOrEmpty();
        if($user->isEmpty()){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'username is not exist';
            return json($response);
        }
        $user_id = $user->id;

        if(md5($data['password'])!=$user->password){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'password is incorrect';
            return json($response);
        }
        if(!EUB::where('system_user_id',$user_id)->find()){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'user is not bind equipment';
            return json($response);
        }
        $equipment_id = EUB::where('system_user_id',$user_id)->find()->equipment_id;
    
        if($data['er_amount']<5 or $data['er_amount']>200){
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'recharge er_amount needs to be between 5 and 200';
            return json($response);
        }
        
        $data['equipment_name'] = EquipmentModel::where(['id'=>$equipment_id])->find()->equipment_name;
        $data['system_user_id'] = $user_id;
        $data['username'] = $data['username'];
        $data['state'] = 0;
        $data['state_msg'] = '待分配';

        $data['recharge_tel'] = $data['msisdn'];
        $data['amount'] = $data['er_amount'];
        unset($data['msisdn']);
        unset($data['er_amount']);

        if($data['task_type']=='app'){
            $add = new RT;
            $add->save($data);
        }else{
            $add = new RTT;
            $add->save($data);
        }
        $response['code'] = CodeMsg('success');
        $response['msg'] = 'success';
        return json($response);
    }
}
