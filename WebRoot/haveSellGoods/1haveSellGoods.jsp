<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="owner" content="" />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />
<title>卖出宝贝订单</title>

<%@ include file="/common/top-head.jspf" %>
<script type="text/javascript" src="${ctx}/js/web.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/order/havegoods.css">
<script type="text/javascript" src="${ctx}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/haveSellGoods/haveSellGoods.js"></script>
</head>

<body>
<div align="center" style="margin-top:-40px;">
<%@ include file="/common/top-nav.jspf" %>
</div>
<div id="templatemo_main">
	<center>
		<form name="userform" action="" id="userform">
		<input type="hidden" id="authorizedToken" name="authorizedToken" value="${userid}"/>
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}" />
			 <input type="hidden" name="page.pageSize" id="pageSize" value="${page.pageSize}" />
			<input type="hidden" name="orderid" id="orderid" value="${param.orderid}"/>	
			<input type="hidden" name="redirectUrl" id="redirectUrl" value="${param.redirectUrl}"/>	
			<input type="hidden" name="ordersonId" id="ordersonId" value="${param.ordersonId}"/>		
			&nbsp; &nbsp;&nbsp;<h3>卖出宝贝订单</h3>
			<div id="msg_operatingResult">
				<font color="red" size="5" id="font1"><B>${msg_operatingResult}</B>
				</font>
			</div>
			<s:if test="#request.page.totalItems<=0"><span style="color:red;font-size:18px">无订单信息!</span></s:if>
			<s:iterator value="#request.page" var="orders">
				<table style="border:1px solid;width:900px;word-wrap:break-word;word-break:break-all"
					class="grid-bundle grid-TmallSeller">
					<thead>
						<tr>
							<th align="center" width=10%>订单号:${orderid}</th>
							<th align="center" width=20%>购买人:${user.username}</th>
							<th align="center" width=10%>单价（元）</th>
							<th align="center" width=10%>数量（件）</th>
							<th align="center" width=10%>小计（元）</th>
							<th align="center" width=20%>订单状态</th>
							<th align="center" width=20%>操作</th>
						</tr>
						<tr class="row-border">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody border="1">
						<tr>
							<td colspan="5" class="tube-main">
								<table>
									<tbody>
										<s:iterator value="#orders.sons" var="son">
											<tr id="item_" class="gird-order">
												<td class="tube-img">
												<a href="javascript:opendetial('${goods.goodsid}','${goods.shop.shopId}');">
												<image  height="80px" width="80px"
														src="${ctx}${goods.goodsPicture.url}" />
												</a>
												</td>
												<td class="tube-master">
												<a href="javascript:opendetial('${goods.goodsid}','${goods.shop.shopId}');">
												${goodsName}
												 <br/>
												${son.property}
												</td>
												<td class="tube-price">${price}</td>
												<td class="tube-amount">${amount}</td>
												<td class="tube-sum">
												<fmt:formatNumber pattern=".00"  minIntegerDigits="1"
														value="${price * amount}"></fmt:formatNumber>
												</td>
											</tr>
										</s:iterator>
									</tbody>
								</table>
							</td>
							<td class="tube-main" rowspan="#orders.sons.size()"
								align="center">
								<s:if test="%{state==\"0\"}">等待买家付款</s:if> 
								<s:if test="%{state==\"1\"}">交易关闭</s:if> 
								<s:if test="%{state==\"2\"}">买家已付款</s:if>
								<s:if test="%{state==\"3\"}">卖家已发货</s:if>
								<s:if test="%{state==\"31\"}">等待卖家审核<br/>延长收货时间申请</s:if> 
								<s:if test="%{state==\"32\"}">等待买家修改<br/>延长收货时间申请</s:if> 
								<s:if test="%{state==\"33\"}">卖家已发货</s:if> 
								<s:if test="%{state==\"4\"}">买家已收货<br/>交易成功</s:if>
								<s:if test="%{state==\"5\"}">买家已退货<br/>交易关闭</s:if> 
								<s:if test="%{state==\"51\"}">等待卖家审<br/>核退货申请</s:if> 
								<s:if test="%{state==\"52\"}">等待买家修<br/>改退货申请</s:if> 
								<s:if test="%{state==\"53\"}">等待买家填<br/>写物流运单</s:if> 
								<s:if test="%{state==\"54\"}">等待卖家收货</s:if> 
							</td>
							<td class="tube-main" rowspan="#orders.sons.size()" align="center">
								<s:if test="%{state==\"0\"}">
									<button id="btn_altermoney${orderid}" type="button" style="width:120px;"
									onclick="altermoney('${orderid}');">修改订单价格</button>
									<button id="btn_savealtermoney${orderid}" type="button" style="width:80px;display:none;"
									onclick="savealtermoney('${orderid}');">保存</button>
								</s:if>
								
								<s:if test="%{state==\"1\"}">
									<a href="javascript:deleteordersell('${orderid}');">删除订单</a>
								</s:if>	
								
								<s:if test="%{state==\"2\"}">
									<img height="35px" src="${ctx}/image/buysellgoods/confirmdelivery.png"
										onclick="confirmdelivery('${orderid}','${userid}');"/>							
								</s:if>				
																
								<s:if test="(state==\"3\")||(state==\"31\")||(state==\"32\")|| (state==\"33\")">
									<a href="javascript:sellprolong('${orderid}','${userid}');">延长买家收货时间</a>
								</s:if>	
										
								<s:if test="%{state==\"4\"}">		
									<s:iterator value="#orders.sons" var="son" status="s">
										<s:if test="%{sonstate==\"40\"}">
											<div style="padding-top:44px;padding-bottom:44px;">								
											</div>	
										</s:if>					
										<s:if test="%{sonstate==\"41\"}">
											<div style="padding-top:36px;padding-bottom:36px;">		
											<a href="javascript:replybuyevaluation();">回复评价</a>
											</div>	
										</s:if> 
										<s:if test="(sonstate==\"42\")|| (sonstate==\"43\")">
											<div style="padding-top:36px;padding-bottom:36px;">		
											<a  href="javascript:viewevaluation('${ordersonId}');">查看评价</a>
											</div>
										</s:if>		
									</s:iterator>
								</s:if>		
								
								<s:if test="(state==\"5\")|| (state==\"52\")|| (state==\"53\")">
									<a href="javascript:viewreturn('${orderid}','${userid}','${userid}');">查看退货申请</a>
									<s:if test="%{state==\"5\"}">		
									 <br/>													
									<a href="javascript:deleteordersell('${orderid}');">删除订单</a>
									</s:if> 
								</s:if>								
								<s:if test="%{state==\"51\"}">
									<a href="javascript:checkreturn('${orderid}','${userid}');">审核退货申请</a>
								</s:if>								
								<s:if test="%{state==\"54\"}">
									<a href="javascript:confirmreturn('${orderid}','${userid}');">确认收到退货</a>
								</s:if>													
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
						<td colspan="2" align="left">
								<div class="orderPay" id="orderDate_id">
									订单日期:<strong> ${fn:substring(buytime,0,10)}</strong>
								</div>
							</td>
							<td colspan="3" align="center">
								<div class="orderPay">
									运费:
									<strong><span>¥<fmt:formatNumber pattern=".00" minIntegerDigits="1" value="${freight}"></fmt:formatNumber></span></strong>
								</div>
								
							</td>
							<td colspan="2" align="left" >
								<div class="orderPay" id="orderPay_id${orderid}" style="margin-left:60px">
										店铺合计<span class="isIncPostage">(含运费)</span>: <span
											class="tc-rmb">¥</span><strong><span id="show_ftotal${orderid}">
											<fmt:formatNumber pattern=".00" minIntegerDigits="1" value="${ftotal}"></fmt:formatNumber>
											</span></strong>
								</div>
								 <div class="orderPay" id="alterOrderPay_id${orderid}"  style="margin-left:70px;display:none">
										店铺合计<span class="isIncPostage">(含运费)</span>: <span
											class="tc-rmb">¥</span>
										<input type="text"
										name="alterftotal${orderid}" id="alterftotal${orderid}" value="${ftotal}" 
										onkeyup="var myreg=/^[+]?(([0-9]\d*[.]?)|(0.))(\d{0,2})?$/;if(!myreg.test(this.value)){this.value=''; }; "
										 size="8" maxlength="10" >
								</div> 
							</td>
						</tr>
						<tr>
						<td colspan="7" align="left">
								<div class="orderPay" id="orderAddress_id">
									收货地址:<strong> ${addr}</strong>
								</div>
							</td>
						</tr>
						<tr>
						<td colspan="7" align="left">
								<div class="orderPay" id="orderPay_remarkword_id">
									备&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp注:<strong> ${remark}</strong>
								</div>
							</td>							
						</tr>
						
											
					</tfoot>
				</table>
				<br />
			</s:iterator>
			<table width="800px">
				<tr>
					<td><%@ include file="/common/shopPaging.jspf"%>
					</td>
				</tr>
			</table>
		</form>
	</center>
	</div>
</body>
</html>
