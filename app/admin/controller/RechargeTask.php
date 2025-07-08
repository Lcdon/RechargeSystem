<?php

namespace app\admin\controller;

use app\admin\model\EquipmentModel;
use app\admin\model\EquipmentUserBindModel as EUB;
use app\admin\model\RechargeTaskModel as RT;
use think\admin\service\AdminService;
use think\facade\View;
use \PhpOffice\PhpSpreadsheet\IOFactory;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use think\admin\model\SystemUser;
use think\facade\Request;

/**
 * 充值任务
 * @class EquipmentUserBind
 * @package app\admin\controller
 */

class RechargeTask extends Base
{
    /**
     * 任务页面
     * @auth true
     * @menu true
     */
    public function index()
    {
        View::assign('title',lang('任务列表'));
        $user_list = SystemUser::field('id,username')->select()->toArray();
        View::assign('user_list',$user_list);
        $equipment_list = EquipmentModel::field('id,equipment_name')->select()->toArray();
        View::assign('equipment_list',$equipment_list);
        $state = [
            ['key'=>0,  'value'=>'Waitting'],
            ['key'=>1,  'value'=>'Running'],
            ['key'=>2,  'value'=>'Success'],
            ['key'=>-1, 'value'=>'Fail'],
            ['key'=>3, 'value'=>'Cancel'],
        ];
        View::assign('state',$state);
        return View::fetch();
    }

    /**
     * 任务列表
     * @auth true
     */
    public function List()
    {
        $data = $this->_vali([
            'page.require'=>'page is null',
            'limit.require'=>'limit is null',
            '_order_.default'=>'asc',
            'state.default'=>null
        ]);
        $page = $data['page'];
        $limit = $data['limit'];
        $offset = ($page - 1) * $limit;

        if(session('user')['username']=='admin'){
            $equal = 'system_user_id,equipment_id';
            if(!empty($data['state']) or $data['state']=='0'){
                $equal .= ',state';
            }
            if(!empty($_POST['recharge_tel'])){
                $equal .= ',recharge_tel';
            }
            $query = RT::mQuery()
                ->equal($equal)
                ->dateBetween('create_time,begin_time,recharge_time')
                ->order('id '.$data['_order_'])
                ->limit($offset,$limit);
            $binds = $query->select()->toArray();
            $count = $query->count();
        }else{
            $equal = '';
            if(!empty($data['state']) or $data['state']=='0'){
                $equal .= ',state';
            }
            if(!isset($_POST['recharge_tel']) or !empty($_POST['recharge_tel'])){
                $equal .= ',recharge_tel';
            }
            $equal = ltrim($equal, ',');
            $query = RT::mQuery()
                ->where('system_user_id',session('user')['id'])
                ->equal($equal)
                ->dateBetween('create_time,begin_time,recharge_time')
                ->order('id '.$data['_order_'])
                ->limit($offset,$limit);
            $binds = $query->select()->toArray();
            $count = $query->count();
        }
        $response['code']   = 0;
        $response['count']  = $count;
        $response['data']   = $binds;
        return json($response);
    }

    /**
     * 添加任务
     * @auth true
     */
    public function add()
    {   
        $user_id = session('user')['id'];
        if(request()->isPost()){

            $data = $this->_vali([
                'recharge_tel.require'=>'recharge_tel is null',
                'amount.require'=>'amount is null',
                ]);

            if($data['amount']<5 or $data['amount']>200){
                $response['code'] = CodeMsg('fail');
                $response['msg'] = 'recharge amount needs to be between 5 and 200';
                return json($response);
            }
            if(isset($_POST['equipment_id'])){
                $equipment_id = $_POST['equipment_id'];
                $data['equipment_id'] = $equipment_id;
            }
            if($user_id!=10000) {
                $equipment_id = $this->getUserEquipmentid($user_id);
                if (!empty($equipment_id)) $data['equipment_id'] = $equipment_id;
            }
            if(!empty($data['equipment_id'])){
                $data['equipment_name'] = EquipmentModel::where(['id'=>$data['equipment_id']])->find()->equipment_name;
            }
            $data['system_user_id'] = session('user')['id'];
            $data['username'] = session('user')['username'];
            $data['state'] = 0;
            $data['state_msg'] = '待分配';
            $add = new RT;
            $add->save($data);
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
            return json($response);
        }else{
            if($user_id==10000){
                $equipments = EquipmentModel::field('id,equipment_name')
                ->select()->toArray();
                View::assign('equipments',$equipments);
            }else{
                $equipments = EquipmentModel::hasWhere('equipment_user_bind',['system_user_id'=>$user_id])
                ->field('EquipmentModel.id,equipment_name')
                ->find();
                if(!$equipments){
                    $equipments = [];
                    $equipments['equipment_name'] = '未绑定设备';
                }else{
                    $equipments = $equipments->toArray();
                }
                View::assign('equipments',$equipments);
            }
            View::assign('user_id',$user_id);
            return View::fetch('form');
        }
    }



