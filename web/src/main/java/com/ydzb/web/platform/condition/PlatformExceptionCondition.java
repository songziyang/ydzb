package com.ydzb.web.platform.condition;

import com.google.common.collect.Lists;
import com.google.gson.annotations.Expose;
import com.ydzb.core.entity.search.SearchOperator;
import com.ydzb.core.entity.search.filter.SearchFilter;
import com.ydzb.core.entity.search.filter.SearchFilterHelper;
import com.ydzb.core.utils.DateUtil;

import java.util.List;

/**
 * 平台统计查询设置
 */
public class PlatformExceptionCondition {

    private List<SearchFilter> filters = Lists.newArrayList();

    @Expose
    private String totalStartTime;    //统计开始时间

    @Expose
    private String totalEndTime;    //统计结束时间

    public List<SearchFilter> getAndFilters() {

        if (totalStartTime != null && !"".equals(totalStartTime)) {
            filters.add(SearchFilterHelper.newCondition("created", SearchOperator.gte, DateUtil.getSystemTimeDay(totalStartTime)));
        }

        if (totalEndTime != null && !"".equals(totalEndTime)) {
            filters.add(SearchFilterHelper.newCondition("created", SearchOperator.lt, DateUtil.getSystemTimeDay(DateUtil.addDay(totalEndTime))));
        }

        return filters;
    }


    public String getTotalStartTime() {
        return totalStartTime;
    }

    public void setTotalStartTime(String totalStartTime) {
        this.totalStartTime = totalStartTime;
    }

    public String getTotalEndTime() {
        return totalEndTime;
    }

    public void setTotalEndTime(String totalEndTime) {
        this.totalEndTime = totalEndTime;
    }
}