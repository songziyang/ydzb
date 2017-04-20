package com.ydzb.product.service.impl;

import com.ydzb.core.service.impl.BaseServiceImpl;
import com.ydzb.core.utils.DateUtil;
import com.ydzb.core.utils.ExcelUtil;
import com.ydzb.core.utils.POIUtil;
import com.ydzb.product.entity.PrivilegeTradeRecored;
import com.ydzb.product.repository.IPrivilegeTradeRecoredRepository;
import com.ydzb.product.repository.PrivilegeTradeRecordRepository;
import com.ydzb.product.service.IPrivilegeTradeRecoredService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class PrivilegeTradeRecoredServiceImpl extends BaseServiceImpl<PrivilegeTradeRecored, Long> implements IPrivilegeTradeRecoredService {

    @Autowired
    private IPrivilegeTradeRecoredRepository privilegeTradeRecoredRepository;
    @Autowired
    private PrivilegeTradeRecordRepository cprivilegeTradeRecordRepository;

    @Override
    public String exportExcel(List<Object[]> tradeRecords, String address) {
        String fileName = "";
        try {
            String[] names = {"用户名", "手机号", "交易名称", "交易类型", "资金类型", "交易金额", "交易时间"};
            String[] keys = {"username", "mobile", "tradeName", "tradeType", "fundType", "tradeFund", "tradeTime"};
            List<Map<String, Object>> headInfoList = ExcelUtil.setHeadInfo(names, keys);
            List<Map<String, Object>> dataList = setData(keys, tradeRecords);
            fileName = "/privilegeTradeRecored" + DateUtil.getSystemTimeSeconds() + ".xls";
            String filePath = address + fileName;
            POIUtil.exportExcel2FilePath("新手宝交易", filePath, headInfoList, dataList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }

    /**
     * 设置数据
     * @param keys
     * @param tradeRecords
     * @return
     */
    private List<Map<String, Object>> setData(String[] keys, List<Object[]> tradeRecords) {
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> dataItem = null;
        for (Object[] row: tradeRecords) {
            if (row == null) {
                continue;
            }
            dataItem = new HashMap<String, Object>();
            dataItem.put(keys[0], row[0] == null? "": row[0]);
            dataItem.put(keys[1], row[1] == null? "": row[1]);
            dataItem.put(keys[2], row[2] == null ? "" : row[2]);
            dataItem.put(keys[3], getRecordType((Integer)row[3]));
            dataItem.put(keys[4], getFundType((Integer) row[4]));
            dataItem.put(keys[5], row[5] == null? "": row[5]);
            dataItem.put(keys[6], row[6] == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm").format(DateUtil.getSystemTimeMillisecond(((Integer)row[6]).longValue())));
            dataList.add(dataItem);
        }
        return dataList;
    }

    /**
     * 获得交易类型
     * @param type
     * @return
     */
    private String getRecordType(Integer type) {
        switch (type) {
            case 1: return "购买";
            case 2: return "赎回";
        }
        return "";
    }

    /**
     * 获得资金类型
     * @param fundType
     * @return
     */
    private String getFundType(Integer fundType) {
        switch (fundType) {
            case 0: return "资金余额";
            case 1: return "收益";
            case 2: return "到期本息";
        }
        return "";
    }

    @Override
    public List<Object[]> findExportData(Map<String, Object> filter) {
        return cprivilegeTradeRecordRepository.findExportData(filter);
    }

    public IPrivilegeTradeRecoredRepository getPrivilegeTradeRecoredRepository() {
        return privilegeTradeRecoredRepository;
    }

    public void setPrivilegeTradeRecoredRepository(IPrivilegeTradeRecoredRepository privilegeTradeRecoredRepository) {
        this.privilegeTradeRecoredRepository = privilegeTradeRecoredRepository;
    }
}