    /**
     * 修改任务
     * @auth true
     */
    public function edit()
    {   
        $user_id = session('user')['id'];
        if(request()->isPost()){
            $data = $this->_vali([
                'id.require'=>'id is null',
                'recharge_tel.require'=>'recharge_tel is null',
                'amount.require'=>'amount is null',
            ]);
            
            if($user_id == 10000){ //管理员
                if($data['amount']<5 or $data['amount']>200){
                    $response['code'] = CodeMsg('fail');
                    $response['msg'] = 'recharge amount needs to be between 5 and 200';
                    return json($response);
                }
                $save = [
                    'recharge_tel'=>$data['recharge_tel'],
                    'amount' => $data['amount'],
                ];
                if(!empty($_POST['equipment_id'])){
                    $save['equipment_id'] = $_POST['equipment_id'];
                }else{
                    $save['equipment_id'] = NULL;
                }
            }else{ //普通用户
                $save = [
                    'recharge_tel'=>$data['recharge_tel'],
                    'amount' => $data['amount'],
                ];
            }
            RT::where('id',$data['id'])->save($save);
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
            return  json($response);
        }else{
            $data = $this->_vali(['id.require'=>'id is null']);
            $task = RT::where('id',$data['id'])
                ->find();
            $result = $task->toArray();
            if($result['equipment_id']){
                $result['equipment_name'] = EquipmentModel::where('id',$result['equipment_id'])->find()->equipment_name;
            }
            
            if($user_id == 10000){ //管理员
                $equipments = EquipmentModel::field('id,equipment_name')->select()->toArray();
            }else{
                $equipments['equipment_name'] = $result['equipment_name'];
            }
            
            View::assign('equipments',$equipments);
            View::assign('vo',$result);
            View::assign('id',$result['id']);
            View::assign('user_id',$user_id);
            return View::fetch('form');
        }
    }

    public function getUserEquipmentid($user_id){
        $bind = EUB::where(['system_user_id'=>$user_id])->find();
        if($bind)
            $equipment_id = $bind->equipment_id;
        else
            $equipment_id = NULL;
        return $equipment_id;
    }

    /**
     * 删除任务
     * @auth true
     */
    public function remove()
    {
        $this->_vali(['id.require'=>'id is null']);
        RT::mDelete();
    }

    /**
     * 取消任务
     * @auth true
     */
    public function cancel()
    {
        $data = $this->_vali(['id.require'=>'id is null']);
        $res = RT::where('id',$data['id'])->save(['state'=>3,'state_msg'=>'取消']);
        if($res){
            $response['code'] = CodeMsg('success');
            $response['msg'] = 'success';
        }else{
            $response['code'] = CodeMsg('fail');
            $response['msg'] = 'fail';
        }
        return json($response);

    }

    public function import()
    {   
        $user_id = session('user')['id'];
        $file = $_FILES['file']['tmp_name'];
        //表格字段对应
        $cellName = [
            'A' => 'equipment_name',//设备名称
            'B' => 'recharge_tel',//充值电话
            'C' => 'amount'//充值金额
        ];
        //加载文件
        $spreadsheet = IOFactory::load($file);
        $sheet = $spreadsheet->getActiveSheet();               // 获取表格
        $highestRow = $sheet->getHighestRow();                 // 取得总行数
        $sheetData = [];
        for ($row = 2; $row <= $highestRow; $row++) {          // $row表示从第几行开始读取
            foreach ($cellName as $cell => $field) {
                $value = $sheet->getCell($cell . $row)->getValue();
                if($value!='')
                    $value = trim($value);
                $sheetData[$row][$field] = $value;
            }
        }
        $sheetData = array_values($sheetData);

        //数据检测
        $Err = '';
        foreach ($sheetData as $key=>$value){
            if(empty($value['recharge_tel'])){
                $Err.='row:'.($key+1).',recharge_tel is null<br>';
                unset($sheetData[$key]);
            }
            if(empty($value['amount'])){
                $Err.='row:'.($key+1).',amount is null<br>';
                unset($sheetData[$key]);
            }
        }

        $list = [];
        foreach ($sheetData as $key=>$value){
            if($user_id!=10000){
                $equipment = $this->getUserEquipmentid($user_id);
            }else{
                $equipment = EquipmentModel::where('equipment_name',$value['equipment_name'])->find();
            }
            
            if($value['amount']<5 or $value['amount']>20){
                $Err.='row:'.($key+1).','.$value['equipment_name'].':amount is no between 5 and 20<br>';
                continue;
            }

            if(empty($equipment)){
                $data = [
                    'recharge_tel'=>$value['recharge_tel'],
                    'amount'=>$value['amount'],
                    'system_user_id'=>session('user')['id'],
                    'username' =>session('user')['username'],
                    'state_msg' => '待分配'
                ];
            }else{
                $data = [
                    'equipment_id'=>$equipment->id,
                    'equipment_name'=>$equipment->equipment_name,
                    'recharge_tel'=>$value['recharge_tel'],
                    'amount'=>$value['amount'],
                    'system_user_id'=>session('user')['id'],
                    'username' =>session('user')['username'],
                    'state_msg' => '待分配'
                ];
            }
            $list[] = $data;
        }
        if(!empty($list)){
            $newModel = new RT();
            $newModel->saveAll($list);
        }
        $response['code'] = CodeMsg('success');
        $response['msg'] = 'add:'.count($list);
        if(!empty($Err))$response['msg'] .= "<br>".$Err;
        return json($response);
    }

