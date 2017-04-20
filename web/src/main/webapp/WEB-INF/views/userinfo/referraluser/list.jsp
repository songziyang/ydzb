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
<link href="${ctx}/static/lib/simpletooltip/src/css/simpletooltip.min.css" rel="stylesheet"/>
<script src="${ctx}/static/lib/simpletooltip/src/js/simpletooltip.js" ></script>
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
			<li><i class="fa fa-home"></i> <a href="#">业务员管理</a></li>
			<li><a href="#">推荐用户信息信息</a></li>
		</ul>
	</div>
	<!-- /Page Breadcrumb -->
	<!-- Page Header -->
	<div class="page-header position-relative">
		<div class="header-title">
			<h1>推荐用户列表</h1>
		</div>
		<!--Header Buttons-->
		<div class="header-buttons">
			<a class="sidebar-toggler" href="#"> <i class="fa fa-arrows-h"></i></a>
			<a class="refresh" id="refresh-toggler"
				href="${ctx}/userinfo/referralUser/list?referralMobile=${referralMobile}"><i
				class="glyphicon glyphicon-refresh"></i></a> <a class="fullscreen"
				id="fullscreen-toggler" href="#"> <i
				class="glyphicon glyphicon-fullscreen"></i></a>
		</div>
		<!--Header Buttons End-->
	</div>
	<!-- /Page Header -->
	<!-- Page Body -->
	<form action="${ctx}/userinfo/referralUser/list?referralMobile=${referralMobile}" method="post"
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
										<a href="#"></a> <a href="#" data-toggle="collapse"> <i
											class="fa fa-plus blue"></i>
										</a>
									</div>
								</div>
								<div class="widget-body">
									<div class="form-inline" role="form">
										<div class="form-group">
											<label class="control-label no-padding-right">用户名</label> <input
												type="text" name="username" class="form-control"
												placeholder="用户名" />
										</div>
										<div class="form-group">
											<label class="control-label no-padding-right">手机号</label> <input
												type="text" name="mobile" class="form-control"
												placeholder="手机号" />
										</div>
										<div class="form-group">
											<a href="javascript:searchData();"
												class="btn btn-labeled btn-blue"> <i
												class="btn-label fa fa-search"></i>查询
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="widget">
						<div class="widget-header  with-footer">
							<span class="widget-caption">推荐用户列表</span>
							<div class="widget-buttons">
								<a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i></a>
								<a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i></a>
							</div>
						</div>
						<div class="widget-body">
							<div class="flip-scroll">
								<div style="text-align: right; margin-bottom: 10px;">
								</div>
								<table class="table table-hover table-striped table-bordered">
									<thead style="font-size: 16px; font-weight: bold;">
										<tr>
											<th width="80" style="text-align: center;">序号</th>
											<th>用户名</th>
											<th>手机号</th>
											<th>投资总额</th>
											<th>账户余额</th>
											<th>账户总额</th>
											<th width="200px" style="text-align: center;">操作</th>
										</tr>
									</thead>
									<tbody style="font-size: 12px;">
										<c:forEach items="${page.content}" var="userMoney"
											varStatus="status">
											<c:set var="user" value="${userMoney.user}"/>
											<tr>
												<td class="table_no" width="80" align="center"></td>
												<td>
													<c:choose>
														<c:when test="${user.userLeve.gradeNum eq 1}"><img src="${ctx}/static/lib/images/vip1.png" /></c:when>
														<c:when test="${user.userLeve.gradeNum eq 2}"><img src="${ctx}/static/lib/images/vip2.png" /></c:when>
													</c:choose>
													<a href="${ctx}/userinfo/user/listUserInfo/<c:out value='${user.id}'/>"
													   data-simpletooltip="init" title='<c:out value="${user.remark}" />'
													   <c:if test="${not empty user.remark}">style='color: red;'</c:if>>
														<c:out value="${user.username}" />
													</a>
												</td>
												<td>
													<a href="${ctx}/userinfo/user/listUserInfo/<c:out value='${user.id}'/>"
													   data-simpletooltip="init" title='<c:out value="${user.remark}" />'
													   <c:if test="${not empty user.remark}">style='color: red;'</c:if>>
														<c:out value="${user.mobile}" />
													</a>
												</td>
												<td><c:out value="${userMoney.totalInvest}" /></td>
												<td><c:out value="${userMoney.usableFund}" /></td>
												<td><c:out value="${userMoney.totalFund}" /></td>
												<td width="200px" align="center">
													<shiro:hasPermission name="businessuser_operatelist">
														<a href='${ctx}/userinfo/referralUser/findoperation/${user.id}'
															class="btn btn-info btn-xs edit">
															<i class="fa fa-edit"></i>资金记录
														</a>&nbsp;&nbsp;
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
