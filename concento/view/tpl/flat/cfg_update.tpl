<form id="form-update-{$id}" data-id="{$id}" class="form-update form-horizontal">
	<div class="row">
		{input type="hidden" name="id" value="{$id}"}
		<div class="col-lg-4">

			{select label="##Product## ##Category-1##" 	name="cfg_type" id="cfg_type" options=$cfg_typeo selected=$cfg_type onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=cfg_subtype&value='+this.options[this.selectedIndex].value;checkCfgType('1');"}
			{select label="##Product## ##Category-2##"  name="cfg_subtype"  id="cfg_subtype" options=$cfg_subtypeo selected=$cfg_subtype onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=cfg_subtype2&value='+this.options[this.selectedIndex].value;checkCfgType('2');"}
			{select label="##Product## ##Category-3##" 	name="cfg_subtype2" id="cfg_subtype2" options=$cfg_subtype2o selected=$cfg_subtype2 onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=cfg_subtype3&value='+this.options[this.selectedIndex].value;checkCfgType('3');"}
			{select label="##Product## ##Category-4##"  name="cfg_subtype3" id="cfg_subtype3" options=$cfg_subtype3o selected=$cfg_subtype3 onchange="checkCfgType('4');"}

			{input label="##Product## ##Codeu##" type="text" id="cfg_code" value="{$cfg_code}" }
			{input label="##Product## ##Name##" type="text" id="cfg_name" value="{$cfg_name}"}
		</div>
		<div class="col-lg-4">
			{input type="text" label="Kişi Kodu" name="cfg_contactcode" value="{$cfg_contactcode}" error="{$cfg_contactcodeerror}"}
		    {input label="Kişi Adı" type="text" id="cfg_contactName" value="{$cfg_contactName}" search="module=xusrinf&context=form-insert&multi_select=0&xusrinf_full=[#cfg_contactName]&xusrinf_type=&unique=cfgxusrinf"}

			{input label="##Ders Sayısı##" name="cfg_level" id="cfg_level" value="{$cfg_level}" }
			{input label="##(%)##" name="cfg_yetkikodu" id="cfg_yetkikodu" value="0" class="numbersOnly" }

			{input label="##Kart Başlangıç##" name="cfg_garantistart" id="cfg_garantistart" value="{$cfg_garantistart}" type="date"}
			{input label="##Kart Bitiş##" name="cfg_garantiend" id="cfg_garantiend" value="{$cfg_garantiend}" type="date" }
		</div>
		<div class="col-lg-4">
			{select label="##Ödeme## ##Statusu##" name="cfg_status"  id="cfg_status" options=$cfg_statuso selected=$cfg_status onchange="checkCfgStatus();"}
			{input label="##Vade Farkı (%)##" name="cfg_productid" id="cfg_productid" value="0" class="numbersOnly"}
			{input label="##Fiyat##" name="cfg_addrnumber" id="cfg_addrnumber" value="{$cfg_addrnumber}" }
			{input label="##Kalan Borç##" name="cfg_maliyet" id="cfg_maliyet" value="{$cfg_maliyet}"}

			{textarea label="##Description##" name="cfg_description" id="gcfg_description" value="{$cfg_description}"}
		</div>
	</div>
	<footer class="row">
		<div class="col-lg-12">
			<div class="btn btn-group pull-right">
				<button type="reset" class="btn btn-info">
					<i class="fa fa-refresh"></i> Sıfırla
				</button>
				<button type="button" class="btn btn-danger delete-record" data-id="{$id}">
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