    /** 生成excel
     * @return void
     */
    public function downExcel()
    {
        // 获取数据
        if(session('user')['username']=='admin'){
            $query = RT::mQuery()
                ->equal('system_user_id,equipment_id')
                ->dateBetween('create_time,begin_time,recharge_time')
                ->order('id desc');
            $binds = $query->select()->toArray();
        }else{
            $query = RT::mQuery()
                ->where('system_user_id',session('user')['id'])
                ->dateBetween('create_time,begin_time,recharge_time')
                ->order('id desc');
            $binds = $query->select()->toArray();
        }
        // 创建一个新的 Spreadsheet 对象
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        // 设置表格头部
        $sheet->setCellValue('A1', 'Creator');
        $sheet->setCellValue('B1', 'State');
        $sheet->setCellValue('C1', 'Create Time');
        $sheet->setCellValue('D1', 'Equipment Name');
        $sheet->setCellValue('E1', 'Recharge Tel');
        $sheet->setCellValue('F1', 'Amount');
        $sheet->setCellValue('G1', 'Begin Time');
        $sheet->setCellValue('H1', 'Recharge Time');
        $sheet->setCellValue('I1', 'Recharge Result');
        $sheet->setCellValue('J1', 'Transaction ID');
        $sheet->setCellValue('K1', 'Balance');

        $sheet->getColumnDimension('A')->setWidth(20);
        $sheet->getColumnDimension('B')->setWidth(20);
        $sheet->getColumnDimension('C')->setWidth(20);
        $sheet->getColumnDimension('D')->setWidth(20);
        $sheet->getColumnDimension('E')->setWidth(20);
        $sheet->getColumnDimension('F')->setWidth(20);
        $sheet->getColumnDimension('G')->setWidth(20);
        $sheet->getColumnDimension('H')->setWidth(20);
        $sheet->getColumnDimension('I')->setWidth(20);
        $sheet->getColumnDimension('J')->setWidth(20);
        $sheet->getColumnDimension('K')->setWidth(20);
        $sheet->getStyle('A1:K1')->getFont()->setBold(true);

        // 设置表格内容
        $row = 2; // 从第二行开始写入数据
        foreach ($binds as $item) {
            $sheet->setCellValue('A' . $row, $item['username']);
            $sheet->setCellValue('B' . $row, $item['state']);
            $sheet->setCellValue('C' . $row, $item['create_time']);
            $sheet->setCellValue('D' . $row, $item['equipment_name']);
            $sheet->setCellValue('E' . $row, $item['recharge_tel']);
            $sheet->setCellValue('F' . $row, $item['amount']);
            $sheet->setCellValue('G' . $row, $item['begin_time']);
            $sheet->setCellValue('H' . $row, $item['recharge_time']);
            $sheet->setCellValue('I' . $row, $item['recharge_result']);
            $sheet->setCellValue('J' . $row, $item['transaction_id']);
            $sheet->setCellValue('K' . $row, $item['balance']);
            $row++;
        }

        // 设置响应头部
        $xlsx = date('YmdHis').'.xlsx';
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$xlsx.'"');
        header('Cache-Control: max-age=0');

        // 创建 Excel 文件
        $writer = new Xlsx($spreadsheet);

        // 保存到输出流
        $writer->save('php://output');
        exit;
    }

    /**
     * 更新system_user表的daily_limit_remain
     */
    public function user_daily_limit_update()
    {
        $result = SystemUser::execute("UPDATE system_user set daily_limit_remain=daily_limit;");
        if($result){
            echo 'success';
        }else{
            echo 'error';
        }
    }

}