<form id="form-update-{$id}" data-id="{$id}" class="form-update form-horizontal">
	<div class="row">
	{input type="hidden" name="id" value="{$id}"}
	<div class="col-lg-4">
	{input label="##Codeu##" name="bmasgrel_code" id="bmasgrel_code" value="{$bmasgrel_code}" readonly="readonly" }
	 {select label="##Category-1##" name="bmasgrel_category1" id="bmasgrel_category1" options=$bmasgrel_category1o onchange="remotecont.location='xtreecombo.php?context=form-update-{$id}&next=bmasgrel_category2&value='+this.options[this.selectedIndex].value;" }
	 {select label="##Category-2##" name="bmasgrel_category2" id="bmasgrel_category2"  options=$bmasgrel_category2o onchange="remotecont.location='xtreecombo.php?context=form-update-{$id}&next=bmasgrel_category3&value='+this.options[this.selectedIndex].value;" } 
	 {select label="##Category-3##" name="bmasgrel_category3" id="bmasgrel_category3"  options=$bmasgrel_category3o onchange="remotecont.location='xtreecombo.php?context=form-update-{$id}&next=bmasgrel_category4&value='+this.options[this.selectedIndex].value;" } 
	 {select label="##Category-4##" name="bmasgrel_category4" id="bmasgrel_category4"  options=$bmasgrel_category4o } 
	
	</div>
	<div class="col-lg-4">

	{select label="##Talep Durumu##" name="bmasgrel_issuestatus" id="bmasgrel_issuestatus" options=$bmasgrel_issuestatuso selected=$bmasgrel_issuestatus}
	{select label="##Assignment Group##" name="bmasgrel_asggroupcode" id="bmasgrel_asggroupcode" options=$bmasgrel_asggroupcodeo}
	
	</div>
	<div class="col-lg-4">
	
	</div>
	</div>
	<footer class="row">
		<div class="col-lg-12">
			<div class="btn btn-group pull-right">
				<button type="reset" class="btn btn-info">
					<i class="fa fa-refresh"></i> Sıfırla
				</button>
				<button type="button" class="btn btn-warning delete-record" data-id="{$id}">
					<i class="fa fa-trash-o"></i> Sil
				</button>
				<button type="submit" class="btn btn-success form-save update"><i class="fa fa-save"></i> Güncelle</button>
				<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu" style="text-align:left;">
					<li><a href="javascript:;" class="btn-xs form-save update" data-action="close"><i class="fa fa-times"></i> Sekmeyi Kapat</a></li>
				</ul>
			</div>
		</div>
	</footer>
	{include file="treecombo_include.tpl"}
</form>