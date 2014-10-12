<form id="form-search-fields" class="form-horizontal {$module}" data-module="{$module}">
	<div class="row">
		<div class="col-lg-4">

			{select label="##Product## ##Category-1##" 	name="cfg_type" id="cfg_type" options=$cfg_typeo selected=$cfg_type onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=cfg_subtype&value='+this.options[this.selectedIndex].value;checkCfgType('1');"  action="filter-btn fa-plus"}
			{select label="##Product## ##Category-2##"  name="cfg_subtype"  id="cfg_subtype" options=$cfg_subtypeo selected=$cfg_subtype onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=cfg_subtype2&value='+this.options[this.selectedIndex].value;checkCfgType('2');"  action="filter-btn fa-plus"}
			{select label="##Product## ##Category-3##" 	name="cfg_subtype2" id="cfg_subtype2" options=$cfg_subtype2o selected=$cfg_subtype2 onchange="remotecont.location='xtreecombo.php?context=form-insert&context=form-insert&next=cfg_subtype3&value='+this.options[this.selectedIndex].value;checkCfgType('3');"  action="filter-btn fa-plus"}
			{select label="##Product## ##Category-4##"  name="cfg_subtype3" id="cfg_subtype3" options=$cfg_subtype3o selected=$cfg_subtype3 onchange="checkCfgType('4');"  action="filter-btn fa-plus"}

			{select label="##Ödeme## ##Statusu##" name="cfg_status"  id="cfg_status" options=$cfg_statuso selected=$cfg_status onchange="checkCfgStatus();"  action="filter-btn fa-plus"}
			{input label="##Kalan Borç##" name="cfg_maliyet" id="cfg_maliyet" value="{$cfg_maliyet}"  action="filter-btn fa-plus"}
			{input label="##Ders Sayısı##" name="cfg_level" id="cfg_level" value="{$cfg_level}"   action="filter-btn fa-plus"}

			{input label="##Product## ##Codeu##" type="text" id="cfg_code" value="{$cfg_code}"   action="filter-btn fa-plus"}
			{input label="##Product## ##Name##" type="text" id="cfg_name" value="{$cfg_name}"  action="filter-btn fa-plus"}
		</div>
		<div class="col-lg-4">
			{input type="text" label="Kişi Kodu" name="cfg_contactcode" value="{$cfg_contactcode}" error="{$cfg_contactcodeerror}"  action="filter-btn fa-plus"}
		    {input label="Kişi Adı" type="text" id="cfg_contactName" value="{$cfg_contactName}" search="module=xusrinf&context=form-insert&multi_select=0&xusrinf_full=[#cfg_contactName]&xusrinf_type=&unique=cfgxusrinf"  action="filter-btn fa-plus"}

			{input label="##Kart Başlangıç##" name="cfg_garantistart" id="cfg_garantistart" value="{$cfg_garantistart}" type="date"  action="filter-btn fa-plus"}
			{input label="##Kart Bitiş##" name="cfg_garantiend" id="cfg_garantiend" value="{$cfg_garantiend}" type="date"   action="filter-btn fa-plus"}
			{input label="##İndirim oranı (%)##" name="cfg_yetkikodu" id="cfg_yetkikodu" value="0" class="numbersOnly"   action="filter-btn fa-plus"}
			{input label="##Vade Farkı (%)##" name="cfg_productid" id="cfg_productid" value="0" class="numbersOnly"  action="filter-btn fa-plus"}
			{input label="##Fiyat##" name="cfg_addrnumber" id="cfg_addrnumber" value="{$cfg_addrnumber}"   action="filter-btn fa-plus"}

			{input label="##Description##" name="cfg_description" id="gcfg_description" value="{$cfg_description}"  action="filter-btn fa-plus"}
		</div>
		<div class="col-lg-4">
			{include file="xlistview_filter.tpl"}
		</div>
	</div>
	<footer class="row">
		<div class="col-lg-12">
			<div class="btn pull-right">
				<button class="btn btn-info" type="reset">
					<i class="fa fa-refresh"></i> Sıfırla
				</button>
				<button class="btn btn-danger form-search-submit" type="button">
					<i class="fa fa-search"></i> Ara
				</button>
			</div>
		</div>
	</footer>
</form>

