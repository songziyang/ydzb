<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@include file="/static/inc/main.inc"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh">
<head>
<title>银多资本</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
.form-inline .form-group {
	margin-bottom: 10;
}
</style>
</head>
<body>

	<!-- Page Breadcrumb -->
	<div class="page-breadcrumbs">
		<ul class="breadcrumb" style="line-height: 40px;">
			<li><i class="fa fa-home"></i> <a href="#">产品管理</a></li>
			<li><a href="#">基金产品管理</a></li>
		</ul>
	</div>
	<!-- /Page Breadcrumb -->
	<!-- Page Header -->
	<div class="page-header position-relative">
		<div class="header-title">
			<h1>基金产品列表</h1>
		</div>
		<!--Header Buttons-->
		<div class="header-buttons">
			<a class="sidebar-toggler" href="#"> <i class="fa fa-arrows-h"></i>
			</a> <a class="refresh" id="refresh-toggler" href="${ctx}/product/stable/listStable"> <i
				class="glyphicon glyphicon-refresh"></i>
			</a> <a class="fullscreen" id="fullscreen-toggler" href="#"> <i
				class="glyphicon glyphicon-fullscreen"></i>
			</a>
		</div>
		<!--Header Buttons End-->
	</div>
	<!-- /Page Header -->
	<!-- Page Body -->
	<form action="${ctx}/product/stable/listStable" method="post"
		id="listForm" name="listForm">
		<div class="page-body">
			<div class="row">
				<div class="col-xs-12 col-md-12">
					<div class="row">
						<div class="col-lg-12 col-sm-12 col-xs-12">
							<div class="widget collapsed">
								<div class="widget-header bordered-bottom bordered-sky">
									<i class="widget-icon fa fa-arrows-v blue"></i> <span
										class="widget-caption">查询条件</span>
									<div class="widget-buttons">
										<a href="#"> </a> <a href="#" data-toggle="collapse"> <i
											class="fa fa-plus blue"></i>
										</a>
									</div>
									<!--Widget Buttons-->
								</div>
								<!--Widget Header-->
								<div class="widget-body">
									<div class="form-inline" role="form">
										<div class="form-group">
											<label class="control-label no-padding-right">基金产品名称</label> <input
												type="text" name="name" class="form-control"
												placeholder="基金产品名称">
										</div>
										<div class="form-group">
											<a href="javascript:searchData();"
												class="btn btn-labeled btn-blue"> <i
												class="btn-label fa fa-search"></i>查询
											</a>
										</div>
									</div>
								</div>
								<!--Widget Body-->
							</div>
							<!--Widget-->
						</div>
					</div>
					<div class="widget">
						<div class="widget-header  with-footer">
							<span class="widget-caption">基金产品列表</span>
							<div class="widget-buttons">
								<a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i>
								</a> <a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i>
								</a>
							</div>
						</div>
						<div class="widget-body">
							<div class="flip-scroll">
							
								<div style="text-align: right;margin-bottom: 10px;">
								<shiro:hasPermission name="stable_create">
									<a class="btn btn-labeled btn-success" href="${ctx}/product/stable/createStable" ><i class="btn-label glyphicon glyphicon-plus"></i>添加</a>							
								</shiro:hasPermission>
								<shiro:hasPermission name="stable_del">
									<a class="btn btn-labeled btn-danger"  href="javascript:removeData('${ctx}/product/stable/deleteStables');"><i class="btn-label glyphicon glyphicon-trash"></i>删除</a>
								</shiro:hasPermission>
								</div>
								</div>
								
								<table class="table table-hover table-striped table-bordered">
									<thead style="font-size: 16px; font-weight: bold;">
										<tr>
											<th width="80" style="text-align: center;">序号</th>
											<th>产品名称</th>
											<th>产品类型</th>
											<th>期数</th>
											<th>开放份数</th>
											<th>剩余份数</th>
											<th>最大份数</th>
											<th>最小份数</th>
											<th>申购开始日期</th>
											<th>申购结束日期</th>
											<th>满标日期</th>
											<th>到期日期</th>
											<th>锁定期</th>
											<th>利率百分比</th>
											<th>申购状态</th>
											<th width="20">
												<label> 
												<input type="checkbox">
												<span class="text"></span>
												</label>
											</th>
											<th width="200px" style="text-align: center;">操作</th>
										</tr>
									</thead>
									<tbody style="font-size: 12px;">
										<c:forEach items="${page.content}" var="stable" varStatus="status">
											<tr>
												<td class="table_no" width="80" align="center"></td>
												<td><c:out value="${stable.name}" /></td>
												<td>
													<c:choose>
														<c:when test="${stable.type eq 1}">稳进宝</c:when>
														<c:when test="${stable.type eq 2}">震震涨</c:when>
														<c:when test="${stable.type eq 3}">荡荡跌</c:when>
													</c:choose>
												</td>
												<td><c:out value="${stable.issue}" /></td>
												<td><c:out value="${stable.copies}" /></td>
												<td><c:out value="${stable.remainingCopies}" /></td>
												<td><c:out value="${stable.maxCopies}" /></td>
												<td><c:out value="${stable.minCopies}" /></td>
												<td><fmt:formatDate value="${stable.startDate}"  pattern="yyyy年MM月dd日 " /></td>
												<td><fmt:formatDate value="${stable.endDate}"  pattern="yyyy年MM月dd日 " /></td>
												<td><fmt:formatDate value="${stable.fullDate}"  pattern="yyyy年MM月dd日 " /></td>
												<td><fmt:formatDate value="${stable.closeDate}"  pattern="yyyy年MM月dd日 " /></td>
												<td><c:out value="${stable.days}"/></td>
												<td><c:out value="${stable.apr}" /></td>
												<td>
													<c:choose>
														<c:when test="${stable.state eq 1}"><c:out value="申购中" /></c:when>
														<c:when test="${stable.state eq 2}"><c:out value="已满标" /></c:when>
														<c:otherwise><c:out value="已结束" /></c:otherwise>
													</c:choose>
												</td>
												<td width="20">
													<label> 
													<input type="checkbox" name="ids" value='<c:out value="${stable.id}" />'> 
													<span class="text"></span>
													</label>
												</td>
												<td width="200px" align="center"><shiro:hasPermission
														name="stable_edit">
														<a
															href='${ctx}/product/stable/editStable/<c:out value="${stable.id}" />'
															class="btn btn-info btn-xs edit"><i
															class="fa fa-edit"></i>编辑</a>
                                                    			&nbsp;&nbsp;
                                                    </shiro:hasPermission> 
                                                    <!--  
                                                    <shiro:hasPermission name="stable_del">
														<a class="btn btn-danger btn-xs delete" onclick="removeData('${ctx}/product/stable/deleteStable/','<c:out value="${stable.id}" />')">
															<i class="fa fa-trash-o"></i> 删除</a>
                                               		</shiro:hasPermission>
                                               		-->
                                               		<shiro:hasPermission name="stable_list">
														<a class="btn btn-info btn-xs edit" href='${ctx}/product/stabledeal/listStableDeal?stableId=<c:out value="${stable.id}" />'>
															<i class="fa fa-edit"></i> 交易</a>
                                               		</shiro:hasPermission>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<tags:pagination page="${page}"></tags:pagination>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<%@include file="/static/inc/footer.inc"%>
</body>
</html>