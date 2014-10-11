<script type="text/javascript" src="{$view_path}js/amcharts-v2/amcharts/amcharts.js"></script>

<style>
{literal}
.amChart {
border:1px solid #CCCCCC;
float:left;
margin-right:10px;
margin-left:8px;
margin-bottom:20px;
}
{/literal}
</style>

<div class="row">
	<div class="col-sm-3 state-overview">
		<section class="panel">
			<div class="symbol red">
				<i class="fa fa-tag"></i>
			</div>
			<div class="value">
				<h1 class="count">{$OpenIssueCount}</h1>
				<p>Toplam Açık Talep</p>
			</div>
		</section>
	</div>
	<div class="col-sm-3 state-overview">
		<section class="panel">
			<div class="symbol green">
				<i class="fa fa-tags"></i>
			</div>
			<div class="value">
				<h1 class=" count2">{$OpenTaskCount}</h1>
				<p>Toplam Açık Görev</p>
			</div>
		</section>
	</div>
	<div class="col-sm-6">
		<section class="panel">
			<div class="panel-heading">
				<i class="fa fa-bullhorn"></i> Güncel Duyurular
			</div>
			<div id="c-slide" class="carousel slide auto panel-body">
				<ol class="carousel-indicators out">
					{foreach key=key item=item from=$messages name=messages}
					<li {if $smarty.foreach.messages.first}class="active" {/if}data-slide-to="{$key}" data-target="#c-slide"></li>
					{/foreach}
				</ol>
				<div class="carousel-inner">
					{foreach key=key item=item from=$messages name=messages}
					<div class="anc-item item {if $smarty.foreach.messages.first}active{/if}">
						{$item|trim}
					</div>
					{/foreach}
				</div>
				<a data-slide="prev" href="#c-slide" class="left carousel-control"> <i class="fa fa-angle-left"></i>
				</a> <a data-slide="next" href="#c-slide" class="right carousel-control"> <i class="fa fa-angle-right"></i>
				</a>
			</div>
		</section>
	</div>
</div>

<div class="row">
	<div class="col-sm-6">
		<div class="panel terques-chart">
			<div class="panel-body dashboard-charts chart-texture">
				<div class="chart issuecat" id="div_barVerticalChart_issueCategory" style="width:100%;height:300px;">
				</div>
			</div>
			<div class="chart-title">
				<span class="title">Arama Nedeni / Gelen Talep Sayıları</span>
			</div>
		</div>
	</div>
	<div class="col-sm-6">
		<div class="panel terques-chart">
			<div class="panel-body dashboard-charts chart-texture">
				<div class="chart issuestatus" id="div_pieChart_issueStatus" style="width:100%;height:300px;">
				</div>
			</div>
			<div class="chart-title">
				<span class="title">Gelen Talep / Statü Dağılımları</span>
			</div>
		</div>
	</div>
</div>

{AmCharts type="pie" div="div_pieChart_issueStatus" assign="pieChart_issueStatus" sql="	SELECT
																	BTS.STATUSNAME,
																	COUNT(*) SAYI
																FROM BMISSUE B
																LEFT OUTER JOIN BMISSUEANDTASKSTATUS BTS
																	ON BTS.CODE = B.ISSUESTATUS
																	AND BTS.TYPE = 'ISSUE'
																	AND BTS.LANG = '0'
																WHERE
																	B.XCMPCODE = '{$smarty.session.SES_COMPANY}'
																GROUP BY BTS.STATUSNAME
																ORDER BY SAYI DESC"
	title="STATUSNAME" value="SAYI" chartOutlinecolor="#FFFFFF" 
	chartOutlineAlpha="0.7" chartOutlineThickness="2" 
	chartRight="10" chartLeft="10" chartBottom="10" chartTop="10" 
	chartEffect="bounce" chartEffectDuration="2" chartDepth="15" chartAngle="30" 
	legendAlign="left" legendMarkType="square" legendPosition="left" legendSwitchType="v" }
	
{AmCharts type="bar" div="div_barVerticalChart_issueCategory" assign="barVerticalChart_issueCategory" sql="	SELECT
																				BC.NAME,
																				COUNT(*) SAYI
																			FROM BMISSUE B
																			LEFT OUTER JOIN BMISSUECATEGORY BC ON BC.CODE = B.CATEGORY1
																			WHERE
																				 B.XCMPCODE = '{$smarty.session.SES_COMPANY}'
																			GROUP BY BC.NAME
																			ORDER BY SAYI DESC"
	title="NAME" value="SAYI" label="" 
	chartRight="10" chartLeft="10" chartBottom="10" chartTop="10" 
	chartEffect="bounce" chartEffectDuration="5" chartLabelRotation="45" 
	axesFillAlpha="1" graphType="column" 
	rotate="true" chartDepth="15" chartAngle="30" 
	catGridPosition="start" catAxisColor="#DADADA" 
	catGridAlpha="0" catFillColor="#FAFAFA" valueColor="#DADADA" 
	valueTitle="Kategoriye Göre Talep Sayısı" valueAlpha="1" lineAlpha="0" 
	graphColor="#bf1c25" graphAlpha="1" catFillAlpha="1"}
	
<script type="text/javascript">
$(document).ready(function() {
	{$pieChart_issueStatus}
	{$barVerticalChart_issueCategory}
});
</script>
