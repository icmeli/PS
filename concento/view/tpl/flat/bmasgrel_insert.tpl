<form id="form-insert" class="form-horizontal">
	<div class="row">
	<div class="col-lg-4">
	 {input label="##Codeu##" name="bmasgrel_code" id="bmasgrel_code" value="{$bmasgrel_code}" readonly="readonly" }
	 {select label="##Category-1##" name="bmasgrel_category1" id="bmasgrel_category1" options=$bmasgrel_category1o onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=bmasgrel_category2&value='+this.options[this.selectedIndex].value;" }
	 {select label="##Category-2##" name="bmasgrel_category2" id="bmasgrel_category2"  options=$bmasgrel_category2o onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=bmasgrel_category3&value='+this.options[this.selectedIndex].value;" } 
	 {select label="##Category-3##" name="bmasgrel_category3" id="bmasgrel_category3"  options=$bmasgrel_category3o onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=bmasgrel_category4&value='+this.options[this.selectedIndex].value;" } 
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
			<div class="btn pull-right">
				<button type="reset" class="btn btn-info">
					<i class="fa fa-refresh"></i> Sıfırla
				</button>
				<div class="btn-group">
					<button type="submit" class="btn btn-success form-save"><i class="fa fa-save"></i> Kaydet</button>
					<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu" style="text-align:left;">
						<li><a href="javascript:;" class="btn-xs form-save" data-action="edit"><i class="fa fa-edit"></i> Düzenle</a></li>
						<li><a href="javascript:;" class="btn-xs form-save" data-action="reset"><i class="fa fa-refresh"></i> Formu temizle</a></li>
						<li><a href="javascript:;" class="btn-xs form-save" data-action="list"><i class="fa fa-list"></i> Listele</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>
</form>